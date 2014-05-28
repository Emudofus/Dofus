package com.ankamagames.dofus.kernel.sound.manager
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.datacenter.ambientSounds.AmbientSound;
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tubul.types.VolumeFadeEffect;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.sound.TubulSoundConfiguration;
   import com.ankamagames.dofus.kernel.sound.utils.SoundUtil;
   import com.ankamagames.tubul.factory.SoundFactory;
   import com.ankamagames.tubul.enum.EnumSoundType;
   import com.ankamagames.dofus.kernel.sound.type.SoundDofus;
   import com.ankamagames.jerakine.protocolAudio.ProtocolEnum;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   
   public class AmbientSoundsManager extends Object
   {
      
      public function AmbientSoundsManager() {
         super();
         this.init();
      }
      
      private static const _log:Logger;
      
      private var _useCriterion:Boolean = false;
      
      private var _criterionID:uint;
      
      private var _ambientSounds:Vector.<AmbientSound>;
      
      private var _roleplayMusics:Vector.<AmbientSound>;
      
      private var _music:ISound;
      
      private var _previousMusic:ISound;
      
      private var _ambience:ISound;
      
      private var _previousAmbience:ISound;
      
      private var _musicA:AmbientSound;
      
      private var _ambienceA:AmbientSound;
      
      private var _previousMusicId:int;
      
      private var _previousAmbienceId:int;
      
      private var tubulOption:OptionManager;
      
      public function get music() : ISound {
         return this._music;
      }
      
      public function get ambience() : ISound {
         return this._ambience;
      }
      
      public function get criterionID() : uint {
         return this._criterionID;
      }
      
      public function set criterionID(pCriterionID:uint) : void {
         this._criterionID = pCriterionID;
      }
      
      public function get ambientSounds() : Vector.<AmbientSound> {
         return this._ambientSounds;
      }
      
      public function setAmbientSounds(pAmbiant:Vector.<AmbientSound>, pMusic:Vector.<AmbientSound>) : void {
         var asound:AmbientSound = null;
         this._ambientSounds = pAmbiant;
         this._roleplayMusics = pMusic;
         var logText:String = "";
         if((this._ambientSounds.length == 0) && (this._roleplayMusics.length == 0))
         {
            logText = "Ni musique ni ambiance pour cette map ??!!";
         }
         else
         {
            logText = "Cette map contient les ambiances d\'id : ";
            for each(asound in this._ambientSounds)
            {
               logText = logText + (asound.id + ", ");
            }
            logText = logText + " et les musiques d\'id : ";
            for each(asound in this._roleplayMusics)
            {
               logText = logText + (asound.id + ", ");
            }
         }
         _log.info(logText);
      }
      
      public function selectValidSounds() : void {
         var ambientSound:AmbientSound = null;
         var rnd:* = 0;
         var count:int = 0;
         for each(ambientSound in this._ambientSounds)
         {
            if((!this._useCriterion) || (ambientSound.criterionId == this._criterionID))
            {
               count++;
            }
         }
         rnd = int(Math.random() * count);
         for each(ambientSound in this._ambientSounds)
         {
            if((!this._useCriterion) || (ambientSound.criterionId == this._criterionID))
            {
               if(rnd == 0)
               {
                  this._ambienceA = ambientSound;
                  break;
               }
               rnd--;
            }
         }
         count = 0;
         for each(ambientSound in this._roleplayMusics)
         {
            if((!this._useCriterion) || (ambientSound.criterionId == this._criterionID))
            {
               count++;
            }
         }
         rnd = int(Math.random() * count);
         for each(ambientSound in this._roleplayMusics)
         {
            if((!this._useCriterion) || (ambientSound.criterionId == this._criterionID))
            {
               if(rnd == 0)
               {
                  this._musicA = ambientSound;
                  break;
               }
               rnd--;
            }
         }
      }
      
      public function playMusicAndAmbient() : void {
         var soundPathA:String = null;
         var soundUriA:Uri = null;
         var fade:VolumeFadeEffect = null;
         var fadeOut:VolumeFadeEffect = null;
         var soundPathM:String = null;
         var soundUriM:Uri = null;
         var fadeMusic:VolumeFadeEffect = null;
         var fadeOutMusic:VolumeFadeEffect = null;
         if(!SoundManager.getInstance().manager.soundIsActivate)
         {
            return;
         }
         if((SoundManager.getInstance().manager is RegSoundManager) && (!RegConnectionManager.getInstance().isMain))
         {
            return;
         }
         if(this._ambienceA == null)
         {
            _log.warn("It seems that we have no ambiance for this map");
         }
         else
         {
            if(this._previousAmbienceId == this._ambienceA.id)
            {
               _log.warn("Same ambiance as in the previous map, we just adjust its volume");
               this._ambience.volume = this._ambienceA.volume / 100;
            }
            else
            {
               if(this._previousAmbience != null)
               {
                  fadeOut = new VolumeFadeEffect(-1,0,TubulSoundConfiguration.TIME_FADE_OUT_AMBIANCE);
                  this._previousAmbience.stop(fadeOut);
               }
               soundPathA = SoundUtil.getConfigEntryByBusId(this._ambienceA.channel);
               soundUriA = new Uri(soundPathA + this._ambienceA.id + ".mp3");
               if(SoundManager.getInstance().manager is ClassicSoundManager)
               {
                  this._ambience = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND,soundUriA);
                  this._ambience.busId = this._ambienceA.channel;
               }
               if(SoundManager.getInstance().manager is RegSoundManager)
               {
                  this._ambience = new SoundDofus(String(this._ambienceA.id));
               }
               this._ambience.volume = this._ambienceA.volume / 100;
               this._ambience.currentFadeVolume = 0;
               fade = new VolumeFadeEffect(-1,1,TubulSoundConfiguration.TIME_FADE_IN_AMBIANCE);
               this._ambience.play(true,0,fade);
            }
            this._previousAmbienceId = this._ambienceA.id;
         }
         this._previousAmbience = this._ambience;
         if(this._musicA == null)
         {
            _log.warn("It seems that we have no music for this map");
         }
         else
         {
            if(this._previousMusicId == this._musicA.id)
            {
               _log.warn("Same music as in the previous map");
            }
            else
            {
               if(this._previousMusic != null)
               {
                  fadeOutMusic = new VolumeFadeEffect(-1,0,TubulSoundConfiguration.TIME_FADE_OUT_MUSIC);
                  this._previousMusic.stop(fadeOutMusic);
               }
               soundPathM = SoundUtil.getConfigEntryByBusId(this._musicA.channel);
               soundUriM = new Uri(soundPathM + this._musicA.id + ".mp3");
               if(SoundManager.getInstance().manager is ClassicSoundManager)
               {
                  this._music = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND,soundUriM);
                  this._music.busId = this._musicA.channel;
               }
               if(SoundManager.getInstance().manager is RegSoundManager)
               {
                  this._music = new SoundDofus(String(this._musicA.id));
               }
               RegConnectionManager.getInstance().send(ProtocolEnum.SET_SILENCE,this._musicA.silenceMin,this._musicA.silenceMax);
               this._music.volume = this._musicA.volume / 100;
               this._music.currentFadeVolume = 0;
               this.tubulOption = OptionManager.getOptionManager("tubul");
               if(this.tubulOption["infiniteLoopMusics"])
               {
                  this._music.play(true,0);
               }
               else
               {
                  this._music.play(true,TubulSoundConfiguration.MUSIC_LOOPS);
               }
               this.tubulOption.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
               fadeMusic = new VolumeFadeEffect(-1,1,TubulSoundConfiguration.TIME_FADE_IN_MUSIC);
               fadeMusic.attachToSoundSource(this._music);
               fadeMusic.start();
            }
            this._previousMusicId = this._musicA.id;
         }
         this._previousMusic = this._music;
      }
      
      public function stopMusicAndAmbient() : void {
         if(this.ambience)
         {
            this.ambience.stop();
         }
         if(this.music)
         {
            this.music.stop();
         }
         this._previousAmbienceId = -1;
         this._previousMusicId = -1;
         if(this.tubulOption)
         {
            this.tubulOption.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         }
      }
      
      public function mergeSoundsArea(pAmbientSounds:Vector.<AmbientSound>) : void {
      }
      
      public function clear(pFade:Number = 0, pFadeTime:Number = 0) : void {
         this.stopMusicAndAmbient();
      }
      
      private function init() : void {
      }
      
      private function onPropertyChanged(pEvent:PropertyChangeEvent) : void {
         if(pEvent.propertyName != "infiniteLoopMusics")
         {
            return;
         }
         trace("On a changé l\'option d\'écoute en boucle des musiques : " + pEvent.propertyValue);
         RegConnectionManager.getInstance().send(ProtocolEnum.OPTION_MUSIC_LOOP_VALUE_CHANGED,pEvent.propertyValue);
      }
   }
}
