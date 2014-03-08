package com.ankamagames.tubul.types
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
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
      
      public function PlayList(param1:Boolean=false, param2:Boolean=false, param3:SoundSilence=null, param4:VolumeFadeEffect=null, param5:VolumeFadeEffect=null) {
         super();
         this.shuffle = param1;
         this.loop = param2;
         this._silence = param3;
         this._fadeIn = param4;
         this._fadeOut = param5;
         if(this._silence)
         {
            this.playSilenceBetweenTwoSounds(true,this._silence);
         }
         this.init();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PlayList));
      
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
         var _loc1_:uint = 0;
         if(this._isPlaying)
         {
            _loc1_ = this._sounds.indexOf(this._playingSound);
            return _loc1_;
         }
         return -1;
      }
      
      public function get playSilence() : Boolean {
         return this._playSilence;
      }
      
      public function get running() : Boolean {
         return this._isPlaying;
      }
      
      public function addSound(param1:ISound) : uint {
         this._sounds.push(param1);
         this._balanceManager.addItem(param1);
         return this._sounds.length;
      }
      
      public function removeSound(param1:ISound) : uint {
         var _loc2_:int = this._sounds.indexOf(param1);
         if(_loc2_ != -1)
         {
            if(param1.isPlaying)
            {
               param1.stop();
            }
            this._balanceManager.removeItem(param1);
            this._sounds.splice(_loc2_,1);
         }
         return this._sounds.length;
      }
      
      public function removeSoundBySoundId(param1:String, param2:Boolean=true) : uint {
         var _loc3_:ISound = null;
         var _loc4_:* = 0;
         for each (_loc3_ in this._sounds)
         {
            if(_loc3_.uri.fileName.split(".")[0] == param1)
            {
               _loc4_ = this._sounds.indexOf(_loc3_);
               if(_loc4_ != -1)
               {
                  if(_loc3_.isPlaying)
                  {
                     _loc3_.stop();
                  }
                  this._balanceManager.removeItem(_loc3_);
                  this._sounds.splice(_loc4_,1);
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
         if((this._sounds) && this._sounds.length > 0)
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
      
      public function nextSound(param1:VolumeFadeEffect=null, param2:Boolean=false) : void {
         var _loc3_:* = 0;
         if((param2) && (this._playingSound))
         {
            this._playingSound.stop(param1);
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
               _loc3_ = this._sounds.indexOf(this._playingSound);
               if(_loc3_ == this._sounds.length-1)
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
                  this._playingSound = this._sounds[_loc3_ + 1] as ISound;
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
      
      public function stop(param1:VolumeFadeEffect=null) : void {
         if(this._playingSound == null)
         {
            return;
         }
         if(param1)
         {
            param1.attachToSoundSource(this._playingSound);
            param1.addEventListener(FadeEvent.COMPLETE,this.onFadeOutStopPlaylistComplete);
            param1.start();
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
      
      public function playSilenceBetweenTwoSounds(param1:Boolean=false, param2:SoundSilence=null) : void {
         this._playSilence = param1;
         if(param1 == false && !(this._silence == null))
         {
            this._silence.clean();
            this._silence = null;
            return;
         }
         if(param1 == true)
         {
            if(param2 == null && this._silence == null)
            {
               _log.error("Aucun silence à jouer !");
               this._playSilence = false;
               return;
            }
            if(param2 != null)
            {
               if(this._silence != null)
               {
                  this._silence.clean();
               }
               this._silence = param2;
            }
            return;
         }
      }
      
      private function init() : void {
         var _loc1_:ISound = null;
         if(this._silence)
         {
            this._silence.clean();
         }
         if(this._sounds)
         {
            for each (_loc1_ in this._sounds)
            {
               _loc1_.stop();
               _loc1_ = null;
            }
         }
         this._sounds = new Vector.<ISound>();
         this._balanceManager = new BalanceManager();
         this._isPlaying = false;
      }
      
      private function playSound(param1:ISound) : void {
         var _loc3_:* = false;
         var _loc4_:VolumeFadeEffect = null;
         var _loc5_:VolumeFadeEffect = null;
         var _loc6_:PlaylistEvent = null;
         this._playingSound = param1;
         this._playingSound.eventDispatcher.addEventListener(SoundCompleteEvent.SOUND_COMPLETE,this.onSoundComplete,false,EventListenerPriority.NORMAL);
         var _loc2_:IAudioBus = this._playingSound.bus;
         if(_loc2_ != null)
         {
            _loc3_ = false;
            if(this._playingSound.totalLoops > -1)
            {
               _loc3_ = true;
            }
            if(this._fadeIn)
            {
               _loc4_ = this._fadeIn.clone();
            }
            if(this._fadeOut)
            {
               _loc5_ = this._fadeOut.clone();
            }
            this._playingSound.play(_loc3_,this._playingSound.totalLoops,_loc4_,_loc5_);
            _loc6_ = new PlaylistEvent(PlaylistEvent.NEW_SOUND);
            _loc6_.newSound = this._playingSound;
            dispatchEvent(_loc6_);
         }
      }
      
      private function onSoundComplete(param1:SoundCompleteEvent) : void {
         this._playingSound.eventDispatcher.removeEventListener(SoundCompleteEvent.SOUND_COMPLETE,this.onSoundComplete);
         if((this._playSilence) && !(this._silence == null))
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
            param1.stopImmediatePropagation();
            this.nextSound();
         }
      }
      
      private function onSilenceComplete(param1:SoundSilenceEvent) : void {
         var _loc2_:SoundCompleteEvent = new SoundCompleteEvent(SoundCompleteEvent.SOUND_COMPLETE);
         _loc2_.sound = this.playingSound;
         dispatchEvent(_loc2_);
         _log.info("Playlist silence End");
         this.nextSound();
      }
      
      private function onFadeOutStopPlaylistComplete(param1:FadeEvent) : void {
         this.stop();
      }
   }
}
