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
   import com.ankamagames.jerakine.types.SoundEventParamWrapper;
   import com.ankamagames.dofus.datacenter.sounds.SoundAnimation;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.datacenter.sounds.SoundBones;
   import com.ankamagames.jerakine.utils.parser.FLAEventLabelParser;


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

      public function set soundDirectoryExist(pExists:Boolean) : void {
         this._soundDirectoryExist=pExists;
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

      public function set forceSoundsDebugMode(pForce:Boolean) : void {
         this._forceSounds=pForce;
      }

      public function playMainClientSounds() : void {
         if((!(this._localizedSoundsManager==null))&&(this._localizedSoundsManager.isInitialized))
         {
            this._localizedSoundsManager.playLocalizedSounds();
         }
         if(this._ambientManager!=null)
         {
            this._ambientManager.playMusicAndAmbient();
         }
         if((!(this._fightMusicManager==null))&&(this._inFight))
         {
            this._fightMusicManager.playFightMusic();
         }
         this.playIntroMusic();
         SoundManager.getInstance().setSoundOptions();
      }

      public function stopMainClientSounds() : void {
         if((!(this._localizedSoundsManager==null))&&(this._localizedSoundsManager.isInitialized))
         {
            this._localizedSoundsManager.stopLocalizedSounds();
         }
         if(this._ambientManager!=null)
         {
            this._ambientManager.stopMusicAndAmbient();
         }
         if((!(this._fightMusicManager==null))&&(this._inFight))
         {
            this._fightMusicManager.stopFightMusic();
         }
         this.stopIntroMusic(true);
      }

      public function activateSound() : void {
         this._forceSounds=true;
         this.playMainClientSounds();
      }

      public function deactivateSound() : void {
         this.stopMainClientSounds();
         this._forceSounds=false;
         RegConnectionManager.getInstance().send(ProtocolEnum.DEACTIVATE_SOUNDS);
      }

      public function setSubArea(pMap:Map=null) : void {
         var saas:AmbientSound = null;
         var saas2:AmbientSound = null;
         var newAs2:AmbientSound = null;
         var newAs:AmbientSound = null;
         var set:* = false;
         var mp:MapPosition = MapPosition.getMapPositionById(pMap.id);
         this.removeLocalizedSounds();
         this._localizedSoundsManager.setMap(pMap);
         if((this.soundIsActivate)&&(RegConnectionManager.getInstance().isMain))
         {
            this._localizedSoundsManager.playLocalizedSounds();
         }
         this._previousSubareaId=pMap.subareaId;
         this._criterionSubarea=1;
         var subArea:SubArea = SubArea.getSubAreaById(pMap.subareaId);
         if(subArea==null)
         {
            return;
         }
         var sounds:Vector.<Vector.<AmbientSound>> = new Vector.<Vector.<AmbientSound>>();
         var i:int = 0;
         while(i<4)
         {
            sounds[i]=new Vector.<AmbientSound>();
            i++;
         }
         if(mp)
         {
            for each (saas2 in mp.sounds)
            {
               newAs2=new AmbientSound();
               newAs2.channel=saas2.channel;
               newAs2.criterionId=saas2.criterionId;
               newAs2.id=saas2.id;
               newAs2.silenceMax=saas2.silenceMax;
               newAs2.silenceMin=saas2.silenceMin;
               newAs2.volume=saas2.volume;
               sounds[saas2.type_id-1].push(newAs2);
            }
         }
         for each (saas in subArea.ambientSounds)
         {
            newAs=new AmbientSound();
            newAs.channel=saas.channel;
            newAs.criterionId=saas.criterionId;
            newAs.id=saas.id;
            newAs.silenceMax=saas.silenceMax;
            newAs.silenceMin=saas.silenceMin;
            newAs.volume=saas.volume;
            set=true;
            if(set)
            {
               sounds[saas.type_id-1].push(newAs);
            }
         }
         _log.info("Subarea Id : "+subArea.id+" / Map id : "+pMap.id);
         this._ambientManager.setAmbientSounds(sounds[0],sounds[1]);
         this._ambientManager.selectValidSounds();
         this._ambientManager.playMusicAndAmbient();
         this._fightMusicManager.setFightSounds(sounds[2],sounds[3]);
      }

      public function playUISound(pSoundId:String, pLoop:Boolean=false) : void {
         if(!this.checkIfAvailable())
         {
            return;
         }
         var newSound:SoundDofus = new SoundDofus(pSoundId);
         newSound.play(pLoop);
      }

      public function playSound(pSound:ISound, pLoop:Boolean=false, pLoops:int=-1) : ISound {
         var prop:String = null;
         if(!this.checkIfAvailable())
         {
            return null;
         }
         var soundID:String = pSound.uri.fileName.split(".mp3")[0];
         var newSound:SoundDofus = new SoundDofus(soundID,true);
         for (prop in pSound)
         {
            if(newSound.hasOwnProperty(prop))
            {
               newSound[prop]=pSound;
            }
         }
         newSound.play(pLoop,pLoops);
         return newSound;
      }

      public function playFightMusic() : void {
         this._inFight=true;
         this._fightMusicManager.selectValidSounds();
         this._fightMusicManager.startFight();
         this._fightMusicManager.playFightMusic();
      }

      public function prepareFightMusic() : void {
         this._fightMusicManager.prepareFightMusic();
      }

      public function stopFightMusic() : void {
         this._inFight=false;
         this._fightMusicManager.stopFightMusic();
      }

      public function handleFLAEvent(pAnimationName:String, pType:String, pParams:String, pSprite:Object=null) : void {
         var sprite:TiphonSprite = null;
         var parent:Object = null;
         if(!((this.soundIsActivate)&&(RegConnectionManager.getInstance().isMain)))
         {
            return;
         }
         if((pSprite is TiphonSprite)&&(TiphonSprite(pSprite).parentSprite)&&(TiphonSprite(pSprite).parentSprite.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET,0)))
         {
            return;
         }
         var posX:Number = 0;
         var posY:Number = 0;
         var entityId:int = -1;
         if(pSprite.hasOwnProperty("absoluteBounds"))
         {
            posX=pSprite.absoluteBounds.x;
            posY=pSprite.absoluteBounds.y;
            entityId=pSprite.id;
            if((!(entityId==PlayedCharacterManager.getInstance().infos.id))&&(entityId<0)&&(Kernel.getWorker().getFrame(FightBattleFrame)==null))
            {
               return;
            }
         }
         else
         {
            if(pSprite is WorldEntitySprite)
            {
               posX=InteractiveCellManager.getInstance().getCell((pSprite as WorldEntitySprite).cellId).x;
               posY=InteractiveCellManager.getInstance().getCell((pSprite as WorldEntitySprite).cellId).y;
               entityId=(pSprite as WorldEntitySprite).identifier;
            }
            else
            {
               if(pSprite is TiphonSprite)
               {
                  sprite=pSprite as TiphonSprite;
                  if(sprite.parentSprite is TiphonSprite)
                  {
                     if(sprite.parentSprite.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0)!=null)
                     {
                        parent=sprite.parentSprite;
                        if(parent.hasOwnProperty("absoluteBounds"))
                        {
                           posX=parent.absoluteBounds.x;
                           posY=parent.absoluteBounds.y;
                           entityId=parent.id;
                           if((!(entityId==PlayedCharacterManager.getInstance().infos.id))&&(entityId<0)&&(Kernel.getWorker().getFrame(FightBattleFrame)==null))
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
         switch(pType)
         {
            case "Sound":
               pParams=pParams+"*";
               break;
            case "DataSound":
               pParams=this.buildSoundLabel(entityId,pAnimationName,pParams)+"*";
               break;
         }
         var skin:int = -1;
         if(pSprite.look.skins)
         {
            skin=TiphonEntityLook(pSprite.look).firstSkin;
         }
         if(pParams)
         {
            RegConnectionManager.getInstance().send(ProtocolEnum.FLA_EVENT,pParams,entityId,posX,posY,skin);
         }
      }

      public function applyDynamicMix(pFadeIn:VolumeFadeEffect, pWaitingTime:uint, pFadeOut:VolumeFadeEffect) : void {
         RegConnectionManager.getInstance().send(ProtocolEnum.DYNAMIC_MIX,RegConnectionManager.getInstance().socketClientID,pFadeIn.endingValue,pFadeIn.timeFade,pWaitingTime,pFadeOut.timeFade);
      }

      public function retriveRollOffPresets() : void {
         
      }

      public function setSoundSourcePosition(pEntityId:int, pPosition:Point) : void {
         if(!this.checkIfAvailable())
         {
            return;
         }
         if(pEntityId==PlayedCharacterManager.getInstance().id)
         {
            RegConnectionManager.getInstance().send(ProtocolEnum.SET_PLAYER_POSITION,RegConnectionManager.getInstance().socketClientID,pPosition.x,pPosition.y);
         }
         else
         {
            RegConnectionManager.getInstance().send(ProtocolEnum.SET_SOUND_SOURCE_POSITION,RegConnectionManager.getInstance().socketClientID,pEntityId,pPosition.x,pPosition.y);
         }
      }

      public function addSoundEntity(pISound:ISound, pEntityId:int) : void {
         if(!this.checkIfAvailable())
         {
            return;
         }
         if(this._entitySounds[pEntityId]==null)
         {
            this._entitySounds[pEntityId]=new Vector.<ISound>();
         }
         this._entityDictionary[DofusEntities.getEntity(pEntityId)]=this._entitySounds[pEntityId];
         this._entitySounds[pEntityId].push(pISound);
         this._reverseEntitySounds[pISound]=pEntityId;
      }

      public function removeSoundEntity(pISound:ISound) : void {
         var isound:ISound = null;
         var entityId:int = this._reverseEntitySounds[pISound];
         if(!this._entitySounds[entityId])
         {
            return;
         }
         for each (isound in this._entitySounds[entityId])
         {
            if(isound==pISound)
            {
               isound.stop();
               this._entitySounds[entityId].splice(this._entitySounds[entityId].indexOf(isound),1);
               delete this._reverseEntitySounds[[pISound]];
               if(this._entitySounds[entityId].length==0)
               {
                  this._entitySounds[entityId]=null;
               }
               return;
            }
         }
      }

      public function removeEntitySound(pEntityId:IEntity) : void {
         var isound:ISound = null;
         var fadeOut:VolumeFadeEffect = null;
         if(this._entityDictionary[pEntityId]==null)
         {
            return;
         }
         for each (isound in this._entityDictionary[pEntityId])
         {
            fadeOut=new VolumeFadeEffect(-1,0,0.1);
            isound.stop(fadeOut);
         }
         delete this._entityDictionary[[pEntityId]];
      }

      public function retriveXMLSounds() : void {
         
      }

      private function playIntro() : void {
         
      }

      public function playIntroMusic(pFirstHarmonic:Boolean=true) : void {
         if(!((this.soundIsActivate)&&(RegConnectionManager.getInstance().isMain)))
         {
            return;
         }
         var sysApi:SystemApi = new SystemApi();
         if(sysApi.isInGame())
         {
            return;
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.PLAY_INTRO,RegConnectionManager.getInstance().socketClientID);
      }

      public function switchIntroMusic(pFirstHarmonic:Boolean) : void {
         if(!((this.soundIsActivate)&&(RegConnectionManager.getInstance().isMain)))
         {
            return;
         }
         var sysApi:SystemApi = new SystemApi();
         if(sysApi.isInGame())
         {
            return;
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.SWITCH_INTRO,RegConnectionManager.getInstance().socketClientID,pFirstHarmonic);
      }

      public function stopIntroMusic(pImmediatly:Boolean=false) : void {
         if(!this.checkIfAvailable())
         {
            return;
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.STOP_INTRO,RegConnectionManager.getInstance().socketClientID,pImmediatly);
      }

      public function removeAllSounds(pFade:Number=0, pFadeTime:Number=0) : void {
         RegConnectionManager.getInstance().send(ProtocolEnum.REMOVE_ALL_SOUNDS,RegConnectionManager.getInstance().socketClientID);
      }

      public function fadeBusVolume(pBusID:int, pFade:Number, pFadeTime:Number) : void {
         RegConnectionManager.getInstance().send(ProtocolEnum.FADE_BUS,pBusID,pFade,pFadeTime);
      }

      public function setBusVolume(pBusID:int, pNewVolume:Number) : void {
         RegConnectionManager.getInstance().send(ProtocolEnum.SET_BUS_VOLUME,pBusID,pNewVolume);
      }

      public function reset() : void {
         this.stopMainClientSounds();
         this.removeAllSounds();
      }

      private function init() : void {
         this._previousSubareaId=-1;
         this._localizedSoundsManager=new LocalizedSoundsManager();
         this._ambientManager=new AmbientSoundsManager();
         this._fightMusicManager=new FightMusicManager();
         this._entitySounds=new Array();
         this._reverseEntitySounds=new Dictionary();
         this._adminSounds=new Dictionary();
         this._entityDictionary=new Dictionary();
         if(AirScanner.hasAir())
         {
            StageShareManager.stage["nativeWindow"].addEventListener(Event.CLOSE,this.onClose);
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.SAY_HELLO,RegConnectionManager.getInstance().socketClientID,File.applicationDirectory.nativePath+"/config.xml");
      }

      private function removeLocalizedSounds() : void {
         this._entitySounds=new Array();
         this._reverseEntitySounds=new Dictionary();
         RegConnectionManager.getInstance().send(ProtocolEnum.REMOVE_LOCALIZED_SOUNDS,RegConnectionManager.getInstance().socketClientID);
      }

      private function checkIfAvailable() : Boolean {
         return (this._forceSounds)&&(this._soundDirectoryExist);
      }

      public function playAdminSound(pSoundId:String, pVolume:Number, pLoop:Boolean, pType:uint) : void {
         var busId:uint = SoundUtil.getBusIdBySoundId(pSoundId);
         var soundPath:String = SoundUtil.getConfigEntryByBusId(busId);
         var soundUri:Uri = new Uri(soundPath+pSoundId+".mp3");
         var isound:ISound = new SoundDofus(pSoundId);
         isound.busId=busId;
         this._adminSounds[pType]=isound;
         isound.play(pLoop);
         isound.volume=pVolume;
      }

      public function stopAdminSound(pType:uint) : void {
         var isound:ISound = this._adminSounds[pType] as ISound;
         isound.stop();
      }

      public function addSoundInPlaylist(pSoundId:String, pVolume:Number, pSilenceMin:uint, pSilenceMax:uint) : Boolean {
         if(this._adminPlaylist==null)
         {
            this._adminPlaylist=new PlayList(false,true);
         }
         var busId:uint = SoundUtil.getBusIdBySoundId(pSoundId);
         var soundPath:String = SoundUtil.getConfigEntryByBusId(busId);
         var soundUri:Uri = new Uri(soundPath+pSoundId+".mp3");
         var isound:ISound = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND,soundUri);
         isound.busId=busId;
         if(this._adminPlaylist.addSound(isound)>0)
         {
            return true;
         }
         return false;
      }

      public function removeSoundInPLaylist(pSoundId:String) : Boolean {
         if(this._adminPlaylist==null)
         {
            return false;
         }
         this._adminPlaylist.removeSoundBySoundId(pSoundId,true);
         return true;
      }

      public function playPlaylist() : void {
         if(this.checkIfAvailable())
         {
            return;
         }
         if(this._adminPlaylist==null)
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
         if(this._adminPlaylist==null)
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

      private function onRemoveSoundInTubul(pEvent:AudioBusEvent) : void {
         this.removeSoundEntity(pEvent.sound);
      }

      private function onSoundAdminComplete(pEvent:SoundCompleteEvent) : void {
         pEvent.sound.eventDispatcher.removeEventListener(SoundCompleteEvent.SOUND_COMPLETE,this.onSoundAdminComplete);
         var soundId:String = pEvent.sound.uri.fileName.split(".mp3")[0];
         this._adminSounds[soundId]=null;
         delete this._adminSounds[[soundId]];
      }

      public function onClose(pEvent:Event) : void {
         RegConnectionManager.getInstance().send(ProtocolEnum.SAY_GOODBYE,RegConnectionManager.getInstance().socketClientID);
      }

      public function buildSoundLabel(entityId:int, animationType:String, params:String) : String {
         var r:RegExp = null;
         var soundEvents:Vector.<SoundEventParamWrapper> = null;
         var sa:SoundAnimation = null;
         if(params!=null)
         {
            r=new RegExp("^\\s*(.*?)\\s*$","g");
            params=params.replace(r,"$1");
            if(params.length==0)
            {
               params=null;
            }
         }
         var entitiesFrame:AbstractEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as AbstractEntitiesFrame;
         if(!entitiesFrame)
         {
            entitiesFrame=Kernel.getWorker().getFrame(FightEntitiesFrame) as AbstractEntitiesFrame;
         }
         var infos:GameContextActorInformations = entitiesFrame.getEntityInfos(entityId);
         if((!infos)||(!infos.look))
         {
            _log.error(entityId+" : donn�s incompl�tes pour ce bones, impossible de cr�er les sons");
            return null;
         }
         var bonesId:int = infos.look.bonesId;
         var sb:SoundBones = SoundBones.getSoundBonesById(bonesId);
         if(sb!=null)
         {
            soundEvents=new Vector.<SoundEventParamWrapper>();
            for each (sa in sb.getSoundAnimationByLabel(animationType,params))
            {
               soundEvents.push(new SoundEventParamWrapper(sa.filename,sa.volume,sa.rolloff,sa.automationDuration,sa.automationVolume,sa.automationFadeIn,sa.automationFadeOut,sa.noCutSilence));
            }
         }
         return FLAEventLabelParser.buildSoundLabel(soundEvents);
      }
   }

}