package com.ankamagames.dofus.kernel.sound
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.sound.manager.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.protocolAudio.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.tubul.types.*;
    import flash.utils.*;

    public class SoundManager extends Object
    {
        public var manager:ISoundManager;
        private var _tuOptions:TubulOptions;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SoundManager));
        private static var _self:SoundManager;

        public function SoundManager()
        {
            if (_self)
            {
                throw new Error("Warning : SoundManager is a singleton class and shoulnd\'t be instancied directly!");
            }
            return;
        }// end function

        public function get options() : TubulOptions
        {
            return this._tuOptions;
        }// end function

        public function setSoundOptions() : void
        {
            var musicMute:Boolean;
            var soundMute:Boolean;
            var ambientSoundMute:Boolean;
            var infiniteLoop:Boolean;
            var soundActivated:Boolean;
            var obj:*;
            var commonMod:Object;
            try
            {
                musicMute = OptionManager.getOptionManager("tubul")["muteMusic"];
                soundMute = OptionManager.getOptionManager("tubul")["muteSound"];
                ambientSoundMute = OptionManager.getOptionManager("tubul")["muteAmbientSound"];
                infiniteLoop = OptionManager.getOptionManager("tubul")["infiniteLoopMusics"];
                this.setMusicVolume(musicMute ? (0) : (OptionManager.getOptionManager("tubul")["volumeMusic"]));
                this.setSoundVolume(soundMute ? (0) : (OptionManager.getOptionManager("tubul")["volumeSound"]));
                this.setAmbienceVolume(ambientSoundMute ? (0) : (OptionManager.getOptionManager("tubul")["volumeAmbientSound"]));
                RegConnectionManager.getInstance().send(ProtocolEnum.OPTION_MUSIC_LOOP_VALUE_CHANGED, infiniteLoop);
                soundActivated = OptionManager.getOptionManager("tubul")["tubulIsDesactivated"];
                if (soundActivated)
                {
                    this.manager.deactivateSound();
                }
            }
            catch (e:Error)
            {
                _log.warn("Une erreur est survenue lors de la récupération/application des paramètres audio (option audio)");
                try
                {
                    obj = UiModuleManager.getInstance().getModule("Ankama_Common");
                    if (obj == null)
                    {
                        return;
                    }
                    commonMod = obj.mainClass;
                    commonMod.openPopup(I18n.getUiText("ui.popup.warning"), I18n.getUiText("ui.common.soundsDeactivated"), [I18n.getUiText("ui.common.ok")]);
                }
                catch (error:Error)
                {
                    _log.warn("Nous n\'étions probablement pas encore en jeu, ni en pré jeu");
                }
                return;
        }// end function

        public function setDisplayOptions(param1:TubulOptions) : void
        {
            this._tuOptions = param1;
            this._tuOptions.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            this.setSoundOptions();
            return;
        }// end function

        public function checkSoundDirectory() : void
        {
            this.manager.soundDirectoryExist = true;
            return;
        }// end function

        public function setMusicVolume(param1:Number) : void
        {
            if (!this.manager.soundIsActivate)
            {
                return;
            }
            this.manager.setBusVolume(TubulSoundConfiguration.BUS_MUSIC_ID, param1);
            this.manager.setBusVolume(TubulSoundConfiguration.BUS_FIGHT_MUSIC_ID, param1);
            return;
        }// end function

        public function setSoundVolume(param1:Number) : void
        {
            if (!this.manager.soundIsActivate)
            {
                return;
            }
            this.manager.setBusVolume(TubulSoundConfiguration.BUS_UI_ID, param1);
            return;
        }// end function

        public function setAmbienceVolume(param1:Number) : void
        {
            if (!this.manager.soundIsActivate)
            {
                return;
            }
            this.manager.setBusVolume(TubulSoundConfiguration.BUS_AMBIENT_2D_ID, param1);
            this.manager.setBusVolume(TubulSoundConfiguration.BUS_AMBIENT_3D_ID, param1);
            this.manager.setBusVolume(TubulSoundConfiguration.BUS_BARKS_ID, param1);
            this.manager.setBusVolume(TubulSoundConfiguration.BUS_FIGHT_ID, param1);
            this.manager.setBusVolume(TubulSoundConfiguration.BUS_GFX_ID, param1);
            this.manager.setBusVolume(TubulSoundConfiguration.BUS_NPC_FOLEYS_ID, param1);
            this.manager.setBusVolume(TubulSoundConfiguration.BUS_SFX_ID, param1);
            return;
        }// end function

        private function onPropertyChanged(event:PropertyChangeEvent) : void
        {
            switch(event.propertyName)
            {
                case "muteMusic":
                {
                    this.setMusicVolume(event.propertyValue ? (0) : (this._tuOptions.volumeMusic));
                    break;
                }
                case "muteSound":
                {
                    this.setSoundVolume(event.propertyValue ? (0) : (this._tuOptions.volumeSound));
                    break;
                }
                case "muteAmbientSound":
                {
                    this.setAmbienceVolume(event.propertyValue ? (0) : (this._tuOptions.volumeAmbientSound));
                    break;
                }
                case "volumeMusic":
                {
                    if (this._tuOptions.muteMusic == false)
                    {
                        this.setMusicVolume(event.propertyValue);
                    }
                    break;
                }
                case "volumeSound":
                {
                    if (this._tuOptions.muteSound == false)
                    {
                        this.setSoundVolume(event.propertyValue);
                    }
                    break;
                }
                case "volumeAmbientSound":
                {
                    if (this._tuOptions.muteAmbientSound == false)
                    {
                        this.setAmbienceVolume(event.propertyValue);
                    }
                    break;
                }
                case "tubulIsDesactivated":
                {
                    if (event.propertyValue == true)
                    {
                        this.manager.deactivateSound();
                    }
                    if (event.propertyValue == false)
                    {
                        this.manager.activateSound();
                    }
                    break;
                }
                case "playSoundForGuildMessage":
                {
                    break;
                }
                case "playSoundAtTurnStart":
                {
                    break;
                }
                case "infiniteLoopMusics":
                {
                    RegConnectionManager.getInstance().send(ProtocolEnum.OPTION_MUSIC_LOOP_VALUE_CHANGED, event.propertyValue);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function getInstance() : SoundManager
        {
            if (!_self)
            {
                _self = new SoundManager;
            }
            return _self;
        }// end function

    }
}
