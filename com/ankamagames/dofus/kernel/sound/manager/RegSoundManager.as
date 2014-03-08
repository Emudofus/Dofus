package com.ankamagames.dofus.kernel.sound.manager
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.tubul.types.PlayList;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.jerakine.protocolAudio.ProtocolEnum;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.dofus.datacenter.ambientSounds.AmbientSound;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.kernel.sound.type.SoundDofus;
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.atouin.types.WorldEntitySprite;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.tubul.types.VolumeFadeEffect;
   import flash.geom.Point;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import flash.filesystem.File;
   import com.ankamagames.dofus.kernel.sound.utils.SoundUtil;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tubul.factory.SoundFactory;
   import com.ankamagames.tubul.enum.EnumSoundType;
   import com.ankamagames.tubul.events.AudioBusEvent;
   import com.ankamagames.tubul.events.SoundCompleteEvent;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.datacenter.sounds.SoundBones;
   import com.ankamagames.jerakine.types.SoundEventParamWrapper;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.jerakine.utils.parser.FLAEventLabelParser;
   import com.ankamagames.dofus.datacenter.sounds.SoundAnimation;
   
   public class RegSoundManager extends EventDispatcher implements ISoundManager
   {
      
      public function RegSoundManager() {
         super();
         this.init();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RegSoundManager));
      
      private static var _self:ISoundManager;
      
      private var _previousSubareaId:int;
      
      private var _criterionSubarea:int;
      
      private var _entitySounds:Array;
      
      private var _reverseEntitySounds:Dictionary;
      
      private var _entityDictionary:Dictionary;
      
      private var _adminSounds:Dictionary;
      
      private var _ambientManager:AmbientSoundsManager;
      
      private var _localizedSoundsManager:LocalizedSoundsManager;
      
      private var _fightMusicManager:FightMusicManager;
      
      private var _forceSounds:Boolean = true;
      
      private var _soundDirectoryExist:Boolean = true;
      
      private var _inFight:Boolean;
      
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
      }
      
      public function playMainClientSounds() : void {
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
         this.playIntroMusic();
         SoundManager.getInstance().setSoundOptions();
      }
      
      public function stopMainClientSounds() : void {
         if(!(this._localizedSoundsManager == null) && (this._localizedSoundsManager.isInitialized))
         {
            this._localizedSoundsManager.stopLocalizedSounds();
         }
         if(this._ambientManager != null)
         {
            this._ambientManager.stopMusicAndAmbient();
         }
         if(!(this._fightMusicManager == null) && (this._inFight))
         {
            this._fightMusicManager.stopFightMusic();
         }
         this.stopIntroMusic(true);
      }
      
      public function activateSound() : void {
         this._forceSounds = true;
         this.playMainClientSounds();
      }
      
      public function deactivateSound() : void {
         this.stopMainClientSounds();
         this._forceSounds = false;
         RegConnectionManager.getInstance().send(ProtocolEnum.DEACTIVATE_SOUNDS);
      }
      
      public function setSubArea(param1:Map=null) : void {
         var _loc6_:AmbientSound = null;
         var _loc7_:AmbientSound = null;
         var _loc2_:MapPosition = MapPosition.getMapPositionById(param1.id);
         this.removeLocalizedSounds();
         this._localizedSoundsManager.setMap(param1);
         if((this.soundIsActivate) && (RegConnectionManager.getInstance().isMain))
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
         var _loc4_:Vector.<Vector.<AmbientSound>> = new Vector.<Vector.<AmbientSound>>();
         var _loc5_:* = 0;
         while(_loc5_ < 4)
         {
            _loc4_[_loc5_] = new Vector.<AmbientSound>();
            _loc5_++;
         }
         if(_loc2_)
         {
            for each (_loc6_ in _loc2_.sounds)
            {
               _loc7_ = new AmbientSound();
               _loc7_.channel = _loc6_.channel;
               _loc7_.criterionId = _loc6_.criterionId;
               _loc7_.id = _loc6_.id;
               _loc7_.silenceMax = _loc6_.silenceMax;
               _loc7_.silenceMin = _loc6_.silenceMin;
               _loc7_.volume = _loc6_.volume;
               _loc4_[_loc6_.type_id-1].push(_loc7_);
            }
         }
         for each (_loc6_ in _loc3_.ambientSounds)
         {
            if(!(_loc6_.type_id == 2 && _loc4_[_loc6_.type_id-1].length == 1))
            {
               _loc7_ = new AmbientSound();
               _loc7_.channel = _loc6_.channel;
               _loc7_.criterionId = _loc6_.criterionId;
               _loc7_.id = _loc6_.id;
               _loc7_.silenceMax = _loc6_.silenceMax;
               _loc7_.silenceMin = _loc6_.silenceMin;
               _loc7_.volume = _loc6_.volume;
               _loc4_[_loc6_.type_id-1].push(_loc7_);
            }
         }
         _log.info("Subarea Id : " + _loc3_.id + " / Map id : " + param1.id);
         this._ambientManager.setAmbientSounds(_loc4_[1],_loc4_[0]);
         this._ambientManager.selectValidSounds();
         this._ambientManager.playMusicAndAmbient();
         this._fightMusicManager.setFightSounds(_loc4_[2],_loc4_[3]);
      }
      
      public function playUISound(param1:String, param2:Boolean=false) : void {
         if(!this.checkIfAvailable())
         {
            return;
         }
         var _loc3_:SoundDofus = new SoundDofus(param1);
         _loc3_.play(param2);
      }
      
      public function playSound(param1:ISound, param2:Boolean=false, param3:int=-1) : ISound {
         var _loc6_:String = null;
         if(!this.checkIfAvailable())
         {
            return null;
         }
         var _loc4_:String = param1.uri.fileName.split(".mp3")[0];
         var _loc5_:SoundDofus = new SoundDofus(_loc4_,true);
         for (_loc6_ in param1)
         {
            if(_loc5_.hasOwnProperty(_loc6_))
            {
               _loc5_[_loc6_] = param1;
            }
         }
         _loc5_.play(param2,param3);
         return _loc5_;
      }
      
      public function playFightMusic() : void {
         this._inFight = true;
         this._fightMusicManager.selectValidSounds();
         this._fightMusicManager.startFight();
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
         var _loc9_:TiphonSprite = null;
         var _loc10_:Object = null;
         if(!((this.soundIsActivate) && (RegConnectionManager.getInstance().isMain)))
         {
            return;
         }
         if((param4 is TiphonSprite) && (TiphonSprite(param4).parentSprite) && (TiphonSprite(param4).parentSprite.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET,0)))
         {
            return;
         }
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:* = -1;
         if(param4.hasOwnProperty("absoluteBounds"))
         {
            _loc5_ = param4.absoluteBounds.x;
            _loc6_ = param4.absoluteBounds.y;
            _loc7_ = param4.id;
            if(!(_loc7_ == PlayedCharacterManager.getInstance().id) && _loc7_ > 0 && Kernel.getWorker().getFrame(FightBattleFrame) == null)
            {
               return;
            }
         }
         else
         {
            if(param4 is WorldEntitySprite)
            {
               _loc5_ = InteractiveCellManager.getInstance().getCell((param4 as WorldEntitySprite).cellId).x;
               _loc6_ = InteractiveCellManager.getInstance().getCell((param4 as WorldEntitySprite).cellId).y;
               _loc7_ = (param4 as WorldEntitySprite).identifier;
            }
            else
            {
               if(param4 is TiphonSprite)
               {
                  _loc9_ = param4 as TiphonSprite;
                  if(_loc9_.parentSprite is TiphonSprite)
                  {
                     if(_loc9_.parentSprite.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) != null)
                     {
                        _loc10_ = _loc9_.parentSprite;
                        if(_loc10_.hasOwnProperty("absoluteBounds"))
                        {
                           _loc5_ = _loc10_.absoluteBounds.x;
                           _loc6_ = _loc10_.absoluteBounds.y;
                           _loc7_ = _loc10_.id;
                           if(!(_loc7_ == PlayedCharacterManager.getInstance().id) && _loc7_ > 0 && Kernel.getWorker().getFrame(FightBattleFrame) == null)
                           {
                              return;
                           }
                        }
                     }
                  }
                  else
                  {
                     return;
                  }
               }
               else
               {
                  return;
               }
            }
         }
         switch(param2)
         {
            case "Sound":
               param3 = param3 + "*";
               break;
            case "DataSound":
               param3 = this.buildSoundLabel(_loc7_,param1,param3) + "*";
               break;
         }
         var _loc8_:* = -1;
         if(param4.look.skins)
         {
            _loc8_ = TiphonEntityLook(param4.look).firstSkin;
         }
         if(param3)
         {
            RegConnectionManager.getInstance().send(ProtocolEnum.FLA_EVENT,param3,_loc7_,_loc5_,_loc6_,_loc8_);
         }
      }
      
      public function applyDynamicMix(param1:VolumeFadeEffect, param2:uint, param3:VolumeFadeEffect) : void {
         RegConnectionManager.getInstance().send(ProtocolEnum.DYNAMIC_MIX,RegConnectionManager.getInstance().socketClientID,param1.endingValue,param1.timeFade,param2,param3.timeFade);
      }
      
      public function retriveRollOffPresets() : void {
      }
      
      public function setSoundSourcePosition(param1:int, param2:Point) : void {
         if(!this.checkIfAvailable())
         {
            return;
         }
         if(param1 == PlayedCharacterManager.getInstance().id)
         {
            RegConnectionManager.getInstance().send(ProtocolEnum.SET_PLAYER_POSITION,RegConnectionManager.getInstance().socketClientID,param2.x,param2.y);
         }
         else
         {
            RegConnectionManager.getInstance().send(ProtocolEnum.SET_SOUND_SOURCE_POSITION,RegConnectionManager.getInstance().socketClientID,this._entitySounds[param1],param2.x,param2.y);
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
         var _loc3_:ISound = null;
         var _loc2_:int = this._reverseEntitySounds[param1];
         if(!this._entitySounds[_loc2_])
         {
            return;
         }
         for each (_loc3_ in this._entitySounds[_loc2_])
         {
            if(_loc3_ == param1)
            {
               _loc3_.stop();
               this._entitySounds[_loc2_].splice(this._entitySounds[_loc2_].indexOf(_loc3_),1);
               delete this._reverseEntitySounds[[param1]];
               if(this._entitySounds[_loc2_].length == 0)
               {
                  this._entitySounds[_loc2_] = null;
               }
               return;
            }
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
         delete this._entityDictionary[[param1]];
      }
      
      public function retriveXMLSounds() : void {
      }
      
      private function playIntro() : void {
      }
      
      public function playIntroMusic(param1:Boolean=true) : void {
         if(!((this.soundIsActivate) && (RegConnectionManager.getInstance().isMain)))
         {
            return;
         }
         var _loc2_:SystemApi = new SystemApi();
         if(_loc2_.isInGame())
         {
            return;
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.PLAY_INTRO,RegConnectionManager.getInstance().socketClientID);
      }
      
      public function switchIntroMusic(param1:Boolean) : void {
         if(!((this.soundIsActivate) && (RegConnectionManager.getInstance().isMain)))
         {
            return;
         }
         var _loc2_:SystemApi = new SystemApi();
         if(_loc2_.isInGame())
         {
            return;
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.SWITCH_INTRO,RegConnectionManager.getInstance().socketClientID,param1);
      }
      
      public function stopIntroMusic(param1:Boolean=false) : void {
         if(!this.checkIfAvailable())
         {
            return;
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.STOP_INTRO,RegConnectionManager.getInstance().socketClientID,param1);
      }
      
      public function removeAllSounds(param1:Number=0, param2:Number=0) : void {
         RegConnectionManager.getInstance().send(ProtocolEnum.REMOVE_ALL_SOUNDS,RegConnectionManager.getInstance().socketClientID);
      }
      
      public function fadeBusVolume(param1:int, param2:Number, param3:Number) : void {
         RegConnectionManager.getInstance().send(ProtocolEnum.FADE_BUS,param1,param2,param3);
      }
      
      public function setBusVolume(param1:int, param2:Number) : void {
         RegConnectionManager.getInstance().send(ProtocolEnum.SET_BUS_VOLUME,param1,param2);
      }
      
      public function reset() : void {
         this.stopMainClientSounds();
         this.removeAllSounds();
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
         if(AirScanner.hasAir())
         {
            StageShareManager.stage["nativeWindow"].addEventListener(Event.CLOSE,this.onClose);
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.SAY_HELLO,RegConnectionManager.getInstance().socketClientID,File.applicationDirectory.nativePath + "/config.xml");
      }
      
      private function removeLocalizedSounds() : void {
         this._entitySounds = new Array();
         this._reverseEntitySounds = new Dictionary();
         RegConnectionManager.getInstance().send(ProtocolEnum.REMOVE_LOCALIZED_SOUNDS,RegConnectionManager.getInstance().socketClientID);
      }
      
      private function checkIfAvailable() : Boolean {
         return (this._forceSounds) && (this._soundDirectoryExist);
      }
      
      public function playAdminSound(param1:String, param2:Number, param3:Boolean, param4:uint) : void {
         var _loc5_:uint = SoundUtil.getBusIdBySoundId(param1);
         var _loc6_:String = SoundUtil.getConfigEntryByBusId(_loc5_);
         var _loc7_:Uri = new Uri(_loc6_ + param1 + ".mp3");
         var _loc8_:ISound = new SoundDofus(param1);
         _loc8_.busId = _loc5_;
         this._adminSounds[param4] = _loc8_;
         _loc8_.play(param3);
         _loc8_.volume = param2;
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
         _loc8_.busId = _loc5_;
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
         if(this.checkIfAvailable())
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
         if(this.checkIfAvailable())
         {
            return;
         }
         if(this._adminPlaylist == null)
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
      
      private function onRemoveSoundInTubul(param1:AudioBusEvent) : void {
         this.removeSoundEntity(param1.sound);
      }
      
      private function onSoundAdminComplete(param1:SoundCompleteEvent) : void {
         param1.sound.eventDispatcher.removeEventListener(SoundCompleteEvent.SOUND_COMPLETE,this.onSoundAdminComplete);
         var _loc2_:String = param1.sound.uri.fileName.split(".mp3")[0];
         this._adminSounds[_loc2_] = null;
         delete this._adminSounds[[_loc2_]];
      }
      
      public function onClose(param1:Event) : void {
         RegConnectionManager.getInstance().send(ProtocolEnum.SAY_GOODBYE,RegConnectionManager.getInstance().socketClientID);
      }
      
      public function buildSoundLabel(param1:int, param2:String, param3:String) : String {
         var _loc9_:RegExp = null;
         var _loc10_:TiphonSprite = null;
         if(param3 != null)
         {
            _loc9_ = new RegExp("^\\s*(.*?)\\s*$","g");
            param3 = param3.replace(_loc9_,"$1");
            if(param3.length == 0)
            {
               param3 = null;
            }
         }
         var _loc4_:AbstractEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as AbstractEntitiesFrame;
         if(!_loc4_)
         {
            _loc4_ = Kernel.getWorker().getFrame(FightEntitiesFrame) as AbstractEntitiesFrame;
         }
         var _loc5_:GameContextActorInformations = _loc4_?_loc4_.getEntityInfos(param1):null;
         if(!_loc5_ || !_loc5_.look)
         {
            _log.error(param1 + " : donnés incomplètes pour ce bones, impossible de créer les sons");
            return null;
         }
         var _loc6_:int = _loc5_.look.bonesId;
         var _loc7_:SoundBones = SoundBones.getSoundBonesById(_loc6_);
         var _loc8_:Vector.<SoundEventParamWrapper> = new Vector.<SoundEventParamWrapper>();
         if(_loc7_ != null)
         {
            _loc8_ = this.createSoundEvent(_loc7_,param2,param3);
         }
         if(_loc8_.length <= 0)
         {
            _loc10_ = DofusEntities.getEntity(param1) as TiphonSprite;
            if(!_loc10_ || !_loc10_.look)
            {
               _log.error(param1 + " : donnés incomplètes pour ce bones, impossible de créer les sons");
               return null;
            }
            _loc6_ = (TiphonUtility.getEntityWithoutMount(_loc10_) as TiphonSprite).look.getBone();
            _loc7_ = SoundBones.getSoundBonesById(_loc6_);
            if(_loc7_ != null)
            {
               _loc8_ = this.createSoundEvent(_loc7_,param2,param3);
            }
         }
         if(_loc8_.length > 0)
         {
            return FLAEventLabelParser.buildSoundLabel(_loc8_);
         }
         return null;
      }
      
      private function createSoundEvent(param1:SoundBones, param2:String, param3:String) : Vector.<SoundEventParamWrapper> {
         var _loc5_:SoundAnimation = null;
         var _loc4_:Vector.<SoundEventParamWrapper> = new Vector.<SoundEventParamWrapper>();
         for each (_loc5_ in param1.getSoundAnimationByLabel(param2,param3))
         {
            _loc4_.push(new SoundEventParamWrapper(_loc5_.filename,_loc5_.volume,_loc5_.rolloff,_loc5_.automationDuration,_loc5_.automationVolume,_loc5_.automationFadeIn,_loc5_.automationFadeOut,_loc5_.noCutSilence));
         }
         return _loc4_;
      }
   }
}
