package com.ankamagames.tubul
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.tubul.events.*;
    import com.ankamagames.tubul.interfaces.*;
    import com.ankamagames.tubul.resources.adapters.*;
    import com.ankamagames.tubul.types.*;
    import com.ankamagames.tubul.types.bus.*;
    import com.ankamagames.tubul.utils.error.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Tubul extends EventDispatcher
    {
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
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Tubul));
        private static var _self:Tubul;

        public function Tubul()
        {
            if (_self)
            {
                throw new TubulError("Warning : Tubul is a singleton class and shoulnd\'t be instancied directly!");
            }
            this.init();
            return;
        }// end function

        public function get options() : TubulOptions
        {
            return this._tuOptions;
        }// end function

        public function get totalPlayingSounds() : uint
        {
            var _loc_2:IAudioBus = null;
            var _loc_1:uint = 0;
            for each (_loc_2 in this._audioBusList)
            {
                
                _loc_1 = _loc_1 + _loc_2.soundList.length;
            }
            return _loc_1;
        }// end function

        public function get localizedSoundListeners() : Array
        {
            return this._localizedSoundListeners;
        }// end function

        public function get earPosition() : Point
        {
            return this._earPosition;
        }// end function

        public function set earPosition(param1:Point) : void
        {
            var _loc_2:IAudioBus = null;
            this._earPosition = param1;
            for each (_loc_2 in this._audioBusList)
            {
                
                if (_loc_2 is LocalizedBus)
                {
                    (_loc_2 as LocalizedBus).updateObserverPosition(param1);
                }
            }
            return;
        }// end function

        public function get audioBusList() : Vector.<IAudioBus>
        {
            return this._audioBusList;
        }// end function

        public function get isActive() : Boolean
        {
            return true;
        }// end function

        public function get soundMerger() : SoundMerger
        {
            return this._soundMerger;
        }// end function

        public function getSoundById(param1:int) : ISound
        {
            var _loc_2:IAudioBus = null;
            var _loc_3:ISound = null;
            for each (_loc_2 in this.audioBusList)
            {
                
                for each (_loc_3 in _loc_2.soundList)
                {
                    
                    if (_loc_3.id == param1)
                    {
                        return _loc_3;
                    }
                }
            }
            return null;
        }// end function

        public function activate(param1:Boolean = true) : void
        {
            if (this.isActive)
            {
                _log.info("Tubul is now ACTIVATED");
            }
            else
            {
                _log.info("Tubul is now DESACTIVATED");
                this.resetTubul();
            }
            var _loc_2:* = new TubulEvent(TubulEvent.ACTIVATION);
            _loc_2.activated = this.isActive;
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function setDisplayOptions(param1:TubulOptions) : void
        {
            var _loc_2:String = null;
            var _loc_3:PropertyChangeEvent = null;
            this._tuOptions = param1;
            this._tuOptions.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            for (_loc_2 in this._tuOptions)
            {
                
                _loc_3 = new PropertyChangeEvent(this._tuOptions, _loc_2, this._tuOptions[_loc_2], this._tuOptions[_loc_2]);
            }
            return;
        }// end function

        public function addBus(param1:IAudioBus) : void
        {
            var _loc_2:* = param1.id;
            if (this._busDictionary[_loc_2] != null)
            {
                return;
            }
            if (this._audioBusList.length > BusConstants.MAXIMUM_NUMBER_OF_BUS)
            {
                throw new TubulError("The maximum number of audio Bus have been reached !");
            }
            this._audioBusList.push(param1);
            this._busDictionary[_loc_2] = param1;
            param1.eventDispatcher.addEventListener(AudioBusEvent.REMOVE_SOUND_IN_BUS, this.onRemoveSoundInBus);
            return;
        }// end function

        public function clearCache() : void
        {
            var _loc_1:IAudioBus = null;
            for each (_loc_1 in this._busDictionary)
            {
                
                _loc_1.clearCache();
            }
            return;
        }// end function

        public function getBus(param1:uint) : IAudioBus
        {
            if (this.contains(param1))
            {
                return this._busDictionary[param1];
            }
            _log.warn("The audio BUS " + param1 + " doesn\'t exists");
            return null;
        }// end function

        public function removeBus(param1:uint) : void
        {
            var _loc_2:IAudioBus = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            if (!this.isActive)
            {
                return;
            }
            if (this.contains(param1))
            {
                _loc_2 = this._busDictionary[param1];
                _loc_2.eventDispatcher.addEventListener(AudioBusEvent.REMOVE_SOUND_IN_BUS, this.onRemoveSoundInBus);
                delete this._busDictionary[param1];
                _loc_3 = this._audioBusList.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    if (this._audioBusList[_loc_4] == _loc_2)
                    {
                        this._audioBusList[_loc_4] = null;
                        this._audioBusList.splice(_loc_4, 1);
                        break;
                    }
                    _loc_4++;
                }
            }
            else
            {
                throw new TubulError("The audio BUS " + param1 + " doesn\'t exist !");
            }
            return;
        }// end function

        public function clearBuses() : void
        {
            var _loc_1:IAudioBus = null;
            if (!this.isActive)
            {
                return;
            }
            for each (_loc_1 in this._busDictionary)
            {
                
                this.removeBus(_loc_1.id);
            }
            return;
        }// end function

        public function contains(param1:uint) : Boolean
        {
            if (this._busDictionary[param1] != null)
            {
                return true;
            }
            return false;
        }// end function

        public function getLoadedSoundInformations(param1:Uri) : LoadedSoundInformations
        {
            if (this._loadedSoundsInformations[param1])
            {
                trace("Existe déjà");
            }
            return null;
        }// end function

        public function setLoadedSoundInformations(param1:Uri, param2:LoadedSoundInformations) : void
        {
            if (this._loadedSoundsInformations[param1])
            {
                trace("Existe déjà");
            }
            else
            {
                this._loadedSoundsInformations[param1] = param2;
            }
            return;
        }// end function

        public function addListener(param1:ILocalizedSoundListener) : void
        {
            if (!this.isActive)
            {
                return;
            }
            if (this._localizedSoundListeners == null)
            {
                this._localizedSoundListeners = new Array();
            }
            if (!this._localizedSoundListeners.indexOf(param1))
            {
                return;
            }
            this._localizedSoundListeners.push(param1);
            return;
        }// end function

        public function removeListener(param1:ILocalizedSoundListener) : void
        {
            if (this._localizedSoundListeners == null)
            {
                this._localizedSoundListeners = new Array();
            }
            var _loc_2:* = this._localizedSoundListeners.indexOf(param1);
            if (_loc_2 < 0)
            {
                return;
            }
            this._localizedSoundListeners[_loc_2] = null;
            this._localizedSoundListeners.splice(_loc_2, 1);
            return;
        }// end function

        public function dumpPlayingSounds() : void
        {
            var _loc_1:IAudioBus = null;
            var _loc_2:ISound = null;
            _log.debug("--------------- dumpPlayingSounds --------------------");
            for each (_loc_1 in this._audioBusList)
            {
                
                _log.debug(_loc_1.name);
                for each (_loc_2 in _loc_1.soundList)
                {
                    
                    _log.debug("-> " + _loc_2.uri);
                }
            }
            _log.debug("--------------- end --------------------");
            return;
        }// end function

        private function resetTubul() : void
        {
            var _loc_1:IAudioBus = null;
            for each (_loc_1 in this._audioBusList)
            {
                
                _loc_1.clear();
            }
            this._resourceLoader.removeEventListener(ResourceLoadedEvent.LOADED, this.onXMLSoundsLoaded);
            this._resourceLoader.removeEventListener(ResourceErrorEvent.ERROR, this.onXMLSoundsFailed);
            return;
        }// end function

        private function retriveRollOffPresets(param1:XML) : void
        {
            var _loc_3:XML = null;
            var _loc_4:RollOffPreset = null;
            var _loc_2:* = param1.elements();
            if (this._rollOffPresets == null)
            {
                this._rollOffPresets = new Array();
            }
            for each (_loc_3 in _loc_2)
            {
                
                _loc_4 = new RollOffPreset(uint(_loc_3.GainMax), uint(_loc_3.DistMax), uint(_loc_3.DistMaxSat));
                this._rollOffPresets[_loc_3.@id] = _loc_4;
            }
            return;
        }// end function

        public function init() : void
        {
            this._audioBusList = new Vector.<IAudioBus>;
            this._busDictionary = new Dictionary(true);
            this._XMLSoundFilesDictionary = new Dictionary();
            this._earPosition = new Point();
            this._loadedSoundsInformations = new Dictionary();
            AdapterFactory.addAdapter("mp3", MP3Adapter);
            this._resourceLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._resourceLoader.addEventListener(ResourceLoadedEvent.LOADED, this.onXMLSoundsLoaded);
            this._resourceLoader.addEventListener(ResourceErrorEvent.ERROR, this.onXMLSoundsFailed);
            this._soundMerger = new SoundMerger();
            return;
        }// end function

        private function setVolumeToBus(param1:int, param2:uint) : void
        {
            var _loc_3:* = Tubul.getInstance().getBus(param1);
            if (_loc_3 != null)
            {
                _loc_3.volume = param2 / 100;
            }
            return;
        }// end function

        private function onTimerEnd(event:TimerEvent) : void
        {
            this._resourceLoader.load([XMLSounds.BREED_BONES_BARKS, XMLSounds.ROLLOFF_PRESET]);
            return;
        }// end function

        private function onXMLSoundsLoaded(event:ResourceLoadedEvent) : void
        {
            var _loc_2:* = event.uri.fileName.split(".")[0];
            if (_loc_2 == XMLSounds.ROLLOFF_FILENAME)
            {
                this.retriveRollOffPresets(event.resource);
            }
            else if (!this._XMLSoundFilesDictionary[_loc_2])
            {
                this._XMLSoundFilesDictionary[_loc_2] = event.resource;
            }
            return;
        }// end function

        private function onXMLSoundsFailed(event:ResourceErrorEvent) : void
        {
            this.activate(false);
            _log.error("An XML sound file failed to load : " + event.uri + " / [" + event.errorCode + "] " + event.errorMsg);
            return;
        }// end function

        private function onRemoveSoundInBus(event:AudioBusEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        private function onPropertyChanged(event:PropertyChangeEvent) : void
        {
            switch(event.propertyName)
            {
                case "muteMusic":
                {
                    this.setVolumeToBus(0, event.propertyValue ? (0) : (this._tuOptions.volumeMusic));
                    break;
                }
                case "muteSound":
                {
                    this.setVolumeToBus(4, event.propertyValue ? (0) : (this._tuOptions.volumeSound));
                    break;
                }
                case "muteAmbientSound":
                {
                    this.setVolumeToBus(1, event.propertyValue ? (0) : (this._tuOptions.volumeAmbientSound));
                    this.setVolumeToBus(2, event.propertyValue ? (0) : (this._tuOptions.volumeAmbientSound));
                    this.setVolumeToBus(3, event.propertyValue ? (0) : (this._tuOptions.volumeAmbientSound));
                    this.setVolumeToBus(5, event.propertyValue ? (0) : (this._tuOptions.volumeAmbientSound));
                    this.setVolumeToBus(6, event.propertyValue ? (0) : (this._tuOptions.volumeAmbientSound));
                    this.setVolumeToBus(7, event.propertyValue ? (0) : (this._tuOptions.volumeAmbientSound));
                    break;
                }
                case "volumeMusic":
                {
                    if (this._tuOptions.muteMusic == false)
                    {
                        this.setVolumeToBus(0, event.propertyValue);
                    }
                    break;
                }
                case "volumeSound":
                {
                    if (this._tuOptions.muteSound == false)
                    {
                        this.setVolumeToBus(4, event.propertyValue);
                    }
                    break;
                }
                case "volumeAmbientSound":
                {
                    if (this._tuOptions.muteAmbientSound == false)
                    {
                        this.setVolumeToBus(1, event.propertyValue);
                        this.setVolumeToBus(2, event.propertyValue);
                        this.setVolumeToBus(3, event.propertyValue);
                        this.setVolumeToBus(5, event.propertyValue);
                        this.setVolumeToBus(6, event.propertyValue);
                        this.setVolumeToBus(7, event.propertyValue);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function getInstance() : Tubul
        {
            if (!_self)
            {
                _self = new Tubul;
            }
            return _self;
        }// end function

    }
}
