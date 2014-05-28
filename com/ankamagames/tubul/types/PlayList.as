package com.ankamagames.tubul.types
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.jerakine.BalanceManager.BalanceManager;
   import com.ankamagames.tubul.events.PlaylistEvent;
   import com.ankamagames.tubul.events.FadeEvent;
   import com.ankamagames.tubul.events.SoundCompleteEvent;
   import com.ankamagames.tubul.enum.EventListenerPriority;
   import com.ankamagames.tubul.interfaces.IAudioBus;
   import com.ankamagames.tubul.events.SoundSilenceEvent;
   
   public class PlayList extends EventDispatcher
   {
      
      public function PlayList(pShuffle:Boolean = false, pLoop:Boolean = false, pSilence:SoundSilence = null, pFadeIn:VolumeFadeEffect = null, pFadeOut:VolumeFadeEffect = null) {
         super();
         this.shuffle = pShuffle;
         this.loop = pLoop;
         this._silence = pSilence;
         this._fadeIn = pFadeIn;
         this._fadeOut = pFadeOut;
         if(this._silence)
         {
            this.playSilenceBetweenTwoSounds(true,this._silence);
         }
         this.init();
      }
      
      protected static const _log:Logger;
      
      private var _sounds:Vector.<ISound>;
      
      private var _playingSound:ISound;
      
      private var _playedSoundsId:Vector.<int>;
      
      public var shuffle:Boolean;
      
      public var loop:Boolean;
      
      private var _isPlaying:Boolean = false;
      
      private var _balanceManager:BalanceManager;
      
      private var _playSilence:Boolean = false;
      
      private var _silence:SoundSilence;
      
      private var _fadeIn:VolumeFadeEffect;
      
      private var _fadeOut:VolumeFadeEffect;
      
      public function get tracklist() : Vector.<ISound> {
         return this._sounds;
      }
      
      public function get playingSound() : ISound {
         if(this._isPlaying)
         {
            return this._playingSound;
         }
         return null;
      }
      
      public function get playingSoundIndex() : int {
         var index:uint = 0;
         if(this._isPlaying)
         {
            index = this._sounds.indexOf(this._playingSound);
            return index;
         }
         return -1;
      }
      
      public function get playSilence() : Boolean {
         return this._playSilence;
      }
      
      public function get running() : Boolean {
         return this._isPlaying;
      }
      
      public function addSound(pSound:ISound) : uint {
         this._sounds.push(pSound);
         this._balanceManager.addItem(pSound);
         return this._sounds.length;
      }
      
      public function removeSound(pSound:ISound) : uint {
         var index:int = this._sounds.indexOf(pSound);
         if(index != -1)
         {
            if(pSound.isPlaying)
            {
               pSound.stop();
            }
            this._balanceManager.removeItem(pSound);
            this._sounds.splice(index,1);
         }
         return this._sounds.length;
      }
      
      public function removeSoundBySoundId(pSoundId:String, pRemoveAll:Boolean = true) : uint {
         var sound:ISound = null;
         var index:* = 0;
         for each(sound in this._sounds)
         {
            if(sound.uri.fileName.split(".")[0] == pSoundId)
            {
               index = this._sounds.indexOf(sound);
               if(index != -1)
               {
                  if(sound.isPlaying)
                  {
                     sound.stop();
                  }
                  this._balanceManager.removeItem(sound);
                  this._sounds.splice(index,1);
               }
            }
         }
         return this._sounds.length;
      }
      
      public function play() : void {
         if(this._isPlaying)
         {
            return;
         }
         if((this._sounds) && (this._sounds.length > 0))
         {
            this._isPlaying = true;
            if(this.shuffle)
            {
               this._playingSound = this._balanceManager.callItem() as ISound;
            }
            else
            {
               this._playingSound = this._sounds[0] as ISound;
            }
            this.playSound(this._playingSound);
         }
      }
      
      public function nextSound(pFadeOutCurrentSound:VolumeFadeEffect = null, pPlaySilenceBefore:Boolean = false) : void {
         var index:* = 0;
         if((pPlaySilenceBefore) && (this._playingSound))
         {
            this._playingSound.stop(pFadeOutCurrentSound);
         }
         else
         {
            this._playingSound = null;
            if(this.shuffle)
            {
               this._playingSound = this._balanceManager.callItem() as ISound;
            }
            else
            {
               index = this._sounds.indexOf(this._playingSound);
               if(index == this._sounds.length - 1)
               {
                  _log.info("We reached the end of the playlist.");
                  if(this.loop)
                  {
                     _log.info("Playlist is in loop mode. Looping.");
                     this._playingSound = this._sounds[0] as ISound;
                  }
                  else
                  {
                     _log.info("Playlist stop.");
                     this._playingSound = null;
                  }
                  dispatchEvent(new PlaylistEvent(PlaylistEvent.COMPLETE));
               }
               else
               {
                  this._playingSound = this._sounds[index + 1] as ISound;
               }
            }
            if(this._playingSound)
            {
               this.playSound(this._playingSound);
            }
         }
      }
      
      public function previousSound() : void {
         switch(this.shuffle)
         {
            case true:
               break;
            case false:
               break;
         }
      }
      
      public function stop(pFadeOut:VolumeFadeEffect = null) : void {
         if(this._playingSound == null)
         {
            return;
         }
         if(pFadeOut)
         {
            pFadeOut.attachToSoundSource(this._playingSound);
            pFadeOut.addEventListener(FadeEvent.COMPLETE,this.onFadeOutStopPlaylistComplete);
            pFadeOut.start();
         }
         else
         {
            this._playingSound.eventDispatcher.removeEventListener(SoundCompleteEvent.SOUND_COMPLETE,this.onSoundComplete);
            this._playingSound.stop();
            this._isPlaying = false;
            dispatchEvent(new PlaylistEvent(PlaylistEvent.COMPLETE));
         }
      }
      
      public function reset() : void {
         this.stop();
         this.init();
      }
      
      public function playSilenceBetweenTwoSounds(pPlay:Boolean = false, pSilence:SoundSilence = null) : void {
         this._playSilence = pPlay;
         if((pPlay == false) && (!(this._silence == null)))
         {
            this._silence.clean();
            this._silence = null;
            return;
         }
         if(pPlay == true)
         {
            if((pSilence == null) && (this._silence == null))
            {
               _log.error("Aucun silence à jouer !");
               this._playSilence = false;
               return;
            }
            if(pSilence != null)
            {
               if(this._silence != null)
               {
                  this._silence.clean();
               }
               this._silence = pSilence;
            }
            return;
         }
      }
      
      private function init() : void {
         var s:ISound = null;
         if(this._silence)
         {
            this._silence.clean();
         }
         if(this._sounds)
         {
            for each(s in this._sounds)
            {
               s.stop();
               s = null;
            }
         }
         this._sounds = new Vector.<ISound>();
         this._balanceManager = new BalanceManager();
         this._isPlaying = false;
      }
      
      private function playSound(pSound:ISound) : void {
         var loop:* = false;
         var fadeIn:VolumeFadeEffect = null;
         var fadeOut:VolumeFadeEffect = null;
         var event:PlaylistEvent = null;
         this._playingSound = pSound;
         this._playingSound.eventDispatcher.addEventListener(SoundCompleteEvent.SOUND_COMPLETE,this.onSoundComplete,false,EventListenerPriority.NORMAL);
         var bus:IAudioBus = this._playingSound.bus;
         if(bus != null)
         {
            loop = false;
            if(this._playingSound.totalLoops > -1)
            {
               loop = true;
            }
            if(this._fadeIn)
            {
               fadeIn = this._fadeIn.clone();
            }
            if(this._fadeOut)
            {
               fadeOut = this._fadeOut.clone();
            }
            this._playingSound.play(loop,this._playingSound.totalLoops,fadeIn,fadeOut);
            event = new PlaylistEvent(PlaylistEvent.NEW_SOUND);
            event.newSound = this._playingSound;
            dispatchEvent(event);
         }
      }
      
      private function onSoundComplete(pEvent:SoundCompleteEvent) : void {
         this._playingSound.eventDispatcher.removeEventListener(SoundCompleteEvent.SOUND_COMPLETE,this.onSoundComplete);
         if((this._playSilence) && (!(this._silence == null)))
         {
            if(!this._silence.hasEventListener(SoundSilenceEvent.COMPLETE))
            {
               this._silence.addEventListener(SoundSilenceEvent.COMPLETE,this.onSilenceComplete);
            }
            _log.info("Playlist silence Start");
            this._silence.start();
         }
         else
         {
            pEvent.stopImmediatePropagation();
            this.nextSound();
         }
      }
      
      private function onSilenceComplete(pEvent:SoundSilenceEvent) : void {
         var e:SoundCompleteEvent = new SoundCompleteEvent(SoundCompleteEvent.SOUND_COMPLETE);
         e.sound = this.playingSound;
         dispatchEvent(e);
         _log.info("Playlist silence End");
         this.nextSound();
      }
      
      private function onFadeOutStopPlaylistComplete(pEvent:FadeEvent) : void {
         this.stop();
      }
   }
}
