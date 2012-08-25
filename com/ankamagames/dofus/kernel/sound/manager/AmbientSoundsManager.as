package com.ankamagames.dofus.kernel.sound.manager
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.ambientSounds.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.kernel.sound.type.*;
    import com.ankamagames.dofus.kernel.sound.utils.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.protocolAudio.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.tubul.enum.*;
    import com.ankamagames.tubul.factory.*;
    import com.ankamagames.tubul.interfaces.*;
    import com.ankamagames.tubul.types.*;
    import flash.utils.*;

    public class AmbientSoundsManager extends Object
    {
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
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(AmbientSoundsManager));

        public function AmbientSoundsManager()
        {
            this.init();
            return;
        }// end function

        public function get music() : ISound
        {
            return this._music;
        }// end function

        public function get ambience() : ISound
        {
            return this._ambience;
        }// end function

        public function get criterionID() : uint
        {
            return this._criterionID;
        }// end function

        public function set criterionID(param1:uint) : void
        {
            this._criterionID = param1;
            return;
        }// end function

        public function get ambientSounds() : Vector.<AmbientSound>
        {
            return this._ambientSounds;
        }// end function

        public function setAmbientSounds(param1:Vector.<AmbientSound>, param2:Vector.<AmbientSound>) : void
        {
            var _loc_4:AmbientSound = null;
            this._ambientSounds = param1;
            this._roleplayMusics = param2;
            var _loc_3:String = "";
            if (this._ambientSounds.length == 0 && this._roleplayMusics.length == 0)
            {
                _loc_3 = "Ni musique ni ambiance pour cette map ??!!";
            }
            else
            {
                _loc_3 = "Cette map contient les ambiances d\'id : ";
                for each (_loc_4 in this._ambientSounds)
                {
                    
                    _loc_3 = _loc_3 + (_loc_4.id + ", ");
                }
                _loc_3 = " et les musiques d\'id : ";
                for each (_loc_4 in this._roleplayMusics)
                {
                    
                    _loc_3 = _loc_3 + (_loc_4.id + ", ");
                }
            }
            _log.info(_loc_3);
            return;
        }// end function

        public function selectValidSounds() : void
        {
            var _loc_2:AmbientSound = null;
            var _loc_3:int = 0;
            var _loc_1:int = 0;
            for each (_loc_2 in this._ambientSounds)
            {
                
                if (!this._useCriterion || _loc_2.criterionId == this._criterionID)
                {
                    _loc_1++;
                }
            }
            _loc_3 = int(Math.random() * _loc_1);
            for each (_loc_2 in this._ambientSounds)
            {
                
                if (!this._useCriterion || _loc_2.criterionId == this._criterionID)
                {
                    if (_loc_3 == 0)
                    {
                        this._ambienceA = _loc_2;
                        break;
                    }
                    _loc_3 = _loc_3 - 1;
                }
            }
            _loc_1 = 0;
            for each (_loc_2 in this._roleplayMusics)
            {
                
                if (!this._useCriterion || _loc_2.criterionId == this._criterionID)
                {
                    _loc_1++;
                }
            }
            _loc_3 = int(Math.random() * _loc_1);
            for each (_loc_2 in this._roleplayMusics)
            {
                
                if (!this._useCriterion || _loc_2.criterionId == this._criterionID)
                {
                    if (_loc_3 == 0)
                    {
                        this._musicA = _loc_2;
                        break;
                    }
                    _loc_3 = _loc_3 - 1;
                }
            }
            return;
        }// end function

        public function playMusicAndAmbient() : void
        {
            var _loc_1:String = null;
            var _loc_2:Uri = null;
            var _loc_3:Number = NaN;
            var _loc_4:VolumeFadeEffect = null;
            var _loc_5:VolumeFadeEffect = null;
            var _loc_6:String = null;
            var _loc_7:Uri = null;
            var _loc_8:VolumeFadeEffect = null;
            var _loc_9:VolumeFadeEffect = null;
            if (!SoundManager.getInstance().manager.soundIsActivate)
            {
                return;
            }
            if (SoundManager.getInstance().manager is RegSoundManager && !RegConnectionManager.getInstance().isMain)
            {
                return;
            }
            if (this._ambienceA == null)
            {
                _log.warn("It\'s seems that we haven\'t any ambience for this area");
            }
            else
            {
                if (this._previousAmbienceId == this._ambienceA.id)
                {
                    _log.warn("The ambiance is the same that previously");
                }
                else
                {
                    if (this._previousAmbience != null)
                    {
                        _loc_5 = new VolumeFadeEffect(-1, 0, TubulSoundConfiguration.TIME_FADE_OUT_MUSIC);
                        this._previousAmbience.stop(_loc_5);
                    }
                    _loc_1 = SoundUtil.getConfigEntryByBusId(this._ambienceA.channel);
                    _loc_2 = new Uri(_loc_1 + this._ambienceA.id + ".mp3");
                    if (SoundManager.getInstance().manager is ClassicSoundManager)
                    {
                        this._ambience = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND, _loc_2);
                        this._ambience.busId = this._ambienceA.channel;
                    }
                    if (SoundManager.getInstance().manager is RegSoundManager)
                    {
                        this._ambience = new SoundDofus(String(this._ambienceA.id));
                    }
                    this._ambience.volume = this._ambienceA.volume / 100;
                    this._ambience.currentFadeVolume = 0;
                    _loc_4 = new VolumeFadeEffect(-1, 1, TubulSoundConfiguration.TIME_FADE_IN_MUSIC);
                    this._ambience.play(true, 0, _loc_4);
                }
                this._previousAmbienceId = this._ambienceA.id;
            }
            this._previousAmbience = this._ambience;
            if (this._musicA == null)
            {
                _log.warn("It\'s seems that we haven\'t any music for this area");
            }
            else
            {
                if (this._previousMusicId == this._musicA.id)
                {
                    _log.warn("The music is the same that previously");
                }
                else
                {
                    if (this._previousMusic != null)
                    {
                        _loc_9 = new VolumeFadeEffect(-1, 0, TubulSoundConfiguration.TIME_FADE_OUT_MUSIC);
                        this._previousMusic.stop(_loc_9);
                    }
                    _loc_6 = SoundUtil.getConfigEntryByBusId(this._musicA.channel);
                    _loc_7 = new Uri(_loc_6 + this._musicA.id + ".mp3");
                    if (SoundManager.getInstance().manager is ClassicSoundManager)
                    {
                        this._music = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND, _loc_7);
                        this._music.busId = this._musicA.channel;
                    }
                    if (SoundManager.getInstance().manager is RegSoundManager)
                    {
                        this._music = new SoundDofus(String(this._musicA.id));
                    }
                    RegConnectionManager.getInstance().send(ProtocolEnum.SET_SILENCE, this._musicA.silenceMin, this._musicA.silenceMax);
                    this._music.volume = this._musicA.volume / 100;
                    this._music.currentFadeVolume = 0;
                    this.tubulOption = OptionManager.getOptionManager("tubul");
                    if (this.tubulOption["infiniteLoopMusics"])
                    {
                        this._music.play(true, 0);
                    }
                    else
                    {
                        this._music.play(true, TubulSoundConfiguration.MUSIC_LOOPS);
                    }
                    this.tubulOption.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
                    _loc_8 = new VolumeFadeEffect(-1, 1, TubulSoundConfiguration.TIME_FADE_IN_MUSIC);
                    _loc_8.attachToSoundSource(this._music);
                    _loc_8.start();
                }
                this._previousMusicId = this._musicA.id;
            }
            this._previousMusic = this._music;
            return;
        }// end function

        public function stopMusicAndAmbient() : void
        {
            if (this.ambience)
            {
                this.ambience.stop();
            }
            if (this.music)
            {
                this.music.stop();
            }
            this._previousAmbienceId = -1;
            this._previousMusicId = -1;
            if (this.tubulOption)
            {
                this.tubulOption.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            }
            return;
        }// end function

        public function mergeSoundsArea(param1:Vector.<AmbientSound>) : void
        {
            return;
        }// end function

        public function clear(param1:Number = 0, param2:Number = 0) : void
        {
            this.stopMusicAndAmbient();
            return;
        }// end function

        private function init() : void
        {
            return;
        }// end function

        private function onPropertyChanged(event:PropertyChangeEvent) : void
        {
            if (event.propertyName != "infiniteLoopMusics")
            {
                return;
            }
            RegConnectionManager.getInstance().send(ProtocolEnum.OPTION_MUSIC_LOOP_VALUE_CHANGED, event.propertyValue);
            return;
        }// end function

    }
}
