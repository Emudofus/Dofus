package com.ankamagames.dofus.kernel.sound.manager
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.kernel.sound.manager.*;
    import com.ankamagames.dofus.kernel.sound.parser.*;
    import com.ankamagames.dofus.kernel.sound.type.*;
    import com.ankamagames.dofus.kernel.sound.utils.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.parser.*;
    import com.ankamagames.tiphon.engine.*;
    import com.ankamagames.tubul.*;
    import com.ankamagames.tubul.enum.*;
    import com.ankamagames.tubul.events.*;
    import com.ankamagames.tubul.events.LoadingSound.*;
    import com.ankamagames.tubul.factory.*;
    import com.ankamagames.tubul.interfaces.*;
    import com.ankamagames.tubul.types.*;
    import com.ankamagames.tubul.types.effects.*;
    import com.ankamagames.tubul.types.sounds.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.utils.*;

    public class ClassicSoundManager extends EventDispatcher implements ISoundManager
    {
        private var _previousSubareaId:int;
        private var _criterionSubarea:int;
        private var _entitySounds:Array;
        private var _reverseEntitySounds:Dictionary;
        private var _entityDictionary:Dictionary;
        private var _rollOffPresets:Array;
        private var _XMLSoundFilesDictionary:Dictionary;
        private var _XMLSoundFilesToLoad:Array;
        private var _presetResourceLoader:IResourceLoader;
        private var _XMLSoundFilesResourceLoader:IResourceLoader;
        private var _introHarmonicOne:ISound;
        private var _introHarmonicTwo:ISound;
        private var _introHarmonicOneLoaded:Boolean = false;
        private var _introHarmonicTwoLoaded:Boolean = false;
        private var _introFirstHarmonic:Boolean;
        private var _ambientManager:AmbientSoundsManager;
        private var _localizedSoundsManager:LocalizedSoundsManager;
        private var _fightMusicManager:FightMusicManager;
        private var _forceSounds:Boolean = false;
        private var _soundDirectoryExist:Boolean = false;
        private var _inFight:Boolean;
        private var _indoor:int = 0;
        private var _lowPassFilter:LowPassFilter;
        private var _adminSounds:Dictionary;
        private var _adminPlaylist:PlayList;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ClassicSoundManager));
        private static var _self:ISoundManager;

        public function ClassicSoundManager()
        {
            if (_self)
            {
                throw new Error("Warning : ClassicSoundManager is a singleton class and shoulnd\'t be instancied directly!");
            }
            this.init();
            return;
        }// end function

        public function set soundDirectoryExist(param1:Boolean) : void
        {
            this._soundDirectoryExist = param1;
            return;
        }// end function

        public function get soundDirectoryExist() : Boolean
        {
            return this._soundDirectoryExist;
        }// end function

        public function get soundIsActivate() : Boolean
        {
            return this.checkIfAvailable();
        }// end function

        public function get entitySounds() : Array
        {
            return this._entitySounds;
        }// end function

        public function get reverseEntitySounds() : Dictionary
        {
            return this._reverseEntitySounds;
        }// end function

        public function set forceSoundsDebugMode(param1:Boolean) : void
        {
            this._forceSounds = param1;
            if (this._forceSounds)
            {
                this.initTubul();
                if (this._localizedSoundsManager != null && this._localizedSoundsManager.isInitialized)
                {
                    this._localizedSoundsManager.playLocalizedSounds();
                }
                if (this._ambientManager != null)
                {
                    this._ambientManager.playMusicAndAmbient();
                }
                if (this._fightMusicManager != null && this._inFight)
                {
                    this._fightMusicManager.playFightMusic();
                }
            }
            else
            {
                this.desactivateTubul();
            }
            return;
        }// end function

        public function activateSound() : void
        {
            return;
        }// end function

        public function deactivateSound() : void
        {
            return;
        }// end function

        public function setDisplayOptions(param1:TubulOptions) : void
        {
            if (this.soundIsActivate)
            {
                Tubul.getInstance().setDisplayOptions(param1);
            }
            return;
        }// end function

        public function setSubArea(param1:Map = null) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = MapPosition.getMapPositionById(param1.id);
            if (this.soundIsActivate && false)
            {
                if (this._indoor == MapTypesEnum.INDOOR && param1.mapType == MapTypesEnum.OUTDOOR)
                {
                    this._indoor = MapTypesEnum.OUTDOOR;
                    _loc_4 = Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_MUSIC_ID);
                    _loc_5 = Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_AMBIENT_2D_ID);
                    _loc_4.removeEffect(this._lowPassFilter);
                    _loc_5.removeEffect(this._lowPassFilter);
                }
                else if (this._indoor == MapTypesEnum.OUTDOOR && param1.mapType == MapTypesEnum.INDOOR)
                {
                    this._indoor = MapTypesEnum.INDOOR;
                    _loc_6 = Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_MUSIC_ID);
                    _loc_7 = Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_AMBIENT_2D_ID);
                    _loc_6.addEffect(this._lowPassFilter);
                    _loc_7.addEffect(this._lowPassFilter);
                }
            }
            this._localizedSoundsManager.setMap(param1);
            if (this.soundIsActivate)
            {
                this._localizedSoundsManager.playLocalizedSounds();
            }
            this._previousSubareaId = param1.subareaId;
            this._criterionSubarea = 1;
            var _loc_3:* = SubArea.getSubAreaById(param1.subareaId);
            if (_loc_3 == null)
            {
                return;
            }
            this._ambientManager.setAmbientSounds(_loc_3.ambientSounds, _loc_2.sounds);
            this._ambientManager.selectValidSounds();
            this._ambientManager.playMusicAndAmbient();
            return;
        }// end function

        public function playUISound(param1:String, param2:Boolean = false) : void
        {
            if (!this.checkIfAvailable())
            {
                return;
            }
            var _loc_3:* = SoundUtil.getBusIdBySoundId(param1);
            var _loc_4:* = SoundUtil.getConfigEntryByBusId(_loc_3);
            var _loc_5:* = new Uri(_loc_4 + param1 + ".mp3");
            var _loc_6:* = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND, _loc_5);
            SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND, _loc_5).volume = 1;
            var _loc_7:* = Tubul.getInstance().getBus(_loc_3);
            if (Tubul.getInstance().getBus(_loc_3) != null)
            {
                _loc_7.playISound(_loc_6, param2);
            }
            return;
        }// end function

        public function playSound(param1:ISound, param2:Boolean = false, param3:int = -1) : ISound
        {
            if (!this.checkIfAvailable())
            {
                return null;
            }
            var _loc_4:* = param1.uri.fileName.split(".mp3")[0];
            var _loc_5:* = SoundUtil.getBusIdBySoundId(_loc_4);
            var _loc_6:* = Tubul.getInstance().getBus(_loc_5);
            if (Tubul.getInstance().getBus(_loc_5) != null)
            {
                _loc_6.playISound(param1, param2, param3);
            }
            return param1;
        }// end function

        public function playFightMusic() : void
        {
            this._inFight = true;
            this._fightMusicManager.playFightMusic();
            return;
        }// end function

        public function prepareFightMusic() : void
        {
            this._fightMusicManager.prepareFightMusic();
            return;
        }// end function

        public function stopFightMusic() : void
        {
            this._inFight = false;
            this._fightMusicManager.stopFightMusic();
            return;
        }// end function

        public function handleFLAEvent(param1:String, param2:String, param3:String, param4:Object = null) : void
        {
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            if (!this.checkIfAvailable())
            {
                return;
            }
            var _loc_5:* = param4.absoluteBounds.x;
            var _loc_6:* = param4.absoluteBounds.y;
            var _loc_7:* = param4.id;
            var _loc_8:* = FLAEventLabelParser.parseSoundLabel(param3);
            var _loc_9:* = Math.round(Math.random() * (_loc_8.length - 1));
            var _loc_10:* = _loc_8[_loc_9];
            var _loc_11:* = _loc_8[_loc_9].id;
            if (this._XMLSoundFilesDictionary[_loc_11])
            {
                _loc_10 = XMLSoundParser.parseXMLSoundFile(this._XMLSoundFilesDictionary[_loc_11], param4.look.skins);
                _loc_11 = _loc_10.id;
            }
            if (XMLSoundParser.isLocalized(_loc_11))
            {
                _loc_12 = EnumSoundType.LOCALIZED_SOUND;
            }
            else
            {
                _loc_12 = EnumSoundType.UNLOCALIZED_SOUND;
            }
            _loc_13 = SoundUtil.getBusIdBySoundId(_loc_11);
            _loc_15 = SoundUtil.getConfigEntryByBusId(_loc_13);
            var _loc_16:* = new Uri(_loc_15 + _loc_11 + ".mp3");
            var _loc_17:* = SoundFactory.getSound(_loc_12, _loc_16);
            SoundFactory.getSound(_loc_12, _loc_16).volume = _loc_10.volume / 100;
            if (_loc_17 is LocalizedSound && _loc_10.rollOff)
            {
                _loc_14 = this._rollOffPresets[_loc_10.rollOff];
                if (_loc_14 && _loc_17 is LocalizedSound)
                {
                    (_loc_17 as LocalizedSound).range = _loc_14.maxRange * AtouinConstants.CELL_WIDTH;
                    (_loc_17 as LocalizedSound).saturationRange = _loc_14.maxSaturationRange * AtouinConstants.CELL_WIDTH;
                    (_loc_17 as LocalizedSound).volumeMax = _loc_10.volume / 100;
                    (_loc_17 as LocalizedSound).position = new Point(_loc_5, _loc_6);
                }
            }
            this.addSoundEntity(_loc_17, _loc_7);
            var _loc_18:* = Tubul.getInstance().getBus(_loc_13);
            if (Tubul.getInstance().getBus(_loc_13) != null)
            {
                _loc_18.playISound(_loc_17);
                if (int(_loc_10.berceauVol) < 100)
                {
                    _loc_19 = new VolumeFadeEffect(_loc_18.currentFadeVolume, _loc_10.berceauVol, _loc_10.berceauFadeIn);
                    _loc_20 = new VolumeFadeEffect(-1, _loc_18.currentFadeVolume, _loc_10.berceauFadeOut);
                    _loc_18.applyDynamicMix(_loc_19, _loc_10.berceauDuree, _loc_20);
                }
            }
            return;
        }// end function

        public function applyDynamicMix(param1:VolumeFadeEffect, param2:uint, param3:VolumeFadeEffect) : void
        {
            var _loc_4:* = Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_MUSIC_ID);
            var _loc_5:* = Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_AMBIENT_2D_ID);
            if (_loc_4)
            {
                _loc_4.applyDynamicMix(param1, param2, param3);
            }
            if (_loc_5)
            {
                _loc_5.applyDynamicMix(param1, param2, param3);
            }
            return;
        }// end function

        public function retriveRollOffPresets() : void
        {
            this._presetResourceLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            this._presetResourceLoader.addEventListener(ResourceLoadedEvent.LOADED, this.onXMLPresetsRollOffLoaded);
            this._presetResourceLoader.addEventListener(ResourceErrorEvent.ERROR, this.onXMLPresetsRollOffFailed);
            this._presetResourceLoader.load(TubulSoundConfiguration.ROLLOFF_PRESET);
            return;
        }// end function

        public function setSoundSourcePosition(param1:int, param2:Point) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!this.checkIfAvailable())
            {
                return;
            }
            if (param1 == PlayedCharacterManager.getInstance().id)
            {
                Tubul.getInstance().earPosition = param2;
            }
            else
            {
                _loc_3 = this.entitySounds[param1];
                for each (_loc_4 in _loc_3)
                {
                    
                    if (_loc_4 is LocalizedSound)
                    {
                        (_loc_4 as LocalizedSound).position = param2;
                    }
                }
            }
            return;
        }// end function

        public function addSoundEntity(param1:ISound, param2:int) : void
        {
            if (!this.checkIfAvailable())
            {
                return;
            }
            if (this._entitySounds[param2] == null)
            {
                this._entitySounds[param2] = new Vector.<ISound>;
            }
            this._entityDictionary[DofusEntities.getEntity(param2)] = this._entitySounds[param2];
            this._entitySounds[param2].push(param1);
            this._reverseEntitySounds[param1] = param2;
            return;
        }// end function

        public function removeSoundEntity(param1:ISound) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = this._reverseEntitySounds[param1];
            if (!this._entitySounds[_loc_2])
            {
                return;
            }
            var _loc_3:* = 0;
            for each (_loc_4 in this._entitySounds[_loc_2])
            {
                
                if (_loc_4 == param1)
                {
                    this._entitySounds[_loc_2].splice(_loc_3, 1);
                    delete this._reverseEntitySounds[param1];
                    if (this._entitySounds[_loc_2].length == 0)
                    {
                        this._entitySounds[_loc_2] = null;
                    }
                    return;
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function removeEntitySound(param1:IEntity) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._entityDictionary[param1] == null)
            {
                return;
            }
            for each (_loc_2 in this._entityDictionary[param1])
            {
                
                _loc_3 = new VolumeFadeEffect(-1, 0, 0.1);
                _loc_2.stop(_loc_3);
            }
            return;
        }// end function

        public function retriveXMLSounds() : void
        {
            this._XMLSoundFilesDictionary = new Dictionary();
            this._XMLSoundFilesToLoad = new Array();
            var _loc_1:* = new File(File.applicationDirectory.nativePath + "/content/audio");
            this.findXmlSoundsInDirectory(_loc_1);
            this._XMLSoundFilesResourceLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._XMLSoundFilesResourceLoader.addEventListener(ResourceLoadedEvent.LOADED, this.onXMLSoundFileLoaded);
            this._XMLSoundFilesResourceLoader.addEventListener(ResourceErrorEvent.ERROR, this.onXMLSoundFileFailed);
            this._XMLSoundFilesResourceLoader.load(this._XMLSoundFilesToLoad);
            return;
        }// end function

        private function playIntro() : void
        {
            if (!this.checkIfAvailable())
            {
                return;
            }
            this._introHarmonicOne.currentFadeVolume = 0;
            this._introHarmonicTwo.currentFadeVolume = 0;
            Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_MUSIC_ID).playISound(this._introHarmonicOne, true);
            Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_MUSIC_ID).playISound(this._introHarmonicTwo, true);
            var _loc_1:* = new VolumeFadeEffect(-1, 1, TubulSoundConfiguration.TIME_FADE_IN_INTRO);
            if (this._introFirstHarmonic)
            {
                _loc_1.attachToSoundSource(this._introHarmonicOne);
            }
            else
            {
                _loc_1.attachToSoundSource(this._introHarmonicTwo);
            }
            _loc_1.start();
            return;
        }// end function

        public function playIntroMusic(param1:Boolean = true) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (!this.checkIfAvailable())
            {
                return;
            }
            this._introFirstHarmonic = param1;
            var _loc_2:* = Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_MUSIC_ID);
            if (_loc_2)
            {
                _loc_3 = "20000";
                _loc_4 = SoundUtil.getBusIdBySoundId(_loc_3);
                _loc_5 = SoundUtil.getConfigEntryByBusId(_loc_4);
                _loc_6 = new Uri(_loc_5 + _loc_3 + ".mp3");
                this._introHarmonicOne = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND, _loc_6);
                this._introHarmonicOne.volume = 1;
                _loc_3 = "20001";
                _loc_4 = SoundUtil.getBusIdBySoundId(_loc_3);
                _loc_5 = SoundUtil.getConfigEntryByBusId(_loc_4);
                _loc_6 = new Uri(_loc_5 + _loc_3 + ".mp3");
                this._introHarmonicTwo = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND, _loc_6);
                this._introHarmonicOne.eventDispatcher.addEventListener(LoadingSoundEvent.LOADED, this.onIntroMusicHarmonicOneLoaded);
                this._introHarmonicTwo.eventDispatcher.addEventListener(LoadingSoundEvent.LOADED, this.onIntroMusicHarmonicTwoLoaded);
                _loc_2.addISound(this._introHarmonicOne);
                _loc_2.addISound(this._introHarmonicTwo);
            }
            return;
        }// end function

        public function switchIntroMusic(param1:Boolean) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!this.checkIfAvailable())
            {
                return;
            }
            if (this._introHarmonicOneLoaded && this._introHarmonicTwoLoaded)
            {
                if (param1)
                {
                    _loc_2 = new VolumeFadeEffect(-1, 0, TubulSoundConfiguration.TIME_FADE_SWITCH_INTRO);
                    _loc_3 = new VolumeFadeEffect(-1, 1, TubulSoundConfiguration.TIME_FADE_SWITCH_INTRO);
                }
                else
                {
                    _loc_2 = new VolumeFadeEffect(-1, 1, TubulSoundConfiguration.TIME_FADE_SWITCH_INTRO);
                    _loc_3 = new VolumeFadeEffect(-1, 0, TubulSoundConfiguration.TIME_FADE_SWITCH_INTRO);
                }
                _loc_2.attachToSoundSource(this._introHarmonicOne);
                _loc_3.attachToSoundSource(this._introHarmonicTwo);
                _loc_2.start();
                _loc_3.start();
            }
            else
            {
                this.playIntroMusic(false);
            }
            return;
        }// end function

        public function stopIntroMusic(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!this.checkIfAvailable())
            {
                return;
            }
            if (this._introHarmonicOne)
            {
                if (param1)
                {
                    this._introHarmonicOne.stop();
                }
                else
                {
                    _loc_2 = new VolumeFadeEffect(-1, 0, TubulSoundConfiguration.TIME_FADE_OUT_INTRO);
                    this._introHarmonicOne.stop(_loc_2);
                }
                this._introHarmonicOne.eventDispatcher.removeEventListener(LoadingSoundEvent.LOADED, this.onIntroMusicHarmonicOneLoaded);
            }
            if (this._introHarmonicTwo)
            {
                if (param1)
                {
                    this._introHarmonicTwo.stop();
                }
                else
                {
                    _loc_3 = new VolumeFadeEffect(-1, 0, TubulSoundConfiguration.TIME_FADE_OUT_INTRO);
                    this._introHarmonicTwo.stop(_loc_3);
                }
                this._introHarmonicTwo.eventDispatcher.removeEventListener(LoadingSoundEvent.LOADED, this.onIntroMusicHarmonicTwoLoaded);
            }
            this._introHarmonicOneLoaded = false;
            this._introHarmonicTwoLoaded = false;
            return;
        }// end function

        public function removeAllSounds(param1:Number = 0, param2:Number = 0) : void
        {
            var _loc_3:* = null;
            if (this._introHarmonicOne)
            {
                this._introHarmonicOne.eventDispatcher.removeEventListener(LoadingSoundEvent.LOADED, this.onIntroMusicHarmonicOneLoaded);
            }
            if (this._introHarmonicTwo)
            {
                this._introHarmonicTwo.eventDispatcher.removeEventListener(LoadingSoundEvent.LOADED, this.onIntroMusicHarmonicTwoLoaded);
            }
            for each (_loc_3 in Tubul.getInstance().audioBusList)
            {
                
                _loc_3.clear();
            }
            return;
        }// end function

        public function setBusVolume(param1:int, param2:Number) : void
        {
            var _loc_3:* = Tubul.getInstance().getBus(param1);
            if (_loc_3 != null)
            {
                _loc_3.volume = param2;
            }
            return;
        }// end function

        public function reset() : void
        {
            this.removeAllSounds();
            return;
        }// end function

        private function findXmlSoundsInDirectory(param1:File) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1.exists)
            {
                _loc_2 = param1.getDirectoryListing();
                for each (_loc_3 in _loc_2)
                {
                    
                    if (_loc_3.isDirectory && _loc_3.name != ".svn" && _loc_3.name != "presets")
                    {
                        this.findXmlSoundsInDirectory(_loc_3);
                        continue;
                    }
                    if (_loc_3.extension && _loc_3.extension.toUpperCase() == "XML")
                    {
                        this._XMLSoundFilesToLoad.push(new Uri(_loc_3.nativePath));
                    }
                }
            }
            else
            {
                _log.fatal("The sound directory doesn\'t exists !");
                this._soundDirectoryExist = false;
            }
            return;
        }// end function

        private function init() : void
        {
            this._previousSubareaId = -1;
            this._localizedSoundsManager = new LocalizedSoundsManager();
            this._ambientManager = new AmbientSoundsManager();
            this._fightMusicManager = new FightMusicManager();
            this._entitySounds = new Array();
            this._reverseEntitySounds = new Dictionary();
            this._adminSounds = new Dictionary();
            this._entityDictionary = new Dictionary();
            this._rollOffPresets = new Array();
            this.initTubul();
            this._lowPassFilter = new LowPassFilter();
            return;
        }// end function

        private function initTubul() : void
        {
            if (!this.soundIsActivate)
            {
                return;
            }
            Tubul.getInstance().addEventListener(AudioBusEvent.REMOVE_SOUND_IN_BUS, this.onRemoveSoundInTubul);
            Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.UNLOCALIZED_BUS, TubulSoundConfiguration.BUS_MUSIC_ID, TubulSoundConfiguration.CHANNEL_MUSIC));
            Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.UNLOCALIZED_BUS, TubulSoundConfiguration.BUS_AMBIENT_2D_ID, TubulSoundConfiguration.CHANNEL_AMBIENT_2D));
            Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.LOCALIZED_BUS, TubulSoundConfiguration.BUS_AMBIENT_3D_ID, TubulSoundConfiguration.CHANNEL_AMBIENT_3D));
            Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.LOCALIZED_BUS, TubulSoundConfiguration.BUS_SFX_ID, TubulSoundConfiguration.CHANNEL_SFX));
            Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.LOCALIZED_BUS, TubulSoundConfiguration.BUS_UI_ID, TubulSoundConfiguration.CHANNEL_UI));
            Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.LOCALIZED_BUS, TubulSoundConfiguration.BUS_NPC_FOLEYS_ID, TubulSoundConfiguration.CHANNEL_NPC_FOLEYS));
            Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.LOCALIZED_BUS, TubulSoundConfiguration.BUS_FIGHT_ID, TubulSoundConfiguration.CHANNEL_FIGHT));
            Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.LOCALIZED_BUS, TubulSoundConfiguration.BUS_BARKS_ID, TubulSoundConfiguration.CHANNEL_BARKS));
            Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.LOCALIZED_BUS, TubulSoundConfiguration.BUS_GFX_ID, TubulSoundConfiguration.CHANNEL_GFX));
            Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.UNLOCALIZED_BUS, TubulSoundConfiguration.BUS_FIGHT_MUSIC_ID, TubulSoundConfiguration.CHANNEL_FIGHT_MUSIC));
            Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_MUSIC_ID).volumeMax = TubulSoundConfiguration.BUS_MUSIC_VOLUME;
            Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_AMBIENT_2D_ID).volumeMax = TubulSoundConfiguration.BUS_AMBIENT_2D_VOLUME;
            Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_AMBIENT_3D_ID).volumeMax = TubulSoundConfiguration.BUS_AMBIENT_3D_VOLUME;
            Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_SFX_ID).volumeMax = TubulSoundConfiguration.BUS_SFX_VOLUME;
            Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_UI_ID).volumeMax = TubulSoundConfiguration.BUS_UI_VOLUME;
            Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_NPC_FOLEYS_ID).volumeMax = TubulSoundConfiguration.BUS_NPC_FOLEYS_VOLUME;
            Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_FIGHT_ID).volumeMax = TubulSoundConfiguration.BUS_FIGHT_VOLUME;
            Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_BARKS_ID).volumeMax = TubulSoundConfiguration.BUS_BARKS_VOLUME;
            Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_GFX_ID).volumeMax = TubulSoundConfiguration.BUS_GFX_VOLUME;
            Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_FIGHT_MUSIC_ID).volumeMax = TubulSoundConfiguration.BUS_FIGHT_MUSIC_VOLUME;
            SoundManager.getInstance().setSoundOptions();
            this.retriveRollOffPresets();
            this.retriveXMLSounds();
            Tubul.getInstance().addEventListener(TubulEvent.ACTIVATION, this.onTubulActivation);
            var _loc_1:* = new TubulEvent(TubulEvent.ACTIVATION);
            _loc_1.activated = true;
            this.onTubulActivation(_loc_1);
            return;
        }// end function

        private function desactivateTubul() : void
        {
            if (this.soundIsActivate)
            {
                return;
            }
            if (this._ambientManager != null)
            {
                this._ambientManager.stopMusicAndAmbient();
            }
            if (this._localizedSoundsManager != null)
            {
                this._localizedSoundsManager.stopLocalizedSounds();
            }
            Tubul.getInstance().clearBuses();
            return;
        }// end function

        private function checkIfAvailable() : Boolean
        {
            return this._forceSounds && this._soundDirectoryExist;
        }// end function

        public function playAdminSound(param1:String, param2:Number, param3:Boolean, param4:uint) : void
        {
            var _loc_5:* = SoundUtil.getBusIdBySoundId(param1);
            var _loc_6:* = SoundUtil.getConfigEntryByBusId(_loc_5);
            var _loc_7:* = new Uri(_loc_6 + param1 + ".mp3");
            var _loc_8:* = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND, _loc_7);
            SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND, _loc_7).busId = _loc_5;
            _loc_8.volume = param2 / 100;
            this._adminSounds[param4] = _loc_8;
            _loc_8.play(param3);
            return;
        }// end function

        public function stopAdminSound(param1:uint) : void
        {
            var _loc_2:* = this._adminSounds[param1] as ISound;
            _loc_2.stop();
            return;
        }// end function

        public function addSoundInPlaylist(param1:String, param2:Number, param3:uint, param4:uint) : Boolean
        {
            if (this._adminPlaylist == null)
            {
                this._adminPlaylist = new PlayList(false, true);
            }
            var _loc_5:* = SoundUtil.getBusIdBySoundId(param1);
            var _loc_6:* = SoundUtil.getConfigEntryByBusId(_loc_5);
            var _loc_7:* = new Uri(_loc_6 + param1 + ".mp3");
            var _loc_8:* = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND, _loc_7);
            if (this._adminPlaylist.addSound(_loc_8) > 0)
            {
                return true;
            }
            return false;
        }// end function

        public function removeSoundInPLaylist(param1:String) : Boolean
        {
            if (this._adminPlaylist == null)
            {
                return false;
            }
            this._adminPlaylist.removeSoundBySoundId(param1, true);
            return true;
        }// end function

        public function playPlaylist() : void
        {
            if (!Tubul.getInstance().isActive)
            {
                return;
            }
            if (this._adminPlaylist == null)
            {
                return;
            }
            this._adminPlaylist.play();
            return;
        }// end function

        public function stopPlaylist() : void
        {
            if (!Tubul.getInstance().isActive)
            {
                return;
            }
            this._adminPlaylist.stop();
            return;
        }// end function

        public function resetPlaylist() : void
        {
            if (this._adminPlaylist)
            {
                this._adminPlaylist.reset();
            }
            return;
        }// end function

        public function fadeBusVolume(param1:int, param2:Number, param3:Number) : void
        {
            var _loc_5:* = null;
            var _loc_4:* = Tubul.getInstance().getBus(param1);
            if (Tubul.getInstance().getBus(param1) != null)
            {
                _loc_5 = new VolumeFadeEffect(-1, param2, param3);
                _loc_5.attachToSoundSource(_loc_4);
                _loc_5.start();
            }
            return;
        }// end function

        private function onXMLPresetsRollOffLoaded(event:ResourceLoadedEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = (event.resource as XML).elements();
            for each (_loc_3 in _loc_2)
            {
                
                _loc_4 = new RollOffPreset(uint(_loc_3.GainMax), uint(_loc_3.DistMax), uint(_loc_3.DistMaxSat));
                this._rollOffPresets[_loc_3.@id] = _loc_4;
            }
            return;
        }// end function

        private function onXMLPresetsRollOffFailed(event:ResourceErrorEvent) : void
        {
            Tubul.getInstance().activate(false);
            _log.error("An XML sound file failed to load : " + event.uri + " / [" + event.errorCode + "] " + event.errorMsg);
            return;
        }// end function

        private function onXMLSoundFileLoaded(event:ResourceLoadedEvent) : void
        {
            var _loc_2:* = event.uri.fileName.split("." + event.uri.fileType)[0];
            var _loc_3:* = _loc_2.split("\\");
            _loc_2 = _loc_3.pop();
            this._XMLSoundFilesDictionary[_loc_2] = event.resource;
            var _loc_4:* = this._XMLSoundFilesToLoad.indexOf(event.uri);
            if (this._XMLSoundFilesToLoad.indexOf(event.uri) >= 0)
            {
                this._XMLSoundFilesToLoad.splice(_loc_4, 1);
            }
            if (this._XMLSoundFilesToLoad.length == 0)
            {
                this._XMLSoundFilesToLoad = null;
                this._XMLSoundFilesResourceLoader.removeEventListener(ResourceLoadedEvent.LOADED, this.onXMLSoundFileLoaded);
                this._XMLSoundFilesResourceLoader.removeEventListener(ResourceErrorEvent.ERROR, this.onXMLSoundFileFailed);
            }
            return;
        }// end function

        private function onXMLSoundFileFailed(event:ResourceErrorEvent) : void
        {
            _log.warn("The xml sound file " + event.uri + " failed to load !!");
            return;
        }// end function

        private function onRemoveSoundInTubul(event:AudioBusEvent) : void
        {
            this.removeSoundEntity(event.sound);
            return;
        }// end function

        private function onSoundAdminComplete(event:SoundCompleteEvent) : void
        {
            event.sound.eventDispatcher.removeEventListener(SoundCompleteEvent.SOUND_COMPLETE, this.onSoundAdminComplete);
            var _loc_2:* = event.sound.uri.fileName.split(".mp3")[0];
            this._adminSounds[_loc_2] = null;
            delete this._adminSounds[_loc_2];
            return;
        }// end function

        private function onIntroMusicHarmonicOneLoaded(event:LoadingSoundEvent) : void
        {
            this._introHarmonicOneLoaded = true;
            if (this._introHarmonicTwoLoaded)
            {
                this.playIntro();
            }
            return;
        }// end function

        private function onIntroMusicHarmonicTwoLoaded(event:LoadingSoundEvent) : void
        {
            this._introHarmonicTwoLoaded = true;
            if (this._introHarmonicOneLoaded)
            {
                this.playIntro();
            }
            return;
        }// end function

        private function onTubulActivation(event:TubulEvent) : void
        {
            switch(event.activated)
            {
                case true:
                {
                    Berilia.getInstance().addUIListener(this);
                    TiphonEventsManager.addListener(this, "Sound");
                    Tubul.getInstance().addListener(this);
                    break;
                }
                case false:
                {
                    Berilia.getInstance().removeUIListener(this);
                    TiphonEventsManager.removeListener(this);
                    Tubul.getInstance().removeListener(this);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function getInstance() : ISoundManager
        {
            if (!_self)
            {
                _self = new ClassicSoundManager;
            }
            return _self;
        }// end function

    }
}
