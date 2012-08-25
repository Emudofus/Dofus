package com.ankamagames.dofus.kernel.sound.type
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.kernel.sound.manager.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.protocolAudio.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.tubul.*;
    import com.ankamagames.tubul.interfaces.*;
    import com.ankamagames.tubul.types.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.utils.*;

    public class SoundDofus extends Object implements ISound, ILocalizedSound
    {
        protected var _busId:int;
        protected var _id:int;
        protected var _soundId:String;
        protected var _uri:Uri;
        protected var _volume:Number;
        protected var _fadeVolume:Number;
        protected var _busVolume:Number;
        protected var _loop:Boolean = false;
        protected var _noCutSilence:Boolean;
        protected var _effects:Vector.<IEffect>;
        protected var _silence:SoundSilence;
        private var _pan:Number;
        private var _position:Point;
        private var _range:Number;
        private var _saturationRange:Number;
        private var _observerPosition:Point;
        private var _volumeMax:Number;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SoundDofus));
        private static var _currentId:int = -1;
        private static var _cache:Dictionary = new Dictionary();

        public function SoundDofus(param1:String, param2:Boolean = false)
        {
            this.init();
            if (_cache[param1] && param2)
            {
                this._id = _cache[param1];
            }
            else
            {
                this._id = _currentId - 1;
                if (param2)
                {
                    _cache[param1] = this._id;
                }
            }
            this._soundId = param1;
            RegConnectionManager.getInstance().send(ProtocolEnum.ADD_SOUND, this._id, this._soundId, true);
            return;
        }// end function

        public function get duration() : Number
        {
            _log.warn("Cette propriété (\'duration\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
            return 0;
        }// end function

        public function get stereo() : Boolean
        {
            _log.warn("Cette propriété (\'stereo\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
            return false;
        }// end function

        public function get totalLoops() : int
        {
            _log.warn("Cette propriété (\'totalLoops\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
            return -1;
        }// end function

        public function get currentLoop() : uint
        {
            _log.warn("Cette propriété (\'currentLoop\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
            return 0;
        }// end function

        public function get pan() : Number
        {
            _log.warn("Cette propriété (\'pan\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
            return this._pan;
        }// end function

        public function set pan(param1:Number) : void
        {
            if (param1 < -1)
            {
                this._pan = -1;
            }
            if (param1 > 1)
            {
                this._pan = 1;
            }
            this._pan = param1;
            return;
        }// end function

        public function get range() : Number
        {
            return this._range;
        }// end function

        public function set range(param1:Number) : void
        {
            if (param1 < this._saturationRange)
            {
                param1 = this._saturationRange;
            }
            this._range = param1;
            return;
        }// end function

        public function get saturationRange() : Number
        {
            return this._saturationRange;
        }// end function

        public function set saturationRange(param1:Number) : void
        {
            if (param1 >= this._range)
            {
                param1 = this._range;
            }
            this._saturationRange = param1;
            return;
        }// end function

        public function get position() : Point
        {
            return this._position;
        }// end function

        public function set position(param1:Point) : void
        {
            this._position = param1;
            return;
        }// end function

        public function get volumeMax() : Number
        {
            return this._volumeMax;
        }// end function

        public function set volumeMax(param1:Number) : void
        {
            if (param1 > 1)
            {
                param1 = 1;
            }
            if (param1 < 0)
            {
                param1 = 0;
            }
            this._volumeMax = param1;
            return;
        }// end function

        public function get effects() : Vector.<IEffect>
        {
            return this._effects;
        }// end function

        public function get volume() : Number
        {
            return this._volume;
        }// end function

        public function set volume(param1:Number) : void
        {
            if (param1 > 1)
            {
                param1 = 1;
            }
            if (param1 < 0)
            {
                param1 = 0;
            }
            this._volume = param1;
            RegConnectionManager.getInstance().send(ProtocolEnum.SET_VOLUME, this._id, param1);
            return;
        }// end function

        public function get currentFadeVolume() : Number
        {
            return this._fadeVolume;
        }// end function

        public function set currentFadeVolume(param1:Number) : void
        {
            if (param1 > 1)
            {
                param1 = 1;
            }
            if (param1 < 0)
            {
                param1 = 0;
            }
            this._fadeVolume = param1;
            RegConnectionManager.getInstance().send(ProtocolEnum.SET_FADE_VOLUME, this._id, param1);
            return;
        }// end function

        public function get effectiveVolume() : Number
        {
            _log.warn("Cette propriété (\'effectiveVolume\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
            return 0;
        }// end function

        public function get uri() : Uri
        {
            return this._uri;
        }// end function

        public function get eventDispatcher() : EventDispatcher
        {
            _log.warn("Cette propriété (\'eventDispatcher\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
            return null;
        }// end function

        public function get sound() : Sound
        {
            _log.warn("Cette propriété (\'sound\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
            return null;
        }// end function

        public function set sound(param1) : void
        {
            return;
        }// end function

        public function get busId() : int
        {
            return this._busId;
        }// end function

        public function set busId(param1:int) : void
        {
            return;
        }// end function

        public function get bus() : IAudioBus
        {
            _log.warn("Cette propriété (\'bus\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
            return Tubul.getInstance().getBus(this.busId);
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get noCutSilence() : Boolean
        {
            _log.warn("Cette propriété (\'noCutSilence\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
            return this._noCutSilence;
        }// end function

        public function set noCutSilence(param1:Boolean) : void
        {
            this._noCutSilence = param1;
            var _loc_2:* = new Object();
            _loc_2.noCutSilence = param1;
            RegConnectionManager.getInstance().send(ProtocolEnum.SET_SOUND_PROPERTIES, this._id, _loc_2);
            return;
        }// end function

        public function get isPlaying() : Boolean
        {
            _log.warn("Cette propriété (\'isPlaying\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
            return true;
        }// end function

        public function get silence() : SoundSilence
        {
            return this._silence;
        }// end function

        public function set silence(param1:SoundSilence) : void
        {
            this._silence = param1;
            return;
        }// end function

        public function setCurrentLoop(param1:uint) : void
        {
            return;
        }// end function

        public function addEffect(param1:IEffect) : void
        {
            return;
        }// end function

        public function removeEffect(param1:IEffect) : void
        {
            return;
        }// end function

        public function applyDynamicMix(param1:VolumeFadeEffect, param2:uint, param3:VolumeFadeEffect) : void
        {
            return;
        }// end function

        public function play(param1:Boolean = false, param2:int = 0, param3:VolumeFadeEffect = null, param4:VolumeFadeEffect = null) : void
        {
            var _loc_5:Number = -1;
            var _loc_6:Number = -1;
            var _loc_7:Number = -1;
            var _loc_8:Number = -1;
            var _loc_9:Number = -1;
            var _loc_10:Number = -1;
            if (param3)
            {
                _loc_5 = param3.beginningValue;
                _loc_6 = param3.endingValue;
                _loc_7 = param3.timeFade;
            }
            if (param4)
            {
                _loc_8 = param4.beginningValue;
                _loc_9 = param4.endingValue;
                _loc_10 = param4.timeFade;
            }
            RegConnectionManager.getInstance().send(ProtocolEnum.PLAY_SOUND, this._id, this._soundId, param1, param2, _loc_5, _loc_6, _loc_7, _loc_8, _loc_9, _loc_10);
            return;
        }// end function

        public function stop(param1:VolumeFadeEffect = null) : void
        {
            var _loc_2:Number = -1;
            var _loc_3:Number = -1;
            var _loc_4:Number = -1;
            if (param1 != null)
            {
                _loc_2 = param1.beginningValue;
                _loc_3 = param1.endingValue;
                _loc_4 = param1.timeFade;
            }
            RegConnectionManager.getInstance().send(ProtocolEnum.STOP_SOUND, this._id, _loc_2, _loc_3, _loc_4);
            return;
        }// end function

        public function loadSound(param1:ICache) : void
        {
            return;
        }// end function

        public function setLoops(param1:int) : void
        {
            RegConnectionManager.getInstance().send(ProtocolEnum.SET_LOOPS, this._id, param1);
            return;
        }// end function

        public function clone() : ISound
        {
            _log.warn("Can\'t clone a SoundDofus !");
            return null;
        }// end function

        private function init() : void
        {
            this._fadeVolume = 1;
            this._busVolume = 1;
            this._volume = 1;
            return;
        }// end function

    }
}
