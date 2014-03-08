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
   import __AS3__.vec.*;
   import com.ankamagames.tubul.events.LoadingSound.LoadingSoundEvent;
   import com.ankamagames.tubul.events.SoundCompleteEvent;
   import com.ankamagames.tubul.events.SoundSilenceEvent;
   import com.ankamagames.tubul.events.MP3SoundEvent;
   
   public class MP3SoundDofus extends Object implements ISound
   {
      
      public function MP3SoundDofus(id:uint, uri:Uri, isStereo:Boolean=false) {
         super();
         this.initSound();
         this._uri = uri;
         this._id = id;
         this._effects = new Vector.<IEffect>();
         this._stereo = isStereo;
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
      
      public function set volume(pVolume:Number) : void {
         if(pVolume > 1)
         {
            pVolume = 1;
         }
         if(pVolume < 0)
         {
            pVolume = 0;
         }
         this._volume = pVolume;
         if((this._soundLoaded) && (!(this._previousVolume == this._volume)))
         {
            this.applyParam();
         }
         this._previousVolume = this._volume;
      }
      
      public function get busId() : int {
         return this._busId;
      }
      
      public function set busId(pBus:int) : void {
         this._busId = pBus;
         var audioBus:IAudioBus = Tubul.getInstance().getBus(pBus);
         if(audioBus != null)
         {
            audioBus.eventDispatcher.addEventListener(AudioBusVolumeEvent.VOLUME_CHANGED,this.onAudioBusVolumeChanged);
         }
      }
      
      public function get currentFadeVolume() : Number {
         return this._fadeVolume;
      }
      
      public function set currentFadeVolume(pFadeVolume:Number) : void {
         if(pFadeVolume > 1)
         {
            pFadeVolume = 1;
         }
         if(pFadeVolume < 0)
         {
            pFadeVolume = 0;
         }
         this._fadeVolume = pFadeVolume;
         if((this._soundLoaded) && (!(this._previousFadeVolume == this._fadeVolume)))
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
      
      public function set sound(sound:*) : void {
         this._sound = sound;
         this._soundLoaded = true;
         this.finishLoading();
      }
      
      public function get id() : int {
         return this._id;
      }
      
      public function get silence() : SoundSilence {
         return this._silence;
      }
      
      public function set silence(pSilence:SoundSilence) : void {
         this._silence = pSilence;
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
      
      public function set noCutSilence(pNoCutSilence:Boolean) : void {
         this._noCutSilence = pNoCutSilence;
      }
      
      public function get isPlaying() : Boolean {
         return this._playing;
      }
      
      public function get bus() : IAudioBus {
         return Tubul.getInstance().getBus(this.busId);
      }
      
      public function addEffect(pEffect:IEffect) : void {
         this._effects.push(pEffect);
      }
      
      public function removeEffect(pEffect:IEffect) : void {
         var effect:IEffect = null;
         var compt:uint = 0;
         for each (effect in this._effects)
         {
            if(effect == pEffect)
            {
               this._effects.splice(compt,1);
               return;
            }
         }
      }
      
      public function play(pLoop:Boolean=false, pLoops:int=1, pFadeIn:VolumeFadeEffect=null, pFadeOut:VolumeFadeEffect=null) : void {
         var playCallback:Callback = null;
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
         this._loop = pLoop;
         if(!this._loop)
         {
            pLoops = 1;
         }
         this.setLoops(pLoops);
         if(!this._soundLoaded)
         {
            playCallback = new Callback(this.play,pLoop,pLoops,pFadeIn,pFadeOut);
            this._onLoadingComplete.push(playCallback);
            return;
         }
         this._playing = true;
         if((pFadeIn) && (!(pFadeIn.beginningValue == -1)))
         {
            this.currentFadeVolume = pFadeIn.beginningValue;
         }
         this._soundWrapper = new SoundWrapper(this._sound,pLoops);
         this._soundWrapper.addEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
         this._soundWrapper.addEventListener(LoopEvent.SOUND_LOOP,this.onSoundLoop);
         this.applyParam();
         var textLog:String = "Play / file : " + this._uri.fileName + " / id : " + this._id + " / vol. réel : " + Math.round(this.effectiveVolume * 1000) / 1000 + " / vol. : " + Math.round(this._volume * 1000) / 1000;
         if(this is LocalizedSound)
         {
            textLog = textLog + " / vol. max : " + (this as LocalizedSound).volumeMax;
         }
         textLog = textLog + " / vol. fade : " + Math.round(this._fadeVolume * 1000) / 1000 + " / bus : " + this.bus.name + " / vol. bus : " + Math.round(this.bus.effectiveVolume * 1000) / 1000;
         if(pFadeIn != null)
         {
            textLog = textLog + "\n[fade in] Valeur de fin : " + pFadeIn.endingValue + " / " + pFadeIn.timeFade + " sec.";
         }
         if(pFadeOut != null)
         {
            textLog = textLog + "\n                [fade out] Valeur de fin : " + pFadeOut.endingValue + " / " + pFadeOut.timeFade + " sec.";
         }
         _log.debug(textLog);
         Tubul.getInstance().soundMerger.addSound(this._soundWrapper);
         if(pFadeIn)
         {
            this._currentRunningFade = pFadeIn;
            if(!this._currentRunningFade.hasEventListener(FadeEvent.COMPLETE))
            {
               this._currentRunningFade.addEventListener(FadeEvent.COMPLETE,this.onCurrentFadeComplete);
            }
            pFadeIn.attachToSoundSource(this);
            pFadeIn.start();
         }
         if(pFadeOut)
         {
            this._soundWrapper.notifyWhenEndOfFile(true,pFadeOut.timeFade);
            this._fadeOutFade = pFadeOut;
            this._soundWrapper.addEventListener(SoundWrapperEvent.SOON_END_OF_FILE,this.onEndOfFile);
         }
      }
      
      public function loadSound(cache:ICache) : void {
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onFailed);
         this._loader.load(this._uri,cache);
      }
      
      public function stop(pFadeEffect:VolumeFadeEffect=null) : void {
         this.clearLoader();
         if(this._silence)
         {
            this._silence.clean();
         }
         if((!(this._soundWrapper == null)) && (pFadeEffect))
         {
            this._currentRunningFade = pFadeEffect;
            this._currentRunningFade.attachToSoundSource(this);
            this._currentRunningFade.addEventListener(FadeEvent.COMPLETE,this.onCurrentFadeComplete);
            this._stopAfterCurrentFade = true;
            pFadeEffect.start(false);
         }
         else
         {
            this.finishPlay();
         }
      }
      
      public function applyDynamicMix(pFadeIn:VolumeFadeEffect, pWaitingTime:uint, pFadeOut:VolumeFadeEffect) : void {
      }
      
      public function setLoops(pLoops:int) : void {
         this._totalLoop = pLoops;
         if(this._soundWrapper)
         {
            this._soundWrapper.loops = this._totalLoop;
         }
      }
      
      public function clone() : ISound {
         var sound:ISound = null;
         var type:uint = 0;
         if(this is LocalizedSound)
         {
            type = EnumSoundType.LOCALIZED_SOUND;
         }
         else
         {
            type = EnumSoundType.UNLOCALIZED_SOUND;
         }
         sound = SoundFactory.getSound(type,this.uri);
         sound.busId = this.busId;
         sound.volume = this.volume;
         sound.currentFadeVolume = this.currentFadeVolume;
         sound.setLoops(this.totalLoops);
         if(this.silence)
         {
            sound.silence = this.silence;
         }
         sound.noCutSilence = this.noCutSilence;
         return sound;
      }
      
      public function setCurrentLoop(pLoop:uint) : void {
         if(this._soundWrapper)
         {
            this._soundWrapper.currentLoop = pLoop;
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
         var lse:LoadingSoundEvent = new LoadingSoundEvent(LoadingSoundEvent.LOADED);
         lse.data = this;
         this._eventDispatcher.dispatchEvent(lse);
         this.processQueueFunction();
      }
      
      private function processQueueFunction() : void {
         var callback:Callback = null;
         var size:int = this._onLoadingComplete.length;
         if(size > 0)
         {
            this._onLoadingComplete.reverse();
            for each (callback in this._onLoadingComplete)
            {
               callback.exec();
               callback = null;
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
         var sce:SoundCompleteEvent = new SoundCompleteEvent(SoundCompleteEvent.SOUND_COMPLETE);
         sce.sound = this;
         if(this._eventDispatcher == null)
         {
            this._eventDispatcher = new EventDispatcher();
         }
         this._eventDispatcher.dispatchEvent(sce);
         sce = null;
      }
      
      protected function onSoundComplete(pEvent:Event) : void {
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
      
      private function onLoaded(pEvent:ResourceLoadedEvent) : void {
         this._soundLoaded = true;
         this._sound = pEvent.resource;
         this.clearLoader();
         var lse:LoadingSoundEvent = new LoadingSoundEvent(LoadingSoundEvent.LOADED);
         lse.data = this;
         this._eventDispatcher.dispatchEvent(lse);
         this.processQueueFunction();
      }
      
      private function onFailed(pEvent:ResourceErrorEvent) : void {
         var lse:LoadingSoundEvent = new LoadingSoundEvent(LoadingSoundEvent.LOADING_FAILED);
         lse.data = this;
         _log.error("Cannot load " + pEvent.uri + " : " + pEvent.errorMsg);
         this._eventDispatcher.dispatchEvent(lse);
      }
      
      private function onEndOfFile(pEvent:SoundWrapperEvent) : void {
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
         var mse:MP3SoundEvent = new MP3SoundEvent(MP3SoundEvent.SOON_END_OF_FILE);
         mse.sound = this;
         this.eventDispatcher.dispatchEvent(mse);
      }
      
      private function onAudioBusVolumeChanged(pEvent:AudioBusVolumeEvent) : void {
         this.applyParam();
      }
      
      private function onSoundLoop(pEvent:LoopEvent) : void {
         this._currentLoop = pEvent.loop;
         var event:LoopEvent = new LoopEvent(LoopEvent.SOUND_LOOP);
         event.loop = this._currentLoop;
         event.sound = this;
         this.eventDispatcher.dispatchEvent(event);
      }
      
      private function onCurrentFadeComplete(pEvent:FadeEvent) : void {
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
      
      private function onSilenceComplete(pEvent:SoundSilenceEvent) : void {
         this._silence.removeEventListener(SoundSilenceEvent.COMPLETE,this.onSilenceComplete);
         this.finishPlay();
      }
   }
}
