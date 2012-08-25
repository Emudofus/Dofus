package com.ankamagames.tubul.types.bus
{
    import __AS3__.vec.*;
    import com.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.newCache.garbage.*;
    import com.ankamagames.jerakine.newCache.impl.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.tubul.*;
    import com.ankamagames.tubul.enum.*;
    import com.ankamagames.tubul.events.*;
    import com.ankamagames.tubul.events.LoadingSound.*;
    import com.ankamagames.tubul.interfaces.*;
    import com.ankamagames.tubul.types.*;
    import flash.events.*;
    import flash.utils.*;

    public class AudioBus extends Object implements IAudioBus
    {
        private const _log:Logger;
        protected var _id:uint;
        protected var _name:String;
        protected var _soundVector:Vector.<ISound>;
        protected var _volume:Number;
        protected var _volumeMax:Number;
        protected var _fadeVolume:Number;
        protected var _cache:ICache;
        protected var _eventDispatcher:EventDispatcher;
        protected var _numberSoundsLimitation:int = -1;
        protected var _effects:Vector.<IEffect>;
        static var _totalPlayingSounds:int = 0;
        static var id_sound:uint = 0;

        public function AudioBus(param1:int, param2:String)
        {
            this._log = Log.getLogger(getQualifiedClassName(AudioBus));
            this.init(param1, param2);
            return;
        }// end function

        public function get soundList() : Vector.<ISound>
        {
            return this._soundVector;
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

        public function get volumeMax() : Number
        {
            return this._volumeMax;
        }// end function

        public function get numberSoundsLimitation() : int
        {
            return this._numberSoundsLimitation;
        }// end function

        public function set numberSoundsLimitation(param1:int) : void
        {
            this._numberSoundsLimitation = param1;
            return;
        }// end function

        public function get effects() : Vector.<IEffect>
        {
            return this._effects;
        }// end function

        public function get eventDispatcher() : EventDispatcher
        {
            return this._eventDispatcher;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get id() : uint
        {
            return this._id;
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
            if (isNaN(this.volumeMax))
            {
                this._volumeMax = this._volume;
            }
            this._log.warn("Bus " + "(" + this.id + ") vol. réel : " + this.effectiveVolume + " (vol. max : " + this._volumeMax + " / % vol : " + this._volume + ") [" + this.name + "]");
            this.informSoundsNewVolume();
            return;
        }// end function

        public function get volume() : Number
        {
            return this._volume;
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
            this.informSoundsNewVolume();
            return;
        }// end function

        public function get effectiveVolume() : Number
        {
            return Math.round(this._volume * this._volumeMax * this._fadeVolume * 1000) / 1000;
        }// end function

        public function clear(param1:VolumeFadeEffect = null) : void
        {
            var _loc_2:ISound = null;
            for each (_loc_2 in this._soundVector)
            {
                
                this.removeSound(_loc_2, param1);
            }
            return;
        }// end function

        public function playISound(param1:ISound, param2:Boolean = false, param3:int = -1) : void
        {
            var _loc_5:ISound = null;
            var _loc_4:Boolean = false;
            for each (_loc_5 in this._soundVector)
            {
                
                if (_loc_5 === param1)
                {
                    _loc_4 = true;
                    break;
                }
            }
            if (!_loc_4)
            {
                this.addISound(param1);
            }
            if (!param1.isPlaying)
            {
                param1.play(param2, param3);
            }
            return;
        }// end function

        public function addISound(param1:ISound) : void
        {
            var _loc_3:ISound = null;
            var _loc_4:ISound = null;
            var _loc_5:IEffect = null;
            var _loc_6:IAudioBus = null;
            var _loc_7:ISound = null;
            var _loc_8:ISound = null;
            var _loc_9:CacheableResource = null;
            var _loc_10:* = undefined;
            param1.eventDispatcher.addEventListener(SoundCompleteEvent.SOUND_COMPLETE, this.onSoundComplete, false, EventListenerPriority.MINIMAL, true);
            var _loc_2:String = "";
            for each (_loc_3 in this.soundList)
            {
                
                _loc_2 = _loc_2 + (" " + _loc_3.id + ";" + _loc_3.uri);
            }
            if (Tubul.getInstance().totalPlayingSounds >= TubulConstants.MAXIMUM_SOUNDS_PLAYING_SAME_TIME)
            {
                this._log.warn("We have reached the maximum number of sounds playing simultaneously");
                this._log.warn("");
                for each (_loc_6 in Tubul.getInstance().audioBusList)
                {
                    
                    this._log.warn("Registered sounds in bus " + _loc_6.name + " :");
                    for each (_loc_7 in _loc_6.soundList)
                    {
                        
                        this._log.warn("- " + _loc_7.uri);
                    }
                }
                return;
            }
            if (this._numberSoundsLimitation >= 0 && this.soundList.length >= this._numberSoundsLimitation)
            {
                this._log.warn("We have reached the maximum number of sounds for this bus (" + this._id + " / " + this._name + ")");
                this._log.warn("Registered sounds in bus " + this._name + " :");
                for each (_loc_8 in this.soundList)
                {
                    
                    this._log.warn("- " + _loc_8.uri);
                }
                return;
            }
            this._log.warn("Registered sounds in bus " + this._name + " :");
            for each (_loc_4 in this.soundList)
            {
                
                this._log.warn("- " + _loc_4.uri);
            }
            if (this.contains(param1))
            {
                return;
            }
            param1.busId = this.id;
            for each (_loc_5 in this._effects)
            {
                
                param1.addEffect(_loc_5);
            }
            this._soundVector.push(param1);
            if (this._cache.contains(TubulConstants.PREFIXE_LOADER + param1.uri.toSum()))
            {
                _loc_9 = this._cache.peek(TubulConstants.PREFIXE_LOADER + param1.uri.toSum());
                _loc_10 = _loc_9.resource;
                param1.sound = _loc_10;
            }
            else
            {
                param1.loadSound(this._cache);
                param1.eventDispatcher.addEventListener(LoadingSoundEvent.LOADED, this.onLoadComplete);
                param1.eventDispatcher.addEventListener(LoadingSoundEvent.LOADING_FAILED, this.onLoadFail);
            }
            return;
        }// end function

        public function addEffect(param1:IEffect) : void
        {
            var _loc_2:IEffect = null;
            var _loc_3:ISound = null;
            for each (_loc_2 in this._effects)
            {
                
                if (_loc_2.com.ankamagames.tubul.interfaces:IEffect::name == param1.com.ankamagames.tubul.interfaces:IEffect::name)
                {
                    return;
                }
            }
            this._effects.push(param1);
            for each (_loc_3 in this._soundVector)
            {
                
                _loc_3.addEffect(param1);
            }
            return;
        }// end function

        public function removeEffect(param1:IEffect) : void
        {
            var _loc_3:IEffect = null;
            var _loc_4:ISound = null;
            var _loc_2:uint = 0;
            for each (_loc_3 in this._effects)
            {
                
                if (_loc_3 == param1)
                {
                    this._effects.splice(_loc_2, 1);
                    continue;
                }
                _loc_2 = _loc_2 + 1;
            }
            for each (_loc_4 in this._soundVector)
            {
                
                _loc_4.removeEffect(param1);
            }
            return;
        }// end function

        public function play() : void
        {
            var _loc_1:ISound = null;
            for each (_loc_1 in this._soundVector)
            {
                
                _loc_1.play();
            }
            return;
        }// end function

        public function stop() : void
        {
            var _loc_1:ISound = null;
            for each (_loc_1 in this._soundVector)
            {
                
                _loc_1.stop();
            }
            return;
        }// end function

        public function applyDynamicMix(param1:VolumeFadeEffect, param2:uint, param3:VolumeFadeEffect) : void
        {
            return;
        }// end function

        public function contains(param1:ISound) : Boolean
        {
            var _loc_2:ISound = null;
            for each (_loc_2 in this._soundVector)
            {
                
                if (_loc_2.id == param1.id)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function clearCache() : void
        {
            this._cache = Cache.create(TubulConstants.MAXIMUM_BOUNDS_CACHE, new LruGarbageCollector(), getQualifiedClassName(this));
            return;
        }// end function

        private function init(param1:int, param2:String) : void
        {
            this._eventDispatcher = new EventDispatcher();
            this._cache = Cache.create(TubulConstants.MAXIMUM_BOUNDS_CACHE, new LruGarbageCollector(), getQualifiedClassName(this));
            this._soundVector = new Vector.<ISound>;
            this._name = param2;
            this._id = param1;
            this._effects = new Vector.<IEffect>;
            this.volume = 1;
            this.currentFadeVolume = 1;
            return;
        }// end function

        protected function removeSound(param1:ISound, param2:VolumeFadeEffect = null) : uint
        {
            var sound3:ISound;
            var pISound:* = param1;
            var pFade:* = param2;
            if (!this._soundVector)
            {
                return 0;
            }
            if (pISound == null)
            {
                this._log.warn("We tried to remove a null-sound.");
                return this._soundVector.length;
            }
            var indexOfSound:* = this._soundVector.indexOf(pISound);
            try
            {
                this._soundVector.splice(indexOfSound, 1);
            }
            catch (e:Error)
            {
                _log.warn("We tried to remove a non existing sound. Allready removed ? (" + pISound.uri + ")");
            }
            var busState:String;
            var _loc_4:int = 0;
            var _loc_5:* = this.soundList;
            while (_loc_5 in _loc_4)
            {
                
                sound3 = _loc_5[_loc_4];
                busState = busState + (" " + sound3.id + ";" + sound3.uri);
            }
            pISound.eventDispatcher.removeEventListener(SoundCompleteEvent.SOUND_COMPLETE, this.onSoundComplete);
            pISound.eventDispatcher.removeEventListener(LoadingSoundEvent.LOADING_FAILED, this.onLoadFail);
            if (pISound.isPlaying)
            {
                pISound.stop(pFade);
            }
            pISound;
            return this._soundVector.length;
        }// end function

        protected function getOlderSound() : ISound
        {
            var _loc_1:ISound = null;
            var _loc_2:ISound = null;
            for each (_loc_2 in this._soundVector)
            {
                
                if (_loc_1 == null)
                {
                    _loc_1 = _loc_2;
                    continue;
                }
                if (_loc_2.id < _loc_1.id)
                {
                    _loc_1 = _loc_2;
                }
            }
            return _loc_1;
        }// end function

        protected function informSoundsNewVolume() : void
        {
            var _loc_1:* = new AudioBusVolumeEvent(AudioBusVolumeEvent.VOLUME_CHANGED);
            _loc_1.newVolume = this.effectiveVolume;
            this._eventDispatcher.dispatchEvent(_loc_1);
            return;
        }// end function

        private function onLoadComplete(event:LoadingSoundEvent) : void
        {
            return;
        }// end function

        private function onLoadFail(event:LoadingSoundEvent) : void
        {
            this._log.warn("A sound failed to load : " + event.data.uri);
            this.removeSound(event.data);
            return;
        }// end function

        protected function onSoundComplete(event:SoundCompleteEvent) : void
        {
            var _loc_2:ILocalizedSoundListener = null;
            this._eventDispatcher.dispatchEvent(event);
            for each (_loc_2 in Tubul.getInstance().localizedSoundListeners)
            {
                
                _loc_2.removeSoundEntity(event.sound);
            }
            this.removeSound(event.sound);
            event = null;
            return;
        }// end function

        protected function onFadeBeforeDeleteComplete(event:FadeEvent) : void
        {
            if (event.soundSource is ISound)
            {
                this.removeSound(event.soundSource as ISound);
            }
            return;
        }// end function

        private function onRemoveSound(param1:ISound) : void
        {
            var _loc_2:* = new AudioBusEvent(AudioBusEvent.REMOVE_SOUND_IN_BUS);
            _loc_2.sound = param1;
            this._eventDispatcher.dispatchEvent(_loc_2);
            return;
        }// end function

        private function onAddSound(param1:ISound) : void
        {
            var _loc_2:* = new AudioBusEvent(AudioBusEvent.ADD_SOUND_IN_BUS);
            _loc_2.sound = param1;
            this._eventDispatcher.dispatchEvent(_loc_2);
            return;
        }// end function

    }
}
