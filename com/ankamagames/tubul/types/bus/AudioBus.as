package com.ankamagames.tubul.types.bus
{
   import com.ankamagames.tubul.interfaces.IAudioBus;
   import com.ankamagames.jerakine.logger.Logger;
   import __AS3__.vec.Vector;
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.jerakine.newCache.ICache;
   import flash.events.EventDispatcher;
   import com.ankamagames.tubul.interfaces.IEffect;
   import com.ankamagames.tubul.types.VolumeFadeEffect;
   import com.ankamagames.jerakine.resources.CacheableResource;
   import com.ankamagames.tubul.events.SoundCompleteEvent;
   import com.ankamagames.tubul.enum.EventListenerPriority;
   import com.ankamagames.tubul.Tubul;
   import com.TubulConstants;
   import com.ankamagames.tubul.events.LoadingSound.LoadingSoundEvent;
   import com.ankamagames.jerakine.newCache.impl.Cache;
   import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.tubul.events.AudioBusVolumeEvent;
   import com.ankamagames.tubul.interfaces.ILocalizedSoundListener;
   import com.ankamagames.tubul.events.FadeEvent;
   import com.ankamagames.tubul.events.AudioBusEvent;
   import com.ankamagames.jerakine.logger.Log;
   
   public class AudioBus extends Object implements IAudioBus
   {
      
      public function AudioBus(param1:int, param2:String) {
         super();
         this.init(param1,param2);
      }
      
      protected static var _totalPlayingSounds:int = 0;
      
      protected static var id_sound:uint = 0;
      
      private const _log:Logger = Log.getLogger(getQualifiedClassName(AudioBus));
      
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
      
      public function get soundList() : Vector.<ISound> {
         return this._soundVector;
      }
      
      public function set volumeMax(param1:Number) : void {
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._volumeMax = param1;
      }
      
      public function get volumeMax() : Number {
         return this._volumeMax;
      }
      
      public function get numberSoundsLimitation() : int {
         return this._numberSoundsLimitation;
      }
      
      public function set numberSoundsLimitation(param1:int) : void {
         this._numberSoundsLimitation = param1;
      }
      
      public function get effects() : Vector.<IEffect> {
         return this._effects;
      }
      
      public function get eventDispatcher() : EventDispatcher {
         return this._eventDispatcher;
      }
      
      public function get name() : String {
         return this._name;
      }
      
      public function get id() : uint {
         return this._id;
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
         if(isNaN(this.volumeMax))
         {
            this._volumeMax = this._volume;
         }
         this._log.warn("Bus " + "(" + this.id + ") vol. réel : " + this.effectiveVolume + " (vol. max : " + this._volumeMax + " / % vol : " + this._volume + ") [" + this.name + "]");
         this.informSoundsNewVolume();
      }
      
      public function get volume() : Number {
         return this._volume;
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
         this.informSoundsNewVolume();
      }
      
      public function get effectiveVolume() : Number {
         return Math.round(this._volume * this._volumeMax * this._fadeVolume * 1000) / 1000;
      }
      
      public function clear(param1:VolumeFadeEffect=null) : void {
         var _loc2_:ISound = null;
         for each (_loc2_ in this._soundVector)
         {
            this.removeSound(_loc2_,param1);
         }
      }
      
      public function playISound(param1:ISound, param2:Boolean=false, param3:int=-1) : void {
         var _loc5_:ISound = null;
         var _loc4_:* = false;
         for each (_loc5_ in this._soundVector)
         {
            if(_loc5_ === param1)
            {
               _loc4_ = true;
               break;
            }
         }
         if(!_loc4_)
         {
            this.addISound(param1);
         }
         if(!param1.isPlaying)
         {
            param1.play(param2,param3);
         }
      }
      
      public function addISound(param1:ISound) : void {
         var _loc3_:ISound = null;
         var _loc4_:ISound = null;
         var _loc5_:IEffect = null;
         var _loc6_:IAudioBus = null;
         var _loc7_:* = false;
         var _loc8_:* = false;
         var _loc9_:CacheableResource = null;
         var _loc10_:* = undefined;
         param1.eventDispatcher.addEventListener(SoundCompleteEvent.SOUND_COMPLETE,this.onSoundComplete,false,EventListenerPriority.MINIMAL,true);
         var _loc2_:* = "";
         for each (_loc3_ in this.soundList)
         {
            _loc2_ = _loc2_ + (" " + _loc3_.id + ";" + _loc3_.uri);
         }
         if(Tubul.getInstance().totalPlayingSounds >= TubulConstants.MAXIMUM_SOUNDS_PLAYING_SAME_TIME)
         {
            this._log.warn("We have reached the maximum number of sounds playing simultaneously");
            this._log.warn("");
            for each (_loc6_ in Tubul.getInstance().audioBusList)
            {
               this._log.warn("Registered sounds in bus " + _loc6_.name + " :");
               _loc7_ = this.cleanBus(_loc6_.soundList);
            }
            if(!_loc7_)
            {
               return;
            }
         }
         if(this._numberSoundsLimitation >= 0 && this.soundList.length >= this._numberSoundsLimitation)
         {
            this._log.warn("We have reached the maximum number of sounds for this bus (" + this._id + " / " + this._name + ")");
            this._log.warn("Registered sounds in bus " + this._name + " :");
            _loc8_ = this.cleanBus(this.soundList);
            if(!_loc8_)
            {
               return;
            }
         }
         this._log.warn("Registered sounds in bus " + this._name + " :");
         for each (_loc4_ in this.soundList)
         {
            this._log.warn("- " + _loc4_.uri);
         }
         if(this.contains(param1))
         {
            return;
         }
         param1.busId = this.id;
         for each (_loc5_ in this._effects)
         {
            param1.addEffect(_loc5_);
         }
         this._soundVector.push(param1);
         if(this._cache.contains(TubulConstants.PREFIXE_LOADER + param1.uri.toSum()))
         {
            _loc9_ = this._cache.peek(TubulConstants.PREFIXE_LOADER + param1.uri.toSum());
            _loc10_ = _loc9_.resource;
            param1.sound = _loc10_;
         }
         else
         {
            param1.loadSound(this._cache);
            param1.eventDispatcher.addEventListener(LoadingSoundEvent.LOADED,this.onLoadComplete);
            param1.eventDispatcher.addEventListener(LoadingSoundEvent.LOADING_FAILED,this.onLoadFail);
         }
      }
      
      private function cleanBus(param1:Vector.<ISound>) : Boolean {
         var _loc2_:ISound = null;
         var _loc3_:* = false;
         for each (_loc2_ in param1)
         {
            _loc3_ = false;
            if(!_loc2_.isPlaying)
            {
               this.removeSound(_loc2_);
               _loc3_ = true;
            }
            this._log.warn("- " + _loc2_.uri);
         }
         return _loc3_;
      }
      
      public function addEffect(param1:IEffect) : void {
         var _loc2_:IEffect = null;
         var _loc3_:ISound = null;
         for each (_loc2_ in this._effects)
         {
            if(_loc2_.name == param1.name)
            {
               return;
            }
         }
         this._effects.push(param1);
         for each (_loc3_ in this._soundVector)
         {
            _loc3_.addEffect(param1);
         }
      }
      
      public function removeEffect(param1:IEffect) : void {
         var _loc3_:IEffect = null;
         var _loc4_:ISound = null;
         var _loc2_:uint = 0;
         for each (_loc3_ in this._effects)
         {
            if(_loc3_ == param1)
            {
               this._effects.splice(_loc2_,1);
            }
            else
            {
               _loc2_++;
            }
         }
         for each (_loc4_ in this._soundVector)
         {
            _loc4_.removeEffect(param1);
         }
      }
      
      public function play() : void {
         var _loc1_:ISound = null;
         for each (_loc1_ in this._soundVector)
         {
            _loc1_.play();
         }
      }
      
      public function stop() : void {
         var _loc1_:ISound = null;
         for each (_loc1_ in this._soundVector)
         {
            _loc1_.stop();
         }
      }
      
      public function applyDynamicMix(param1:VolumeFadeEffect, param2:uint, param3:VolumeFadeEffect) : void {
      }
      
      public function contains(param1:ISound) : Boolean {
         var _loc2_:ISound = null;
         for each (_loc2_ in this._soundVector)
         {
            if(_loc2_.id == param1.id)
            {
               return true;
            }
         }
         return false;
      }
      
      public function clearCache() : void {
         this._cache = Cache.create(TubulConstants.MAXIMUM_BOUNDS_CACHE,new LruGarbageCollector(),getQualifiedClassName(this));
      }
      
      private function init(param1:int, param2:String) : void {
         this._eventDispatcher = new EventDispatcher();
         this._cache = Cache.create(TubulConstants.MAXIMUM_BOUNDS_CACHE,new LruGarbageCollector(),getQualifiedClassName(this));
         this._soundVector = new Vector.<ISound>();
         this._name = param2;
         this._id = param1;
         this._effects = new Vector.<IEffect>();
         this.volume = 1;
         this.currentFadeVolume = 1;
      }
      
      protected function removeSound(param1:ISound, param2:VolumeFadeEffect=null) : uint {
         var sound3:ISound = null;
         var pISound:ISound = param1;
         var pFade:VolumeFadeEffect = param2;
         if(!this._soundVector)
         {
            return 0;
         }
         if(pISound == null)
         {
            this._log.warn("We tried to remove a null-sound.");
            return this._soundVector.length;
         }
         var indexOfSound:int = this._soundVector.indexOf(pISound);
         try
         {
            this._soundVector.splice(indexOfSound,1);
         }
         catch(e:Error)
         {
            _log.warn("We tried to remove a non existing sound. Allready removed ? (" + pISound.uri + ")");
         }
         var busState:String = "";
         for each (sound3 in this.soundList)
         {
            busState = busState + (" " + sound3.id + ";" + sound3.uri);
         }
         pISound.eventDispatcher.removeEventListener(SoundCompleteEvent.SOUND_COMPLETE,this.onSoundComplete);
         pISound.eventDispatcher.removeEventListener(LoadingSoundEvent.LOADING_FAILED,this.onLoadFail);
         if(pISound.isPlaying)
         {
            pISound.stop(pFade);
         }
         pISound = null;
         return this._soundVector.length;
      }
      
      protected function getOlderSound() : ISound {
         var _loc1_:ISound = null;
         var _loc2_:ISound = null;
         for each (_loc2_ in this._soundVector)
         {
            if(_loc1_ == null)
            {
               _loc1_ = _loc2_;
            }
            else
            {
               if(_loc2_.id < _loc1_.id)
               {
                  _loc1_ = _loc2_;
               }
            }
         }
         return _loc1_;
      }
      
      protected function informSoundsNewVolume() : void {
         var _loc1_:AudioBusVolumeEvent = new AudioBusVolumeEvent(AudioBusVolumeEvent.VOLUME_CHANGED);
         _loc1_.newVolume = this.effectiveVolume;
         this._eventDispatcher.dispatchEvent(_loc1_);
      }
      
      private function onLoadComplete(param1:LoadingSoundEvent) : void {
      }
      
      private function onLoadFail(param1:LoadingSoundEvent) : void {
         this._log.warn("A sound failed to load : " + param1.data.uri);
         this.removeSound(param1.data);
      }
      
      protected function onSoundComplete(param1:SoundCompleteEvent) : void {
         var _loc2_:ILocalizedSoundListener = null;
         this._eventDispatcher.dispatchEvent(param1);
         for each (_loc2_ in Tubul.getInstance().localizedSoundListeners)
         {
            _loc2_.removeSoundEntity(param1.sound);
         }
         this.removeSound(param1.sound);
         var param1:SoundCompleteEvent = null;
      }
      
      protected function onFadeBeforeDeleteComplete(param1:FadeEvent) : void {
         if(param1.soundSource is ISound)
         {
            this.removeSound(param1.soundSource as ISound);
         }
      }
      
      private function onRemoveSound(param1:ISound) : void {
         var _loc2_:AudioBusEvent = new AudioBusEvent(AudioBusEvent.REMOVE_SOUND_IN_BUS);
         _loc2_.sound = param1;
         this._eventDispatcher.dispatchEvent(_loc2_);
      }
      
      private function onAddSound(param1:ISound) : void {
         var _loc2_:AudioBusEvent = new AudioBusEvent(AudioBusEvent.ADD_SOUND_IN_BUS);
         _loc2_.sound = param1;
         this._eventDispatcher.dispatchEvent(_loc2_);
      }
   }
}
