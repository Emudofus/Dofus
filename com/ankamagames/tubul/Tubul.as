package com.ankamagames.tubul
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import __AS3__.vec.Vector;
   import com.ankamagames.tubul.interfaces.IAudioBus;
   import flash.utils.Dictionary;
   import flash.geom.Point;
   import com.ankamagames.tubul.types.SoundMerger;
   import com.ankamagames.tubul.types.TubulOptions;
   import com.ankamagames.tubul.types.bus.LocalizedBus;
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.tubul.events.TubulEvent;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.tubul.utils.error.TubulError;
   import com.ankamagames.tubul.events.AudioBusEvent;
   import com.ankamagames.tubul.types.LoadedSoundInformations;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tubul.interfaces.ILocalizedSoundListener;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.tubul.types.RollOffPreset;
   import com.ankamagames.jerakine.resources.adapters.AdapterFactory;
   import com.ankamagames.tubul.resources.adapters.MP3Adapter;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import flash.events.TimerEvent;
   
   public class Tubul extends EventDispatcher
   {
      
      public function Tubul() {
         super();
         if(_self)
         {
            throw new TubulError("Warning : Tubul is a singleton class and shoulnd\'t be instancied directly!");
         }
         else
         {
            this.init();
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Tubul));
      
      private static var _self:Tubul;
      
      public static function getInstance() : Tubul {
         if(!_self)
         {
            _self = new Tubul();
         }
         return _self;
      }
      
      private var _resourceLoader:IResourceLoader;
      
      private var _audioBusList:Vector.<IAudioBus>;
      
      private var _busDictionary:Dictionary;
      
      private var _XMLSoundFilesDictionary:Dictionary;
      
      private var _rollOffPresets:Array;
      
      private var _earPosition:Point;
      
      private var _localizedSoundListeners:Array;
      
      private var _soundMerger:SoundMerger;
      
      private var _loadedSoundsInformations:Dictionary;
      
      public var playedCharacterId:int;
      
      private var _tuOptions:TubulOptions;
      
      public function get options() : TubulOptions {
         return this._tuOptions;
      }
      
      public function get totalPlayingSounds() : uint {
         var _loc2_:IAudioBus = null;
         var _loc1_:uint = 0;
         for each (_loc2_ in this._audioBusList)
         {
            _loc1_ = _loc1_ + _loc2_.soundList.length;
         }
         return _loc1_;
      }
      
      public function get localizedSoundListeners() : Array {
         return this._localizedSoundListeners;
      }
      
      public function get earPosition() : Point {
         return this._earPosition;
      }
      
      public function set earPosition(param1:Point) : void {
         var _loc2_:IAudioBus = null;
         this._earPosition = param1;
         for each (_loc2_ in this._audioBusList)
         {
            if(_loc2_ is LocalizedBus)
            {
               (_loc2_ as LocalizedBus).updateObserverPosition(param1);
            }
         }
      }
      
      public function get audioBusList() : Vector.<IAudioBus> {
         return this._audioBusList;
      }
      
      public function get isActive() : Boolean {
         return true;
      }
      
      public function get soundMerger() : SoundMerger {
         return this._soundMerger;
      }
      
      public function getSoundById(param1:int) : ISound {
         var _loc2_:IAudioBus = null;
         var _loc3_:ISound = null;
         for each (_loc2_ in this.audioBusList)
         {
            for each (_loc3_ in _loc2_.soundList)
            {
               if(_loc3_.id == param1)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public function activate(param1:Boolean=true) : void {
         if(this.isActive)
         {
            _log.info("Tubul is now ACTIVATED");
         }
         else
         {
            _log.info("Tubul is now DESACTIVATED");
            this.resetTubul();
         }
         var _loc2_:TubulEvent = new TubulEvent(TubulEvent.ACTIVATION);
         _loc2_.activated = this.isActive;
         dispatchEvent(_loc2_);
      }
      
      public function setDisplayOptions(param1:TubulOptions) : void {
         var _loc2_:String = null;
         var _loc3_:PropertyChangeEvent = null;
         this._tuOptions = param1;
         this._tuOptions.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         for (_loc2_ in this._tuOptions)
         {
            _loc3_ = new PropertyChangeEvent(this._tuOptions,_loc2_,this._tuOptions[_loc2_],this._tuOptions[_loc2_]);
         }
      }
      
      public function addBus(param1:IAudioBus) : void {
         var _loc2_:int = param1.id;
         if(this._busDictionary[_loc2_] != null)
         {
            return;
         }
         if(this._audioBusList.length > BusConstants.MAXIMUM_NUMBER_OF_BUS)
         {
            throw new TubulError("The maximum number of audio Bus have been reached !");
         }
         else
         {
            this._audioBusList.push(param1);
            this._busDictionary[_loc2_] = param1;
            param1.eventDispatcher.addEventListener(AudioBusEvent.REMOVE_SOUND_IN_BUS,this.onRemoveSoundInBus);
            return;
         }
      }
      
      public function clearCache() : void {
         var _loc1_:IAudioBus = null;
         for each (_loc1_ in this._busDictionary)
         {
            _loc1_.clearCache();
         }
      }
      
      public function getBus(param1:uint) : IAudioBus {
         if(this.contains(param1))
         {
            return this._busDictionary[param1];
         }
         _log.warn("The audio BUS " + param1 + " doesn\'t exists");
         return null;
      }
      
      public function removeBus(param1:uint) : void {
         var _loc2_:IAudioBus = null;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         if(!this.isActive)
         {
            return;
         }
         if(this.contains(param1))
         {
            _loc2_ = this._busDictionary[param1];
            _loc2_.eventDispatcher.addEventListener(AudioBusEvent.REMOVE_SOUND_IN_BUS,this.onRemoveSoundInBus);
            delete this._busDictionary[[param1]];
            _loc3_ = this._audioBusList.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(this._audioBusList[_loc4_] == _loc2_)
               {
                  this._audioBusList[_loc4_] = null;
                  this._audioBusList.splice(_loc4_,1);
                  break;
               }
               _loc4_++;
            }
            return;
         }
         throw new TubulError("The audio BUS " + param1 + " doesn\'t exist !");
      }
      
      public function clearBuses() : void {
         var _loc1_:IAudioBus = null;
         if(!this.isActive)
         {
            return;
         }
         for each (_loc1_ in this._busDictionary)
         {
            this.removeBus(_loc1_.id);
         }
      }
      
      public function contains(param1:uint) : Boolean {
         if(this._busDictionary[param1] != null)
         {
            return true;
         }
         return false;
      }
      
      public function getLoadedSoundInformations(param1:Uri) : LoadedSoundInformations {
         if(this._loadedSoundsInformations[param1])
         {
            trace("Existe déjà");
         }
         return null;
      }
      
      public function setLoadedSoundInformations(param1:Uri, param2:LoadedSoundInformations) : void {
         if(this._loadedSoundsInformations[param1])
         {
            trace("Existe déjà");
         }
         else
         {
            this._loadedSoundsInformations[param1] = param2;
         }
      }
      
      public function addListener(param1:ILocalizedSoundListener) : void {
         if(!this.isActive)
         {
            return;
         }
         if(this._localizedSoundListeners == null)
         {
            this._localizedSoundListeners = new Array();
         }
         if(!this._localizedSoundListeners.indexOf(param1))
         {
            return;
         }
         this._localizedSoundListeners.push(param1);
      }
      
      public function removeListener(param1:ILocalizedSoundListener) : void {
         if(this._localizedSoundListeners == null)
         {
            this._localizedSoundListeners = new Array();
         }
         var _loc2_:int = this._localizedSoundListeners.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._localizedSoundListeners[_loc2_] = null;
         this._localizedSoundListeners.splice(_loc2_,1);
      }
      
      public function dumpPlayingSounds() : void {
         var _loc1_:IAudioBus = null;
         var _loc2_:ISound = null;
         _log.debug("--------------- dumpPlayingSounds --------------------");
         for each (_loc1_ in this._audioBusList)
         {
            _log.debug(_loc1_.name);
            for each (_loc2_ in _loc1_.soundList)
            {
               _log.debug("-> " + _loc2_.uri);
            }
         }
         _log.debug("--------------- end --------------------");
      }
      
      private function resetTubul() : void {
         var _loc1_:IAudioBus = null;
         for each (_loc1_ in this._audioBusList)
         {
            _loc1_.clear();
         }
         this._resourceLoader.removeEventListener(ResourceLoadedEvent.LOADED,this.onXMLSoundsLoaded);
         this._resourceLoader.removeEventListener(ResourceErrorEvent.ERROR,this.onXMLSoundsFailed);
      }
      
      private function retriveRollOffPresets(param1:XML) : void {
         var _loc3_:XML = null;
         var _loc4_:RollOffPreset = null;
         var _loc2_:XMLList = param1.elements();
         if(this._rollOffPresets == null)
         {
            this._rollOffPresets = new Array();
         }
         for each (_loc3_ in _loc2_)
         {
            _loc4_ = new RollOffPreset(uint(_loc3_.GainMax),uint(_loc3_.DistMax),uint(_loc3_.DistMaxSat));
            this._rollOffPresets[_loc3_.@id] = _loc4_;
         }
      }
      
      public function init() : void {
         this._audioBusList = new Vector.<IAudioBus>();
         this._busDictionary = new Dictionary(true);
         this._XMLSoundFilesDictionary = new Dictionary();
         this._earPosition = new Point();
         this._loadedSoundsInformations = new Dictionary();
         AdapterFactory.addAdapter("mp3",MP3Adapter);
         this._resourceLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         this._resourceLoader.addEventListener(ResourceLoadedEvent.LOADED,this.onXMLSoundsLoaded);
         this._resourceLoader.addEventListener(ResourceErrorEvent.ERROR,this.onXMLSoundsFailed);
         this._soundMerger = new SoundMerger();
      }
      
      private function setVolumeToBus(param1:int, param2:uint) : void {
         var _loc3_:IAudioBus = Tubul.getInstance().getBus(param1);
         if(_loc3_ != null)
         {
            _loc3_.volume = param2 / 100;
         }
      }
      
      private function onTimerEnd(param1:TimerEvent) : void {
         this._resourceLoader.load([XMLSounds.BREED_BONES_BARKS,XMLSounds.ROLLOFF_PRESET]);
      }
      
      private function onXMLSoundsLoaded(param1:ResourceLoadedEvent) : void {
         var _loc2_:String = param1.uri.fileName.split(".")[0];
         if(_loc2_ == XMLSounds.ROLLOFF_FILENAME)
         {
            this.retriveRollOffPresets(param1.resource);
         }
         else
         {
            if(!this._XMLSoundFilesDictionary[_loc2_])
            {
               this._XMLSoundFilesDictionary[_loc2_] = param1.resource;
            }
         }
      }
      
      private function onXMLSoundsFailed(param1:ResourceErrorEvent) : void {
         this.activate(false);
         _log.error("An XML sound file failed to load : " + param1.uri + " / [" + param1.errorCode + "] " + param1.errorMsg);
      }
      
      private function onRemoveSoundInBus(param1:AudioBusEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onPropertyChanged(param1:PropertyChangeEvent) : void {
         switch(param1.propertyName)
         {
            case "muteMusic":
               this.setVolumeToBus(0,param1.propertyValue?0:this._tuOptions.volumeMusic);
               break;
            case "muteSound":
               this.setVolumeToBus(4,param1.propertyValue?0:this._tuOptions.volumeSound);
               break;
            case "muteAmbientSound":
               this.setVolumeToBus(1,param1.propertyValue?0:this._tuOptions.volumeAmbientSound);
               this.setVolumeToBus(2,param1.propertyValue?0:this._tuOptions.volumeAmbientSound);
               this.setVolumeToBus(3,param1.propertyValue?0:this._tuOptions.volumeAmbientSound);
               this.setVolumeToBus(5,param1.propertyValue?0:this._tuOptions.volumeAmbientSound);
               this.setVolumeToBus(6,param1.propertyValue?0:this._tuOptions.volumeAmbientSound);
               this.setVolumeToBus(7,param1.propertyValue?0:this._tuOptions.volumeAmbientSound);
               break;
            case "volumeMusic":
               if(this._tuOptions.muteMusic == false)
               {
                  this.setVolumeToBus(0,param1.propertyValue);
               }
               break;
            case "volumeSound":
               if(this._tuOptions.muteSound == false)
               {
                  this.setVolumeToBus(4,param1.propertyValue);
               }
               break;
            case "volumeAmbientSound":
               if(this._tuOptions.muteAmbientSound == false)
               {
                  this.setVolumeToBus(1,param1.propertyValue);
                  this.setVolumeToBus(2,param1.propertyValue);
                  this.setVolumeToBus(3,param1.propertyValue);
                  this.setVolumeToBus(5,param1.propertyValue);
                  this.setVolumeToBus(6,param1.propertyValue);
                  this.setVolumeToBus(7,param1.propertyValue);
               }
               break;
         }
      }
   }
}
