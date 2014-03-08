package com.ankamagames.dofus.kernel.sound.manager
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.tubul.types.effects.LowPassFilter;
   import com.ankamagames.tubul.types.PlayList;
   import com.ankamagames.tubul.types.TubulOptions;
   import com.ankamagames.tubul.Tubul;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.tubul.interfaces.IAudioBus;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.atouin.enums.MapTypesEnum;
   import com.ankamagames.dofus.kernel.sound.TubulSoundConfiguration;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.kernel.sound.utils.SoundUtil;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tubul.factory.SoundFactory;
   import com.ankamagames.tubul.enum.EnumSoundType;
   import com.ankamagames.dofus.kernel.sound.type.RollOffPreset;
   import com.ankamagames.tubul.types.VolumeFadeEffect;
   import com.ankamagames.jerakine.utils.parser.FLAEventLabelParser;
   import com.ankamagames.jerakine.types.SoundEventParamWrapper;
   import com.ankamagames.dofus.kernel.sound.parser.XMLSoundParser;
   import com.ankamagames.tubul.types.sounds.LocalizedSound;
   import com.ankamagames.atouin.AtouinConstants;
   import flash.geom.Point;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import flash.filesystem.File;
   import com.ankamagames.tubul.events.LoadingSound.LoadingSoundEvent;
   import com.ankamagames.tubul.events.AudioBusEvent;
   import com.ankamagames.tubul.factory.AudioBusFactory;
   import com.ankamagames.tubul.enum.EnumTypeBus;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.tubul.events.TubulEvent;
   import com.ankamagames.tubul.events.SoundCompleteEvent;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.tiphon.engine.TiphonEventsManager;
   
   public class ClassicSoundManager extends EventDispatcher implements ISoundManager
   {
      
      public function ClassicSoundManager() {
         super();
         if(_self)
         {
            throw new Error("Warning : ClassicSoundManager is a singleton class and shoulnd\'t be instancied directly!");
         }
         else
         {
            this.init();
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ClassicSoundManager));
      
      private static var _self:ISoundManager;
      
      public static function getInstance() : ISoundManager {
         if(!_self)
         {
            _self = new ClassicSoundManager();
         }
         return _self;
      }
      
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
      
      public function set soundDirectoryExist(param1:Boolean) : void {
         this._soundDirectoryExist = param1;
      }
      
      public function get soundDirectoryExist() : Boolean {
         return this._soundDirectoryExist;
      }
      
      public function get soundIsActivate() : Boolean {
         return this.checkIfAvailable();
      }
      
      public function get entitySounds() : Array {
         return this._entitySounds;
      }
      
      public function get reverseEntitySounds() : Dictionary {
         return this._reverseEntitySounds;
      }
      
      public function set forceSoundsDebugMode(param1:Boolean) : void {
         this._forceSounds = param1;
         if(this._forceSounds)
         {
            this.initTubul();
            if(!(this._localizedSoundsManager == null) && (this._localizedSoundsManager.isInitialized))
            {
               this._localizedSoundsManager.playLocalizedSounds();
            }
            if(this._ambientManager != null)
            {
               this._ambientManager.playMusicAndAmbient();
            }
            if(!(this._fightMusicManager == null) && (this._inFight))
            {
               this._fightMusicManager.playFightMusic();
            }
         }
         else
         {
            this.desactivateTubul();
         }
      }
      
      public function activateSound() : void {
      }
      
      public function deactivateSound() : void {
      }
      
      public function setDisplayOptions(param1:TubulOptions) : void {
         if(this.soundIsActivate)
         {
            Tubul.getInstance().setDisplayOptions(param1);
         }
      }
      
      public function setSubArea(param1:Map=null) : void {
         var _loc4_:IAudioBus = null;
         var _loc5_:IAudioBus = null;
         var _loc6_:IAudioBus = null;
         var _loc7_:IAudioBus = null;
         var _loc2_:MapPosition = MapPosition.getMapPositionById(param1.id);
         if((this.soundIsActivate) && false)
         {
            if(this._indoor == MapTypesEnum.INDOOR && param1.mapType == MapTypesEnum.OUTDOOR)
            {
               this._indoor = MapTypesEnum.OUTDOOR;
               _loc4_ = Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_MUSIC_ID);
               _loc5_ = Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_AMBIENT_2D_ID);
               _loc4_.removeEffect(this._lowPassFilter);
               _loc5_.removeEffect(this._lowPassFilter);
            }
            else
            {
               if(this._indoor == MapTypesEnum.OUTDOOR && param1.mapType == MapTypesEnum.INDOOR)
               {
                  this._indoor = MapTypesEnum.INDOOR;
                  _loc6_ = Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_MUSIC_ID);
                  _loc7_ = Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_AMBIENT_2D_ID);
                  _loc6_.addEffect(this._lowPassFilter);
                  _loc7_.addEffect(this._lowPassFilter);
               }
            }
         }
         this._localizedSoundsManager.setMap(param1);
         if(this.soundIsActivate)
         {
            this._localizedSoundsManager.playLocalizedSounds();
         }
         this._previousSubareaId = param1.subareaId;
         this._criterionSubarea = 1;
         var _loc3_:SubArea = SubArea.getSubAreaById(param1.subareaId);
         if(_loc3_ == null)
         {
            return;
         }
         this._ambientManager.setAmbientSounds(_loc3_.ambientSounds,_loc2_.sounds);
         this._ambientManager.selectValidSounds();
         this._ambientManager.playMusicAndAmbient();
      }
      
      public function playUISound(param1:String, param2:Boolean=false) : void {
         if(!this.checkIfAvailable())
         {
            return;
         }
         var _loc3_:uint = SoundUtil.getBusIdBySoundId(param1);
         var _loc4_:String = SoundUtil.getConfigEntryByBusId(_loc3_);
         var _loc5_:Uri = new Uri(_loc4_ + param1 + ".mp3");
         var _loc6_:ISound = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND,_loc5_);
         _loc6_.volume = 1;
         var _loc7_:IAudioBus = Tubul.getInstance().getBus(_loc3_);
         if(_loc7_ != null)
         {
            _loc7_.playISound(_loc6_,param2);
         }
      }
      
      public function playSound(param1:ISound, param2:Boolean=false, param3:int=-1) : ISound {
         if(!this.checkIfAvailable())
         {
            return null;
         }
         var _loc4_:String = param1.uri.fileName.split(".mp3")[0];
         var _loc5_:uint = SoundUtil.getBusIdBySoundId(_loc4_);
         var _loc6_:IAudioBus = Tubul.getInstance().getBus(_loc5_);
         if(_loc6_ != null)
         {
            _loc6_.playISound(param1,param2,param3);
         }
         return param1;
      }
      
      public function playFightMusic() : void {
         this._inFight = true;
         this._fightMusicManager.playFightMusic();
      }
      
      public function prepareFightMusic() : void {
         this._fightMusicManager.prepareFightMusic();
      }
      
      public function stopFightMusic() : void {
         this._inFight = false;
         this._fightMusicManager.stopFightMusic();
      }
      
      public function handleFLAEvent(param1:String, param2:String, param3:String, param4:Object=null) : void {
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:RollOffPreset = null;
         var _loc15_:String = null;
         var _loc19_:VolumeFadeEffect = null;
         var _loc20_:VolumeFadeEffect = null;
         if(!this.checkIfAvailable())
         {
            return;
         }
         var _loc5_:Number = param4.absoluteBounds.x;
         var _loc6_:Number = param4.absoluteBounds.y;
         var _loc7_:int = param4.id;
         var _loc8_:Array = FLAEventLabelParser.parseSoundLabel(param3);
         var _loc9_:uint = Math.round(Math.random() * (_loc8_.length-1));
         var _loc10_:SoundEventParamWrapper = _loc8_[_loc9_];
         var _loc11_:String = _loc10_.id;
         if(this._XMLSoundFilesDictionary[_loc11_])
         {
            _loc10_ = XMLSoundParser.parseXMLSoundFile(this._XMLSoundFilesDictionary[_loc11_],param4.look.skins);
            _loc11_ = _loc10_.id;
         }
         if(XMLSoundParser.isLocalized(_loc11_))
         {
            _loc12_ = EnumSoundType.LOCALIZED_SOUND;
         }
         else
         {
            _loc12_ = EnumSoundType.UNLOCALIZED_SOUND;
         }
         _loc13_ = SoundUtil.getBusIdBySoundId(_loc11_);
         _loc15_ = SoundUtil.getConfigEntryByBusId(_loc13_);
         var _loc16_:Uri = new Uri(_loc15_ + _loc11_ + ".mp3");
         var _loc17_:ISound = SoundFactory.getSound(_loc12_,_loc16_);
         _loc17_.volume = _loc10_.volume / 100;
         if(_loc17_ is LocalizedSound && (_loc10_.rollOff))
         {
            _loc14_ = this._rollOffPresets[_loc10_.rollOff];
            if((_loc14_) && _loc17_ is LocalizedSound)
            {
               (_loc17_ as LocalizedSound).range = _loc14_.maxRange * AtouinConstants.CELL_WIDTH;
               (_loc17_ as LocalizedSound).saturationRange = _loc14_.maxSaturationRange * AtouinConstants.CELL_WIDTH;
               (_loc17_ as LocalizedSound).volumeMax = _loc10_.volume / 100;
               (_loc17_ as LocalizedSound).position = new Point(_loc5_,_loc6_);
            }
         }
         this.addSoundEntity(_loc17_,_loc7_);
         var _loc18_:IAudioBus = Tubul.getInstance().getBus(_loc13_);
         if(_loc18_ != null)
         {
            _loc18_.playISound(_loc17_);
            if(int(_loc10_.berceauVol) < 100)
            {
               _loc19_ = new VolumeFadeEffect(_loc18_.currentFadeVolume,_loc10_.berceauVol,_loc10_.berceauFadeIn);
               _loc20_ = new VolumeFadeEffect(-1,_loc18_.currentFadeVolume,_loc10_.berceauFadeOut);
               _loc18_.applyDynamicMix(_loc19_,_loc10_.berceauDuree,_loc20_);
            }
         }
      }
      
      public function applyDynamicMix(param1:VolumeFadeEffect, param2:uint, param3:VolumeFadeEffect) : void {
         var _loc4_:IAudioBus = Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_MUSIC_ID);
         var _loc5_:IAudioBus = Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_AMBIENT_2D_ID);
         if(_loc4_)
         {
            _loc4_.applyDynamicMix(param1,param2,param3);
         }
         if(_loc5_)
         {
            _loc5_.applyDynamicMix(param1,param2,param3);
         }
      }
      
      public function retriveRollOffPresets() : void {
         this._presetResourceLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
         this._presetResourceLoader.addEventListener(ResourceLoadedEvent.LOADED,this.onXMLPresetsRollOffLoaded);
         this._presetResourceLoader.addEventListener(ResourceErrorEvent.ERROR,this.onXMLPresetsRollOffFailed);
         this._presetResourceLoader.load(TubulSoundConfiguration.ROLLOFF_PRESET);
      }
      
      public function setSoundSourcePosition(param1:int, param2:Point) : void {
         var _loc3_:Vector.<ISound> = null;
         var _loc4_:ISound = null;
         if(!this.checkIfAvailable())
         {
            return;
         }
         if(param1 == PlayedCharacterManager.getInstance().id)
         {
            Tubul.getInstance().earPosition = param2;
         }
         else
         {
            _loc3_ = this.entitySounds[param1];
            for each (_loc4_ in _loc3_)
            {
               if(_loc4_ is LocalizedSound)
               {
                  (_loc4_ as LocalizedSound).position = param2;
               }
            }
         }
      }
      
      public function addSoundEntity(param1:ISound, param2:int) : void {
         if(!this.checkIfAvailable())
         {
            return;
         }
         if(this._entitySounds[param2] == null)
         {
            this._entitySounds[param2] = new Vector.<ISound>();
         }
         this._entityDictionary[DofusEntities.getEntity(param2)] = this._entitySounds[param2];
         this._entitySounds[param2].push(param1);
         this._reverseEntitySounds[param1] = param2;
      }
      
      public function removeSoundEntity(param1:ISound) : void {
         var _loc4_:ISound = null;
         var _loc2_:int = this._reverseEntitySounds[param1];
         if(!this._entitySounds[_loc2_])
         {
            return;
         }
         var _loc3_:uint = 0;
         for each (_loc4_ in this._entitySounds[_loc2_])
         {
            if(_loc4_ == param1)
            {
               this._entitySounds[_loc2_].splice(_loc3_,1);
               delete this._reverseEntitySounds[[param1]];
               if(this._entitySounds[_loc2_].length == 0)
               {
                  this._entitySounds[_loc2_] = null;
               }
               return;
            }
            _loc3_++;
         }
      }
      
      public function removeEntitySound(param1:IEntity) : void {
         var _loc2_:ISound = null;
         var _loc3_:VolumeFadeEffect = null;
         if(this._entityDictionary[param1] == null)
         {
            return;
         }
         for each (_loc2_ in this._entityDictionary[param1])
         {
            _loc3_ = new VolumeFadeEffect(-1,0,0.1);
            _loc2_.stop(_loc3_);
         }
      }
      
      public function retriveXMLSounds() : void {
         this._XMLSoundFilesDictionary = new Dictionary();
         this._XMLSoundFilesToLoad = new Array();
         var _loc1_:File = new File(File.applicationDirectory.nativePath + "/content/audio");
         this.findXmlSoundsInDirectory(_loc1_);
         this._XMLSoundFilesResourceLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this._XMLSoundFilesResourceLoader.addEventListener(ResourceLoadedEvent.LOADED,this.onXMLSoundFileLoaded);
         this._XMLSoundFilesResourceLoader.addEventListener(ResourceErrorEvent.ERROR,this.onXMLSoundFileFailed);
         this._XMLSoundFilesResourceLoader.load(this._XMLSoundFilesToLoad);
      }
      
      private function playIntro() : void {
         if(!this.checkIfAvailable())
         {
            return;
         }
         this._introHarmonicOne.currentFadeVolume = 0;
         this._introHarmonicTwo.currentFadeVolume = 0;
         Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_MUSIC_ID).playISound(this._introHarmonicOne,true);
         Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_MUSIC_ID).playISound(this._introHarmonicTwo,true);
         var _loc1_:VolumeFadeEffect = new VolumeFadeEffect(-1,1,TubulSoundConfiguration.TIME_FADE_IN_INTRO);
         if(this._introFirstHarmonic)
         {
            _loc1_.attachToSoundSource(this._introHarmonicOne);
         }
         else
         {
            _loc1_.attachToSoundSource(this._introHarmonicTwo);
         }
         _loc1_.start();
      }
      
      public function playIntroMusic(param1:Boolean=true) : void {
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:Uri = null;
         if(!this.checkIfAvailable())
         {
            return;
         }
         this._introFirstHarmonic = param1;
         var _loc2_:IAudioBus = Tubul.getInstance().getBus(TubulSoundConfiguration.BUS_MUSIC_ID);
         if(_loc2_)
         {
            _loc3_ = "20000";
            _loc4_ = SoundUtil.getBusIdBySoundId(_loc3_);
            _loc5_ = SoundUtil.getConfigEntryByBusId(_loc4_);
            _loc6_ = new Uri(_loc5_ + _loc3_ + ".mp3");
            this._introHarmonicOne = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND,_loc6_);
            this._introHarmonicOne.volume = 1;
            _loc3_ = "20001";
            _loc4_ = SoundUtil.getBusIdBySoundId(_loc3_);
            _loc5_ = SoundUtil.getConfigEntryByBusId(_loc4_);
            _loc6_ = new Uri(_loc5_ + _loc3_ + ".mp3");
            this._introHarmonicTwo = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND,_loc6_);
            this._introHarmonicOne.eventDispatcher.addEventListener(LoadingSoundEvent.LOADED,this.onIntroMusicHarmonicOneLoaded);
            this._introHarmonicTwo.eventDispatcher.addEventListener(LoadingSoundEvent.LOADED,this.onIntroMusicHarmonicTwoLoaded);
            _loc2_.addISound(this._introHarmonicOne);
            _loc2_.addISound(this._introHarmonicTwo);
         }
      }
      
      public function switchIntroMusic(param1:Boolean) : void {
         var _loc2_:VolumeFadeEffect = null;
         var _loc3_:VolumeFadeEffect = null;
         if(!this.checkIfAvailable())
         {
            return;
         }
         if((this._introHarmonicOneLoaded) && (this._introHarmonicTwoLoaded))
         {
            if(param1)
            {
               _loc2_ = new VolumeFadeEffect(-1,0,TubulSoundConfiguration.TIME_FADE_SWITCH_INTRO);
               _loc3_ = new VolumeFadeEffect(-1,1,TubulSoundConfiguration.TIME_FADE_SWITCH_INTRO);
            }
            else
            {
               _loc2_ = new VolumeFadeEffect(-1,1,TubulSoundConfiguration.TIME_FADE_SWITCH_INTRO);
               _loc3_ = new VolumeFadeEffect(-1,0,TubulSoundConfiguration.TIME_FADE_SWITCH_INTRO);
            }
            _loc2_.attachToSoundSource(this._introHarmonicOne);
            _loc3_.attachToSoundSource(this._introHarmonicTwo);
            _loc2_.start();
            _loc3_.start();
         }
         else
         {
            this.playIntroMusic(false);
         }
      }
      
      public function stopIntroMusic(param1:Boolean=false) : void {
         var _loc2_:VolumeFadeEffect = null;
         var _loc3_:VolumeFadeEffect = null;
         if(!this.checkIfAvailable())
         {
            return;
         }
         if(this._introHarmonicOne)
         {
            if(param1)
            {
               this._introHarmonicOne.stop();
            }
            else
            {
               _loc2_ = new VolumeFadeEffect(-1,0,TubulSoundConfiguration.TIME_FADE_OUT_INTRO);
               this._introHarmonicOne.stop(_loc2_);
            }
            this._introHarmonicOne.eventDispatcher.removeEventListener(LoadingSoundEvent.LOADED,this.onIntroMusicHarmonicOneLoaded);
         }
         if(this._introHarmonicTwo)
         {
            if(param1)
            {
               this._introHarmonicTwo.stop();
            }
            else
            {
               _loc3_ = new VolumeFadeEffect(-1,0,TubulSoundConfiguration.TIME_FADE_OUT_INTRO);
               this._introHarmonicTwo.stop(_loc3_);
            }
            this._introHarmonicTwo.eventDispatcher.removeEventListener(LoadingSoundEvent.LOADED,this.onIntroMusicHarmonicTwoLoaded);
         }
         this._introHarmonicOneLoaded = false;
         this._introHarmonicTwoLoaded = false;
      }
      
      public function removeAllSounds(param1:Number=0, param2:Number=0) : void {
         var _loc3_:IAudioBus = null;
         if(this._introHarmonicOne)
         {
            this._introHarmonicOne.eventDispatcher.removeEventListener(LoadingSoundEvent.LOADED,this.onIntroMusicHarmonicOneLoaded);
         }
         if(this._introHarmonicTwo)
         {
            this._introHarmonicTwo.eventDispatcher.removeEventListener(LoadingSoundEvent.LOADED,this.onIntroMusicHarmonicTwoLoaded);
         }
         for each (_loc3_ in Tubul.getInstance().audioBusList)
         {
            _loc3_.clear();
         }
      }
      
      public function setBusVolume(param1:int, param2:Number) : void {
         var _loc3_:IAudioBus = Tubul.getInstance().getBus(param1);
         if(_loc3_ != null)
         {
            _loc3_.volume = param2;
         }
      }
      
      public function reset() : void {
         this.removeAllSounds();
      }
      
      private function findXmlSoundsInDirectory(param1:File) : void {
         var _loc2_:Array = null;
         var _loc3_:File = null;
         if(param1.exists)
         {
            _loc2_ = param1.getDirectoryListing();
            for each (_loc3_ in _loc2_)
            {
               if((_loc3_.isDirectory) && !(_loc3_.name == ".svn") && !(_loc3_.name == "presets"))
               {
                  this.findXmlSoundsInDirectory(_loc3_);
               }
               else
               {
                  if((_loc3_.extension) && _loc3_.extension.toUpperCase() == "XML")
                  {
                     this._XMLSoundFilesToLoad.push(new Uri(_loc3_.nativePath));
                  }
               }
            }
         }
         else
         {
            _log.fatal("The sound directory doesn\'t exists !");
            this._soundDirectoryExist = false;
         }
      }
      
      private function init() : void {
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
      }
      
      private function initTubul() : void {
         if(!this.soundIsActivate)
         {
            return;
         }
         Tubul.getInstance().addEventListener(AudioBusEvent.REMOVE_SOUND_IN_BUS,this.onRemoveSoundInTubul);
         Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.UNLOCALIZED_BUS,TubulSoundConfiguration.BUS_MUSIC_ID,TubulSoundConfiguration.CHANNEL_MUSIC));
         Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.UNLOCALIZED_BUS,TubulSoundConfiguration.BUS_AMBIENT_2D_ID,TubulSoundConfiguration.CHANNEL_AMBIENT_2D));
         Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.LOCALIZED_BUS,TubulSoundConfiguration.BUS_AMBIENT_3D_ID,TubulSoundConfiguration.CHANNEL_AMBIENT_3D));
         Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.LOCALIZED_BUS,TubulSoundConfiguration.BUS_SFX_ID,TubulSoundConfiguration.CHANNEL_SFX));
         Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.LOCALIZED_BUS,TubulSoundConfiguration.BUS_UI_ID,TubulSoundConfiguration.CHANNEL_UI));
         Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.LOCALIZED_BUS,TubulSoundConfiguration.BUS_NPC_FOLEYS_ID,TubulSoundConfiguration.CHANNEL_NPC_FOLEYS));
         Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.LOCALIZED_BUS,TubulSoundConfiguration.BUS_FIGHT_ID,TubulSoundConfiguration.CHANNEL_FIGHT));
         Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.LOCALIZED_BUS,TubulSoundConfiguration.BUS_BARKS_ID,TubulSoundConfiguration.CHANNEL_BARKS));
         Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.LOCALIZED_BUS,TubulSoundConfiguration.BUS_GFX_ID,TubulSoundConfiguration.CHANNEL_GFX));
         Tubul.getInstance().addBus(AudioBusFactory.getAudioBus(EnumTypeBus.UNLOCALIZED_BUS,TubulSoundConfiguration.BUS_FIGHT_MUSIC_ID,TubulSoundConfiguration.CHANNEL_FIGHT_MUSIC));
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
         Tubul.getInstance().addEventListener(TubulEvent.ACTIVATION,this.onTubulActivation);
         var _loc1_:TubulEvent = new TubulEvent(TubulEvent.ACTIVATION);
         _loc1_.activated = true;
         this.onTubulActivation(_loc1_);
      }
      
      private function desactivateTubul() : void {
         if(this.soundIsActivate)
         {
            return;
         }
         if(this._ambientManager != null)
         {
            this._ambientManager.stopMusicAndAmbient();
         }
         if(this._localizedSoundsManager != null)
         {
            this._localizedSoundsManager.stopLocalizedSounds();
         }
         Tubul.getInstance().clearBuses();
      }
      
      private function checkIfAvailable() : Boolean {
         return (this._forceSounds) && (this._soundDirectoryExist);
      }
      
      public function playAdminSound(param1:String, param2:Number, param3:Boolean, param4:uint) : void {
         var _loc5_:uint = SoundUtil.getBusIdBySoundId(param1);
         var _loc6_:String = SoundUtil.getConfigEntryByBusId(_loc5_);
         var _loc7_:Uri = new Uri(_loc6_ + param1 + ".mp3");
         var _loc8_:ISound = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND,_loc7_);
         _loc8_.busId = _loc5_;
         _loc8_.volume = param2 / 100;
         this._adminSounds[param4] = _loc8_;
         _loc8_.play(param3);
      }
      
      public function stopAdminSound(param1:uint) : void {
         var _loc2_:ISound = this._adminSounds[param1] as ISound;
         _loc2_.stop();
      }
      
      public function addSoundInPlaylist(param1:String, param2:Number, param3:uint, param4:uint) : Boolean {
         if(this._adminPlaylist == null)
         {
            this._adminPlaylist = new PlayList(false,true);
         }
         var _loc5_:uint = SoundUtil.getBusIdBySoundId(param1);
         var _loc6_:String = SoundUtil.getConfigEntryByBusId(_loc5_);
         var _loc7_:Uri = new Uri(_loc6_ + param1 + ".mp3");
         var _loc8_:ISound = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND,_loc7_);
         if(this._adminPlaylist.addSound(_loc8_) > 0)
         {
            return true;
         }
         return false;
      }
      
      public function removeSoundInPLaylist(param1:String) : Boolean {
         if(this._adminPlaylist == null)
         {
            return false;
         }
         this._adminPlaylist.removeSoundBySoundId(param1,true);
         return true;
      }
      
      public function playPlaylist() : void {
         if(!Tubul.getInstance().isActive)
         {
            return;
         }
         if(this._adminPlaylist == null)
         {
            return;
         }
         this._adminPlaylist.play();
      }
      
      public function stopPlaylist() : void {
         if(!Tubul.getInstance().isActive)
         {
            return;
         }
         this._adminPlaylist.stop();
      }
      
      public function resetPlaylist() : void {
         if(this._adminPlaylist)
         {
            this._adminPlaylist.reset();
         }
      }
      
      public function fadeBusVolume(param1:int, param2:Number, param3:Number) : void {
         var _loc5_:VolumeFadeEffect = null;
         var _loc4_:IAudioBus = Tubul.getInstance().getBus(param1);
         if(_loc4_ != null)
         {
            _loc5_ = new VolumeFadeEffect(-1,param2,param3);
            _loc5_.attachToSoundSource(_loc4_);
            _loc5_.start();
         }
      }
      
      private function onXMLPresetsRollOffLoaded(param1:ResourceLoadedEvent) : void {
         var _loc3_:XML = null;
         var _loc4_:RollOffPreset = null;
         var _loc2_:XMLList = (param1.resource as XML).elements();
         for each (_loc3_ in _loc2_)
         {
            _loc4_ = new RollOffPreset(uint(_loc3_.GainMax),uint(_loc3_.DistMax),uint(_loc3_.DistMaxSat));
            this._rollOffPresets[_loc3_.@id] = _loc4_;
         }
      }
      
      private function onXMLPresetsRollOffFailed(param1:ResourceErrorEvent) : void {
         Tubul.getInstance().activate(false);
         _log.error("An XML sound file failed to load : " + param1.uri + " / [" + param1.errorCode + "] " + param1.errorMsg);
      }
      
      private function onXMLSoundFileLoaded(param1:ResourceLoadedEvent) : void {
         var _loc2_:String = param1.uri.fileName.split("." + param1.uri.fileType)[0];
         var _loc3_:Array = _loc2_.split("\\");
         _loc2_ = _loc3_.pop();
         this._XMLSoundFilesDictionary[_loc2_] = param1.resource;
         var _loc4_:int = this._XMLSoundFilesToLoad.indexOf(param1.uri);
         if(_loc4_ >= 0)
         {
            this._XMLSoundFilesToLoad.splice(_loc4_,1);
         }
         if(this._XMLSoundFilesToLoad.length == 0)
         {
            this._XMLSoundFilesToLoad = null;
            this._XMLSoundFilesResourceLoader.removeEventListener(ResourceLoadedEvent.LOADED,this.onXMLSoundFileLoaded);
            this._XMLSoundFilesResourceLoader.removeEventListener(ResourceErrorEvent.ERROR,this.onXMLSoundFileFailed);
         }
      }
      
      private function onXMLSoundFileFailed(param1:ResourceErrorEvent) : void {
         _log.warn("The xml sound file " + param1.uri + " failed to load !!");
      }
      
      private function onRemoveSoundInTubul(param1:AudioBusEvent) : void {
         this.removeSoundEntity(param1.sound);
      }
      
      private function onSoundAdminComplete(param1:SoundCompleteEvent) : void {
         param1.sound.eventDispatcher.removeEventListener(SoundCompleteEvent.SOUND_COMPLETE,this.onSoundAdminComplete);
         var _loc2_:String = param1.sound.uri.fileName.split(".mp3")[0];
         this._adminSounds[_loc2_] = null;
         delete this._adminSounds[[_loc2_]];
      }
      
      private function onIntroMusicHarmonicOneLoaded(param1:LoadingSoundEvent) : void {
         this._introHarmonicOneLoaded = true;
         if(this._introHarmonicTwoLoaded)
         {
            this.playIntro();
         }
      }
      
      private function onIntroMusicHarmonicTwoLoaded(param1:LoadingSoundEvent) : void {
         this._introHarmonicTwoLoaded = true;
         if(this._introHarmonicOneLoaded)
         {
            this.playIntro();
         }
      }
      
      private function onTubulActivation(param1:TubulEvent) : void {
         switch(param1.activated)
         {
            case true:
               Berilia.getInstance().addUIListener(this);
               TiphonEventsManager.addListener(this,"Sound");
               Tubul.getInstance().addListener(this);
               break;
            case false:
               Berilia.getInstance().removeUIListener(this);
               TiphonEventsManager.removeListener(this);
               Tubul.getInstance().removeListener(this);
               break;
         }
      }
   }
}
