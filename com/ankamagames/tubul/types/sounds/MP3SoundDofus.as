package com.ankamagames.tubul.types.sounds
{
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.newCache.impl.Cache;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.TubulConstants;
   import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;
   import com.ankamagames.jerakine.types.Uri;
   import flash.media.Sound;
   import flash.events.EventDispatcher;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.tubul.types.SoundSilence;
   import com.ankamagames.tubul.types.SoundWrapper;
   import com.ankamagames.tubul.types.VolumeFadeEffect;
   import flash.utils.Timer;
   import com.ankamagames.tubul.interfaces.IEffect;
   import com.ankamagames.tubul.Tubul;
   import com.ankamagames.tubul.interfaces.IAudioBus;
   import com.ankamagames.tubul.events.AudioBusVolumeEvent;
   import flash.media.SoundChannel;
   import flash.events.Event;
   import com.ankamagames.tubul.events.LoopEvent;
   import com.ankamagames.tubul.events.FadeEvent;
   import com.ankamagames.tubul.events.SoundWrapperEvent;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.tubul.enum.EnumSoundType;
   import com.ankamagames.tubul.factory.SoundFactory;
   import com.ankamagames.tubul.events.LoadingSound.LoadingSoundEvent;
   import com.ankamagames.tubul.events.SoundCompleteEvent;
   import com.ankamagames.tubul.events.SoundSilenceEvent;
   import com.ankamagames.tubul.events.MP3SoundEvent;
   
   public class MP3SoundDofus extends Object implements ISound
   {
      
      public function MP3SoundDofus(param1:uint, param2:Uri, param3:Boolean=false) {
         super();
         this.initSound();
         this._uri = param2;
         this._id = param1;
         this._effects = new Vector.<IEffect>();
         this._stereo = param3;
         if(dicSound == null)
         {
            dicSound = new Dictionary(true);
         }
         dicSound[this] = 1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MP3SoundDofus));
      
      protected static var cacheByteArray:Cache = new Cache(TubulConstants.BOUNDS_BYTEARRAY_CACHE,new LruGarbageCollector());
      
      public static var dicSound:Dictionary;
      
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
      
      public function get duration() : Number {
         if(this._soundWrapper)
         {
            return this._soundWrapper.duration;
         }
         _log.warn("La valeur de la propriété duration est fausse, attention !");
         return 0;
      }
      
      public function get stereo() : Boolean {
         return this._stereo;
      }
      
      public function get totalLoops() : int {
         return this._totalLoop;
      }
      
      public function get currentLoop() : uint {
         return this._currentLoop;
      }
      
      public function get effects() : Vector.<IEffect> {
         return this._effects;
      }
      
      public function get uri() : Uri {
         return this._uri;
      }
      
      public function get eventDispatcher() : EventDispatcher {
         return this._eventDispatcher;
      }
      
      public function get volume() : Number {
         return this._volume;
      }
      
      public function set volume(param1:Number) : void {
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._volume = param1;
         if((this._soundLoaded) && !(this._previousVolume == this._volume))
         {
            this.applyParam();
         }
         this._previousVolume = this._volume;
      }
      
      public function get busId() : int {
         return this._busId;
      }
      
      public function set busId(param1:int) : void {
         this._busId = param1;
         var _loc2_:IAudioBus = Tubul.getInstance().getBus(param1);
         if(_loc2_ != null)
         {
            _loc2_.eventDispatcher.addEventListener(AudioBusVolumeEvent.VOLUME_CHANGED,this.onAudioBusVolumeChanged);
         }
      }
      
      public function get currentFadeVolume() : Number {
         return this._fadeVolume;
      }
      
      public function set currentFadeVolume(param1:Number) : void {
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._fadeVolume = param1;
         if((this._soundLoaded) && !(this._previousFadeVolume == this._fadeVolume))
         {
            this.applyParam();
         }
         this._previousFadeVolume = this._fadeVolume;
      }
      
      public function get effectiveVolume() : Number {
         return this.busVolume * this.volume * this.currentFadeVolume;
      }
      
      public function get soundChannel() : SoundChannel {
         if(this._soundWrapper == null)
         {
            return null;
         }
         return Tubul.getInstance().soundMerger.getSoundChannel(this._soundWrapper);
      }
      
      public function get sound() : Sound {
         return this._sound;
      }
      
      public function set sound(param1:*) : void {
         this._sound = param1;
         this._soundLoaded = true;
         this.finishLoading();
      }
      
      public function get id() : int {
         return this._id;
      }
      
      public function get silence() : SoundSilence {
         return this._silence;
      }
      
      public function set silence(param1:SoundSilence) : void {
         this._silence = param1;
      }
      
      public function get busVolume() : Number {
         if(this.bus != null)
         {
            return this.bus.effectiveVolume;
         }
         return -1;
      }
      
      public function get noCutSilence() : Boolean {
         return this._noCutSilence;
      }
      
      public function set noCutSilence(param1:Boolean) : void {
         this._noCutSilence = param1;
      }
      
      public function get isPlaying() : Boolean {
         return this._playing;
      }
      
      public function get bus() : IAudioBus {
         return Tubul.getInstance().getBus(this.busId);
      }
      
      public function addEffect(param1:IEffect) : void {
         this._effects.push(param1);
      }
      
      public function removeEffect(param1:IEffect) : void {
         var _loc3_:IEffect = null;
         var _loc2_:uint = 0;
         for each (_loc3_ in this._effects)
         {
            if(_loc3_ == param1)
            {
               this._effects.splice(_loc2_,1);
               return;
            }
         }
      }
      
      public function play(param1:Boolean=false, param2:int=1, param3:VolumeFadeEffect=null, param4:VolumeFadeEffect=null) : void {
         var _loc6_:Callback = null;
         if(this.bus == null)
         {
            return;
         }
         if(this.bus.contains(this) == false)
         {
            _log.debug("[8142-DEBUG] 1 1 : addISound from MP3SoundDofus:408");
            this.bus.addISound(this);
         }
         if(this._playing)
         {
            return;
         }
         this._loop = param1;
         if(!this._loop)
         {
            param2 = 1;
         }
         this.setLoops(param2);
         if(!this._soundLoaded)
         {
            _loc6_ = new Callback(this.play,param1,param2,param3,param4);
            this._onLoadingComplete.push(_loc6_);
            return;
         }
         this._playing = true;
         if((param3) && !(param3.beginningValue == -1))
         {
            this.currentFadeVolume = param3.beginningValue;
         }
         this._soundWrapper = new SoundWrapper(this._sound,param2);
         this._soundWrapper.addEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
         this._soundWrapper.addEventListener(LoopEvent.SOUND_LOOP,this.onSoundLoop);
         this.applyParam();
         var _loc5_:String = "Play / file : " + this._uri.fileName + " / id : " + this._id + " / vol. réel : " + Math.round(this.effectiveVolume * 1000) / 1000 + " / vol. : " + Math.round(this._volume * 1000) / 1000;
         if(this is LocalizedSound)
         {
            _loc5_ = _loc5_ + " / vol. max : " + (this as LocalizedSound).volumeMax;
         }
         _loc5_ = _loc5_ + " / vol. fade : " + Math.round(this._fadeVolume * 1000) / 1000 + " / bus : " + this.bus.name + " / vol. bus : " + Math.round(this.bus.effectiveVolume * 1000) / 1000;
         if(param3 != null)
         {
            _loc5_ = _loc5_ + "\n[fade in] Valeur de fin : " + param3.endingValue + " / " + param3.timeFade + " sec.";
         }
         if(param4 != null)
         {
            _loc5_ = _loc5_ + "\n                [fade out] Valeur de fin : " + param4.endingValue + " / " + param4.timeFade + " sec.";
         }
         _log.debug(_loc5_);
         Tubul.getInstance().soundMerger.addSound(this._soundWrapper);
         if(param3)
         {
            this._currentRunningFade = param3;
            if(!this._currentRunningFade.hasEventListener(FadeEvent.COMPLETE))
            {
               this._currentRunningFade.addEventListener(FadeEvent.COMPLETE,this.onCurrentFadeComplete);
            }
            param3.attachToSoundSource(this);
            param3.start();
         }
         if(param4)
         {
            this._soundWrapper.notifyWhenEndOfFile(true,param4.timeFade);
            this._fadeOutFade = param4;
            this._soundWrapper.addEventListener(SoundWrapperEvent.SOON_END_OF_FILE,this.onEndOfFile);
         }
      }
      
      public function loadSound(param1:ICache) : void {
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onFailed);
         this._loader.load(this._uri,param1);
      }
      
      public function stop(param1:VolumeFadeEffect=null) : void {
         this.clearLoader();
         if(this._silence)
         {
            this._silence.clean();
         }
         if(!(this._soundWrapper == null) && (param1))
         {
            this._currentRunningFade = param1;
            this._currentRunningFade.attachToSoundSource(this);
            this._currentRunningFade.addEventListener(FadeEvent.COMPLETE,this.onCurrentFadeComplete);
            this._stopAfterCurrentFade = true;
            param1.start(false);
         }
         else
         {
            this.finishPlay();
         }
      }
      
      public function applyDynamicMix(param1:VolumeFadeEffect, param2:uint, param3:VolumeFadeEffect) : void {
      }
      
      public function setLoops(param1:int) : void {
         this._totalLoop = param1;
         if(this._soundWrapper)
         {
            this._soundWrapper.loops = this._totalLoop;
         }
      }
      
      public function clone() : ISound {
         var _loc1_:ISound = null;
         var _loc2_:uint = 0;
         if(this is LocalizedSound)
         {
            _loc2_ = EnumSoundType.LOCALIZED_SOUND;
         }
         else
         {
            _loc2_ = EnumSoundType.UNLOCALIZED_SOUND;
         }
         _loc1_ = SoundFactory.getSound(_loc2_,this.uri);
         _loc1_.busId = this.busId;
         _loc1_.volume = this.volume;
         _loc1_.currentFadeVolume = this.currentFadeVolume;
         _loc1_.setLoops(this.totalLoops);
         if(this.silence)
         {
            _loc1_.silence = this.silence;
         }
         _loc1_.noCutSilence = this.noCutSilence;
         return _loc1_;
      }
      
      public function setCurrentLoop(param1:uint) : void {
         if(this._soundWrapper)
         {
            this._soundWrapper.currentLoop = param1;
         }
      }
      
      private function clearLoader() : void {
         if(this._loader)
         {
            this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
            this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onFailed);
            this._loader = null;
         }
      }
      
      protected function applyParam() : void {
         if(this._soundWrapper == null)
         {
            return;
         }
         this._soundWrapper.volume = this.effectiveVolume;
      }
      
      protected function initSound() : void {
         this._soundLoaded = false;
         this._onLoadingComplete = new Vector.<Callback>();
         this._eventDispatcher = new EventDispatcher();
         this._busId = -1;
         this.volume = 1;
         this.currentFadeVolume = 1;
         this._previousVolume = 1;
         this._previousFadeVolume = 1;
         this._currentLoop = 0;
         this._totalLoop = -1;
      }
      
      private function finishLoading() : void {
         var _loc1_:LoadingSoundEvent = new LoadingSoundEvent(LoadingSoundEvent.LOADED);
         _loc1_.data = this;
         this._eventDispatcher.dispatchEvent(_loc1_);
         this.processQueueFunction();
      }
      
      private function processQueueFunction() : void {
         var _loc2_:Callback = null;
         var _loc1_:int = this._onLoadingComplete.length;
         if(_loc1_ > 0)
         {
            this._onLoadingComplete.reverse();
            for each (_loc2_ in this._onLoadingComplete)
            {
               _loc2_.exec();
               _loc2_ = null;
            }
         }
         this._onLoadingComplete = new Vector.<Callback>();
      }
      
      private function clean() : void {
         this._silence = null;
         if(this._currentRunningFade)
         {
            this._currentRunningFade.stop();
            this._currentRunningFade = null;
         }
         if(this._fadeOutFade)
         {
            this._fadeOutFade.stop();
            this._fadeOutFade = null;
         }
         this._sound = null;
         this._soundWrapper = null;
         this._uri = null;
      }
      
      private function finishPlay() : void {
         if(this._silence)
         {
            this._silence.clean();
         }
         if(this._soundWrapper != null)
         {
            this._soundWrapper.removeEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
            this._soundWrapper.removeEventListener(LoopEvent.SOUND_LOOP,this.onSoundLoop);
            if(this._loop)
            {
               Tubul.getInstance().soundMerger.removeSound(this._soundWrapper);
            }
         }
         if(this.bus != null)
         {
            this.bus.eventDispatcher.removeEventListener(AudioBusVolumeEvent.VOLUME_CHANGED,this.onAudioBusVolumeChanged);
         }
         this._playing = false;
         var _loc1_:SoundCompleteEvent = new SoundCompleteEvent(SoundCompleteEvent.SOUND_COMPLETE);
         _loc1_.sound = this;
         if(this._eventDispatcher == null)
         {
            this._eventDispatcher = new EventDispatcher();
         }
         this._eventDispatcher.dispatchEvent(_loc1_);
         _loc1_ = null;
      }
      
      protected function onSoundComplete(param1:Event) : void {
         this._soundWrapper.currentLoop = 0;
         if(this._silence)
         {
            _log.info("Playing silence (" + this._silence.silenceMin + "/" + this._silence.silenceMax + " sec) for the sound " + this._id + " (" + this._uri.fileName + ")");
            this._silence.addEventListener(SoundSilenceEvent.COMPLETE,this.onSilenceComplete);
            this._silence.start();
         }
         else
         {
            this.finishPlay();
         }
      }
      
      private function onLoaded(param1:ResourceLoadedEvent) : void {
         this._soundLoaded = true;
         this._sound = param1.resource;
         this.clearLoader();
         var _loc2_:LoadingSoundEvent = new LoadingSoundEvent(LoadingSoundEvent.LOADED);
         _loc2_.data = this;
         this._eventDispatcher.dispatchEvent(_loc2_);
         this.processQueueFunction();
      }
      
      private function onFailed(param1:ResourceErrorEvent) : void {
         var _loc2_:LoadingSoundEvent = new LoadingSoundEvent(LoadingSoundEvent.LOADING_FAILED);
         _loc2_.data = this;
         _log.error("Cannot load " + param1.uri + " : " + param1.errorMsg);
         this._eventDispatcher.dispatchEvent(_loc2_);
      }
      
      private function onEndOfFile(param1:SoundWrapperEvent) : void {
         if(this._fadeOutFade)
         {
            this._currentRunningFade = this._fadeOutFade;
            if(!this._currentRunningFade.hasEventListener(FadeEvent.COMPLETE))
            {
               this._currentRunningFade.addEventListener(FadeEvent.COMPLETE,this.onCurrentFadeComplete);
            }
            this._currentRunningFade.attachToSoundSource(this);
            this._currentRunningFade.start();
            this._fadeOutFade = null;
         }
         var _loc2_:MP3SoundEvent = new MP3SoundEvent(MP3SoundEvent.SOON_END_OF_FILE);
         _loc2_.sound = this;
         this.eventDispatcher.dispatchEvent(_loc2_);
      }
      
      private function onAudioBusVolumeChanged(param1:AudioBusVolumeEvent) : void {
         this.applyParam();
      }
      
      private function onSoundLoop(param1:LoopEvent) : void {
         this._currentLoop = param1.loop;
         var _loc2_:LoopEvent = new LoopEvent(LoopEvent.SOUND_LOOP);
         _loc2_.loop = this._currentLoop;
         _loc2_.sound = this;
         this.eventDispatcher.dispatchEvent(_loc2_);
      }
      
      private function onCurrentFadeComplete(param1:FadeEvent) : void {
         if(this._currentRunningFade == null)
         {
            return;
         }
         this._currentRunningFade.removeEventListener(FadeEvent.COMPLETE,this.onCurrentFadeComplete);
         this._currentRunningFade = null;
         if(this._stopAfterCurrentFade == true)
         {
            this.stop();
         }
         this._stopAfterCurrentFade = false;
      }
      
      private function onSilenceComplete(param1:SoundSilenceEvent) : void {
         this._silence.removeEventListener(SoundSilenceEvent.COMPLETE,this.onSilenceComplete);
         this.finishPlay();
      }
   }
}
