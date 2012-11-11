package com.ankamagames.tubul.types.sounds
{
    import __AS3__.vec.*;
    import com.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.newCache.garbage.*;
    import com.ankamagames.jerakine.newCache.impl.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.tubul.*;
    import com.ankamagames.tubul.enum.*;
    import com.ankamagames.tubul.events.*;
    import com.ankamagames.tubul.events.LoadingSound.*;
    import com.ankamagames.tubul.factory.*;
    import com.ankamagames.tubul.interfaces.*;
    import com.ankamagames.tubul.types.*;
    import flash.events.*;
    import flash.media.*;
    import flash.utils.*;

    public class MP3SoundDofus extends Object implements ISound
    {
        protected var _uri:Uri;
        protected var _id:int;
        protected var _sound:Sound;
        protected var _eventDispatcher:EventDispatcher;
        protected var _onLoadingComplete:Vector.<Callback>;
        protected var _soundLoaded:Boolean;
        protected var _loader:IResourceLoader;
        protected var _silence:SoundSilence;
        protected var _busId:int;
        protected var _playing:Boolean = false;
        protected var _noCutSilence:Boolean;
        protected var _soundWrapper:SoundWrapper;
        protected var _stereo:Boolean;
        protected var _stopAfterCurrentFade:Boolean = false;
        protected var _volume:Number;
        protected var _fadeVolume:Number;
        protected var _previousVolume:Number;
        protected var _previousFadeVolume:Number;
        protected var _fadeOutFade:VolumeFadeEffect;
        protected var _currentRunningFade:VolumeFadeEffect;
        protected var _loop:Boolean = false;
        protected var _currentLoop:uint;
        protected var _totalLoop:int;
        protected var _timer:Timer;
        protected var _effects:Vector.<IEffect>;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(MP3SoundDofus));
        static var cacheByteArray:Cache = new Cache(TubulConstants.BOUNDS_BYTEARRAY_CACHE, new LruGarbageCollector());
        public static var dicSound:Dictionary;

        public function MP3SoundDofus(param1:uint, param2:Uri, param3:Boolean = false)
        {
            this.initSound();
            this._uri = param2;
            this._id = param1;
            this._effects = new Vector.<IEffect>;
            this._stereo = param3;
            if (dicSound == null)
            {
                dicSound = new Dictionary(true);
            }
            dicSound[this] = 1;
            return;
        }// end function

        public function get duration() : Number
        {
            if (this._soundWrapper)
            {
                return this._soundWrapper.duration;
            }
            _log.warn("La valeur de la propriété duration est fausse, attention !");
            return 0;
        }// end function

        public function get stereo() : Boolean
        {
            return this._stereo;
        }// end function

        public function get totalLoops() : int
        {
            return this._totalLoop;
        }// end function

        public function get currentLoop() : uint
        {
            return this._currentLoop;
        }// end function

        public function get effects() : Vector.<IEffect>
        {
            return this._effects;
        }// end function

        public function get uri() : Uri
        {
            return this._uri;
        }// end function

        public function get eventDispatcher() : EventDispatcher
        {
            return this._eventDispatcher;
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
            if (this._soundLoaded && this._previousVolume != this._volume)
            {
                this.applyParam();
            }
            this._previousVolume = this._volume;
            return;
        }// end function

        public function get busId() : int
        {
            return this._busId;
        }// end function

        public function set busId(param1:int) : void
        {
            this._busId = param1;
            var _loc_2:* = Tubul.getInstance().getBus(param1);
            if (_loc_2 != null)
            {
                _loc_2.eventDispatcher.addEventListener(AudioBusVolumeEvent.VOLUME_CHANGED, this.onAudioBusVolumeChanged);
            }
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
            if (this._soundLoaded && this._previousFadeVolume != this._fadeVolume)
            {
                this.applyParam();
            }
            this._previousFadeVolume = this._fadeVolume;
            return;
        }// end function

        public function get effectiveVolume() : Number
        {
            return this.busVolume * this.volume * this.currentFadeVolume;
        }// end function

        public function get soundChannel() : SoundChannel
        {
            if (this._soundWrapper == null)
            {
                return null;
            }
            return Tubul.getInstance().soundMerger.getSoundChannel(this._soundWrapper);
        }// end function

        public function get sound() : Sound
        {
            return this._sound;
        }// end function

        public function set sound(param1) : void
        {
            this._sound = param1;
            this._soundLoaded = true;
            this.finishLoading();
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
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

        public function get busVolume() : Number
        {
            if (this.bus != null)
            {
                return this.bus.effectiveVolume;
            }
            return -1;
        }// end function

        public function get noCutSilence() : Boolean
        {
            return this._noCutSilence;
        }// end function

        public function set noCutSilence(param1:Boolean) : void
        {
            this._noCutSilence = param1;
            return;
        }// end function

        public function get isPlaying() : Boolean
        {
            return this._playing;
        }// end function

        public function get bus() : IAudioBus
        {
            return Tubul.getInstance().getBus(this.busId);
        }// end function

        public function addEffect(param1:IEffect) : void
        {
            this._effects.push(param1);
            return;
        }// end function

        public function removeEffect(param1:IEffect) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            for each (_loc_3 in this._effects)
            {
                
                if (_loc_3 == param1)
                {
                    this._effects.splice(_loc_2, 1);
                    return;
                }
            }
            return;
        }// end function

        public function play(param1:Boolean = false, param2:int = 1, param3:VolumeFadeEffect = null, param4:VolumeFadeEffect = null) : void
        {
            var _loc_6:* = null;
            if (this.bus == null)
            {
                return;
            }
            if (this.bus.contains(this) == false)
            {
                _log.debug("[8142-DEBUG] 1 1 : addISound from MP3SoundDofus:408");
                this.bus.addISound(this);
            }
            if (this._playing)
            {
                return;
            }
            this._loop = param1;
            if (!this._loop)
            {
                param2 = 1;
            }
            this.setLoops(param2);
            if (!this._soundLoaded)
            {
                _loc_6 = new Callback(this.play, param1, param2, param3, param4);
                this._onLoadingComplete.push(_loc_6);
                return;
            }
            this._playing = true;
            if (param3 && param3.beginningValue != -1)
            {
                this.currentFadeVolume = param3.beginningValue;
            }
            this._soundWrapper = new SoundWrapper(this._sound, param2);
            this._soundWrapper.addEventListener(Event.SOUND_COMPLETE, this.onSoundComplete);
            this._soundWrapper.addEventListener(LoopEvent.SOUND_LOOP, this.onSoundLoop);
            this.applyParam();
            var _loc_5:* = "Play / file : " + this._uri.fileName + " / id : " + this._id + " / vol. réel : " + Math.round(this.effectiveVolume * 1000) / 1000 + " / vol. : " + Math.round(this._volume * 1000) / 1000;
            if (this is LocalizedSound)
            {
                _loc_5 = _loc_5 + " / vol. max : " + (this as LocalizedSound).volumeMax;
            }
            _loc_5 = _loc_5 + " / vol. fade : " + Math.round(this._fadeVolume * 1000) / 1000 + " / bus : " + this.bus.name + " / vol. bus : " + Math.round(this.bus.effectiveVolume * 1000) / 1000;
            if (param3 != null)
            {
                _loc_5 = _loc_5 + "\n[fade in] Valeur de fin : " + param3.endingValue + " / " + param3.timeFade + " sec.";
            }
            if (param4 != null)
            {
                _loc_5 = _loc_5 + "\n                [fade out] Valeur de fin : " + param4.endingValue + " / " + param4.timeFade + " sec.";
            }
            _log.debug(_loc_5);
            Tubul.getInstance().soundMerger.addSound(this._soundWrapper);
            if (param3)
            {
                this._currentRunningFade = param3;
                if (!this._currentRunningFade.hasEventListener(FadeEvent.COMPLETE))
                {
                    this._currentRunningFade.addEventListener(FadeEvent.COMPLETE, this.onCurrentFadeComplete);
                }
                param3.attachToSoundSource(this);
                param3.start();
            }
            if (param4)
            {
                this._soundWrapper.notifyWhenEndOfFile(true, param4.timeFade);
                this._fadeOutFade = param4;
                this._soundWrapper.addEventListener(SoundWrapperEvent.SOON_END_OF_FILE, this.onEndOfFile);
            }
            return;
        }// end function

        public function loadSound(param1:ICache) : void
        {
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onFailed);
            this._loader.load(this._uri, param1);
            return;
        }// end function

        public function stop(param1:VolumeFadeEffect = null) : void
        {
            this.clearLoader();
            if (this._silence)
            {
                this._silence.clean();
            }
            if (this._soundWrapper != null && param1)
            {
                this._currentRunningFade = param1;
                this._currentRunningFade.attachToSoundSource(this);
                this._currentRunningFade.addEventListener(FadeEvent.COMPLETE, this.onCurrentFadeComplete);
                this._stopAfterCurrentFade = true;
                param1.start(false);
            }
            else
            {
                this.finishPlay();
            }
            return;
        }// end function

        public function applyDynamicMix(param1:VolumeFadeEffect, param2:uint, param3:VolumeFadeEffect) : void
        {
            return;
        }// end function

        public function setLoops(param1:int) : void
        {
            this._totalLoop = param1;
            if (this._soundWrapper)
            {
                this._soundWrapper.loops = this._totalLoop;
            }
            return;
        }// end function

        public function clone() : ISound
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            if (this is LocalizedSound)
            {
                _loc_2 = EnumSoundType.LOCALIZED_SOUND;
            }
            else
            {
                _loc_2 = EnumSoundType.UNLOCALIZED_SOUND;
            }
            _loc_1 = SoundFactory.getSound(_loc_2, this.uri);
            _loc_1.busId = this.busId;
            _loc_1.volume = this.volume;
            _loc_1.currentFadeVolume = this.currentFadeVolume;
            _loc_1.setLoops(this.totalLoops);
            if (this.silence)
            {
                _loc_1.silence = this.silence;
            }
            _loc_1.noCutSilence = this.noCutSilence;
            return _loc_1;
        }// end function

        public function setCurrentLoop(param1:uint) : void
        {
            if (this._soundWrapper)
            {
                this._soundWrapper.currentLoop = param1;
            }
            return;
        }// end function

        private function clearLoader() : void
        {
            if (this._loader)
            {
                this._loader.removeEventListener(ResourceLoadedEvent.LOADED, this.onLoaded);
                this._loader.removeEventListener(ResourceErrorEvent.ERROR, this.onFailed);
                this._loader = null;
            }
            return;
        }// end function

        protected function applyParam() : void
        {
            if (this._soundWrapper == null)
            {
                return;
            }
            this._soundWrapper.volume = this.effectiveVolume;
            return;
        }// end function

        protected function initSound() : void
        {
            this._soundLoaded = false;
            this._onLoadingComplete = new Vector.<Callback>;
            this._eventDispatcher = new EventDispatcher();
            this._busId = -1;
            this.volume = 1;
            this.currentFadeVolume = 1;
            this._previousVolume = 1;
            this._previousFadeVolume = 1;
            this._currentLoop = 0;
            this._totalLoop = -1;
            return;
        }// end function

        private function finishLoading() : void
        {
            var _loc_1:* = new LoadingSoundEvent(LoadingSoundEvent.LOADED);
            _loc_1.data = this;
            this._eventDispatcher.dispatchEvent(_loc_1);
            this.processQueueFunction();
            return;
        }// end function

        private function processQueueFunction() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = this._onLoadingComplete.length;
            if (_loc_1 > 0)
            {
                this._onLoadingComplete.reverse();
                for each (_loc_2 in this._onLoadingComplete)
                {
                    
                    _loc_2.exec();
                    _loc_2 = null;
                }
            }
            this._onLoadingComplete = new Vector.<Callback>;
            return;
        }// end function

        private function clean() : void
        {
            this._silence = null;
            if (this._currentRunningFade)
            {
                this._currentRunningFade.stop();
                this._currentRunningFade = null;
            }
            if (this._fadeOutFade)
            {
                this._fadeOutFade.stop();
                this._fadeOutFade = null;
            }
            this._sound = null;
            this._soundWrapper = null;
            this._uri = null;
            return;
        }// end function

        private function finishPlay() : void
        {
            if (this._silence)
            {
                this._silence.clean();
            }
            if (this._soundWrapper != null)
            {
                this._soundWrapper.removeEventListener(Event.SOUND_COMPLETE, this.onSoundComplete);
                this._soundWrapper.removeEventListener(LoopEvent.SOUND_LOOP, this.onSoundLoop);
                if (this._loop)
                {
                    Tubul.getInstance().soundMerger.removeSound(this._soundWrapper);
                }
            }
            if (this.bus != null)
            {
                this.bus.eventDispatcher.removeEventListener(AudioBusVolumeEvent.VOLUME_CHANGED, this.onAudioBusVolumeChanged);
            }
            this._playing = false;
            var _loc_1:* = new SoundCompleteEvent(SoundCompleteEvent.SOUND_COMPLETE);
            _loc_1.sound = this;
            if (this._eventDispatcher == null)
            {
                this._eventDispatcher = new EventDispatcher();
            }
            this._eventDispatcher.dispatchEvent(_loc_1);
            _loc_1 = null;
            return;
        }// end function

        protected function onSoundComplete(event:Event) : void
        {
            this._soundWrapper.currentLoop = 0;
            if (this._silence)
            {
                _log.info("Playing silence (" + this._silence.silenceMin + "/" + this._silence.silenceMax + " sec) for the sound " + this._id + " (" + this._uri.fileName + ")");
                this._silence.addEventListener(SoundSilenceEvent.COMPLETE, this.onSilenceComplete);
                this._silence.start();
            }
            else
            {
                this.finishPlay();
            }
            return;
        }// end function

        private function onLoaded(event:ResourceLoadedEvent) : void
        {
            this._soundLoaded = true;
            this._sound = event.resource;
            this.clearLoader();
            var _loc_2:* = new LoadingSoundEvent(LoadingSoundEvent.LOADED);
            _loc_2.data = this;
            this._eventDispatcher.dispatchEvent(_loc_2);
            this.processQueueFunction();
            return;
        }// end function

        private function onFailed(event:ResourceErrorEvent) : void
        {
            var _loc_2:* = new LoadingSoundEvent(LoadingSoundEvent.LOADING_FAILED);
            _loc_2.data = this;
            _log.error("Cannot load " + event.uri + " : " + event.errorMsg);
            this._eventDispatcher.dispatchEvent(_loc_2);
            return;
        }// end function

        private function onEndOfFile(event:SoundWrapperEvent) : void
        {
            if (this._fadeOutFade)
            {
                this._currentRunningFade = this._fadeOutFade;
                if (!this._currentRunningFade.hasEventListener(FadeEvent.COMPLETE))
                {
                    this._currentRunningFade.addEventListener(FadeEvent.COMPLETE, this.onCurrentFadeComplete);
                }
                this._currentRunningFade.attachToSoundSource(this);
                this._currentRunningFade.start();
                this._fadeOutFade = null;
            }
            var _loc_2:* = new MP3SoundEvent(MP3SoundEvent.SOON_END_OF_FILE);
            _loc_2.sound = this;
            this.eventDispatcher.dispatchEvent(_loc_2);
            return;
        }// end function

        private function onAudioBusVolumeChanged(event:AudioBusVolumeEvent) : void
        {
            this.applyParam();
            return;
        }// end function

        private function onSoundLoop(event:LoopEvent) : void
        {
            this._currentLoop = event.loop;
            var _loc_2:* = new LoopEvent(LoopEvent.SOUND_LOOP);
            _loc_2.loop = this._currentLoop;
            _loc_2.sound = this;
            this.eventDispatcher.dispatchEvent(_loc_2);
            return;
        }// end function

        private function onCurrentFadeComplete(event:FadeEvent) : void
        {
            if (this._currentRunningFade == null)
            {
                return;
            }
            this._currentRunningFade.removeEventListener(FadeEvent.COMPLETE, this.onCurrentFadeComplete);
            this._currentRunningFade = null;
            if (this._stopAfterCurrentFade == true)
            {
                this.stop();
            }
            this._stopAfterCurrentFade = false;
            return;
        }// end function

        private function onSilenceComplete(event:SoundSilenceEvent) : void
        {
            this._silence.removeEventListener(SoundSilenceEvent.COMPLETE, this.onSilenceComplete);
            this.finishPlay();
            return;
        }// end function

    }
}
