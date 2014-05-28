package com.ankamagames.dofus.kernel.sound
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.kernel.sound.manager.ISoundManager;
   import com.ankamagames.tubul.types.TubulOptions;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.dofus.kernel.sound.manager.RegConnectionManager;
   import com.ankamagames.jerakine.protocolAudio.ProtocolEnum;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   
   public class SoundManager extends Object
   {
      
      public function SoundManager() {
         super();
         if(_self)
         {
            throw new Error("Warning : SoundManager is a singleton class and shoulnd\'t be instancied directly!");
         }
         else
         {
            return;
         }
      }
      
      protected static const _log:Logger;
      
      private static var _self:SoundManager;
      
      public static function getInstance() : SoundManager {
         if(!_self)
         {
            _self = new SoundManager();
         }
         return _self;
      }
      
      public var manager:ISoundManager;
      
      private var _tuOptions:TubulOptions;
      
      public function get options() : TubulOptions {
         return this._tuOptions;
      }
      
      public function setSoundOptions() : void {
         var musicMute:Boolean = false;
         var soundMute:Boolean = false;
         var ambientSoundMute:Boolean = false;
         var infiniteLoop:Boolean = false;
         var soundActivated:Boolean = false;
         var obj:* = undefined;
         var commonMod:Object = null;
         try
         {
            musicMute = OptionManager.getOptionManager("tubul")["muteMusic"];
            soundMute = OptionManager.getOptionManager("tubul")["muteSound"];
            ambientSoundMute = OptionManager.getOptionManager("tubul")["muteAmbientSound"];
            infiniteLoop = OptionManager.getOptionManager("tubul")["infiniteLoopMusics"];
            this.setMusicVolume(musicMute?0:OptionManager.getOptionManager("tubul")["volumeMusic"]);
            this.setSoundVolume(soundMute?0:OptionManager.getOptionManager("tubul")["volumeSound"]);
            this.setAmbienceVolume(ambientSoundMute?0:OptionManager.getOptionManager("tubul")["volumeAmbientSound"]);
            RegConnectionManager.getInstance().send(ProtocolEnum.OPTION_MUSIC_LOOP_VALUE_CHANGED,infiniteLoop);
            soundActivated = OptionManager.getOptionManager("tubul")["tubulIsDesactivated"];
            if(soundActivated)
            {
               this.manager.deactivateSound();
            }
         }
         catch(e:Error)
         {
            _log.warn("Une erreur est survenue lors de la récupération/application des paramètres audio (option audio)");
            try
            {
               obj = UiModuleManager.getInstance().getModule("Ankama_Common");
               if(obj == null)
               {
                  return;
               }
               commonMod = obj.mainClass;
               commonMod.openPopup(I18n.getUiText("ui.popup.warning"),I18n.getUiText("ui.common.soundsDeactivated"),[I18n.getUiText("ui.common.ok")]);
            }
            catch(error:Error)
            {
               _log.warn("Nous n\'étions probablement pas encore en jeu, ni en pré jeu");
            }
         }
      }
      
      public function setDisplayOptions(pOptions:TubulOptions) : void {
         this._tuOptions = pOptions;
         this._tuOptions.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         this.setSoundOptions();
      }
      
      public function checkSoundDirectory() : void {
         this.manager.soundDirectoryExist = true;
      }
      
      public function setMusicVolume(pVolume:Number) : void {
         if(!this.manager.soundIsActivate)
         {
            return;
         }
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_MUSIC_ID,pVolume);
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_FIGHT_MUSIC_ID,pVolume);
      }
      
      public function setSoundVolume(pVolume:Number) : void {
         if(!this.manager.soundIsActivate)
         {
            return;
         }
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_UI_ID,pVolume);
      }
      
      public function setAmbienceVolume(pVolume:Number) : void {
         if(!this.manager.soundIsActivate)
         {
            return;
         }
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_AMBIENT_2D_ID,pVolume);
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_AMBIENT_3D_ID,pVolume);
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_BARKS_ID,pVolume);
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_FIGHT_ID,pVolume);
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_GFX_ID,pVolume);
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_NPC_FOLEYS_ID,pVolume);
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_SFX_ID,pVolume);
      }
      
      private function onPropertyChanged(e:PropertyChangeEvent) : void {
         switch(e.propertyName)
         {
            case "muteMusic":
               this.setMusicVolume(e.propertyValue?0:this._tuOptions.volumeMusic);
               break;
            case "muteSound":
               this.setSoundVolume(e.propertyValue?0:this._tuOptions.volumeSound);
               break;
            case "muteAmbientSound":
               this.setAmbienceVolume(e.propertyValue?0:this._tuOptions.volumeAmbientSound);
               break;
            case "volumeMusic":
               if(this._tuOptions.muteMusic == false)
               {
                  this.setMusicVolume(e.propertyValue);
               }
               break;
            case "volumeSound":
               if(this._tuOptions.muteSound == false)
               {
                  this.setSoundVolume(e.propertyValue);
               }
               break;
            case "volumeAmbientSound":
               if(this._tuOptions.muteAmbientSound == false)
               {
                  this.setAmbienceVolume(e.propertyValue);
               }
               break;
            case "tubulIsDesactivated":
               if(e.propertyValue == true)
               {
                  this.manager.deactivateSound();
               }
               if(e.propertyValue == false)
               {
                  this.manager.activateSound();
               }
               break;
            case "playSoundForGuildMessage":
               trace("playSoundForGuildMessage : " + e.propertyValue);
               break;
            case "playSoundAtTurnStart":
               trace("playSoundAtTurnStart : " + e.propertyValue);
               break;
            case "infiniteLoopMusics":
               trace("infiniteLoopMusics : " + e.propertyValue);
               RegConnectionManager.getInstance().send(ProtocolEnum.OPTION_MUSIC_LOOP_VALUE_CHANGED,e.propertyValue);
               break;
         }
      }
   }
}
