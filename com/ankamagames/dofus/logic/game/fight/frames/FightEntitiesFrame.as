package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.dofus.kernel.Kernel;
   import flash.utils.Dictionary;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightRefreshFighterMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightHumanReadyStateMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameEntityDispositionMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameEntitiesDispositionMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRefreshEntityLookMessage;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.network.messages.game.context.ShowCellSpectatorMessage;
   import com.ankamagames.dofus.network.messages.game.context.ShowCellMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCarryCharacterMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightThrowCharacterMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDropCharacterMessage;
   import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateMessage;
   import flash.display.Sprite;
   import com.ankamagames.dofus.network.types.game.context.IdentifiedEntityDispositionInformations;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsWithCoordsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataInHouseMessage;
   import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.types.game.interactive.StatedElement;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterRandomStaticPoseMessage;
   import com.ankamagames.dofus.logic.game.fight.miscs.CustomAnimStatiqueAnimationModifier;
   import com.ankamagames.dofus.misc.utils.EmbedAssets;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.logic.game.fight.actions.RemoveEntityAction;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowCellManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.dofus.network.enums.MapObstacleStateEnum;
   import com.ankamagames.dofus.network.types.game.context.FightEntityDispositionInformations;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleDematerializationAction;
   import flash.utils.clearTimeout;
   import flash.display.InteractiveObject;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.display.DisplayObjectContainer;
   import flash.display.DisplayObject;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMinimalStatsPreparation;
   import __AS3__.vec.*;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.logic.game.fight.steps.FightChangeVisibilityStep;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.network.enums.TeamEnum;
   import flash.geom.ColorTransform;
   import flash.filters.GlowFilter;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.logic.game.fight.miscs.CarrierAnimationModifier;
   import com.ankamagames.dofus.logic.game.fight.steps.FightCarryCharacterStep;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.logic.game.fight.miscs.FightEntitiesHolder;
   
   public class FightEntitiesFrame extends AbstractEntitiesFrame implements Frame
   {
      
      public function FightEntitiesFrame() {
         this._ie = new Dictionary(true);
         this._tempFighterList = new Array();
         super();
      }
      
      private static const TEAM_CIRCLE_COLOR_1:uint = 255;
      
      private static const TEAM_CIRCLE_COLOR_2:uint = 16711680;
      
      public static function getCurrentInstance() : FightEntitiesFrame {
         return Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
      }
      
      private var _showCellStart:Number = 0;
      
      private var arrowId:uint;
      
      private var _ie:Dictionary;
      
      private var _tempFighterList:Array;
      
      private var _illusionEntities:Dictionary;
      
      private var _entitiesNumber:Dictionary;
      
      private var _lastKnownPosition:Dictionary;
      
      private var _lastKnownMovementPoint:Dictionary;
      
      private var _lastKnownPlayerStatus:Dictionary;
      
      private var _realFightersLooks:Dictionary;
      
      override public function pushed() : Boolean {
         Atouin.getInstance().cellOverEnabled = true;
         Dofus.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         this._entitiesNumber = new Dictionary();
         this._illusionEntities = new Dictionary();
         this._lastKnownPosition = new Dictionary();
         this._lastKnownMovementPoint = new Dictionary();
         this._lastKnownPlayerStatus = new Dictionary();
         this._realFightersLooks = new Dictionary();
         _creaturesFightMode = OptionManager.getOptionManager("dofus")["creaturesFightMode"];
         return super.pushed();
      }
      
      override public function addOrUpdateActor(infos:GameContextActorInformations, animationModifier:IAnimationModifier=null) : AnimatedCharacter {
         var res:AnimatedCharacter = super.addOrUpdateActor(infos,animationModifier);
         if(infos.disposition.cellId != -1)
         {
            this._lastKnownPosition[infos.contextualId] = infos.disposition.cellId;
         }
         if(infos.contextualId > 0)
         {
            res.disableMouseEventWhenAnimated = true;
         }
         if(CurrentPlayedFighterManager.getInstance().currentFighterId == infos.contextualId)
         {
            res.setCanSeeThrough(true);
         }
         if(infos is GameFightCharacterInformations)
         {
            this._lastKnownPlayerStatus[infos.contextualId] = GameFightCharacterInformations(infos).status.statusId;
         }
         return res;
      }
      
      override public function process(msg:Message) : Boolean {
         var gfrfmsg:GameFightRefreshFighterMessage = null;
         var actorId:* = 0;
         var fullInfos:GameContextActorInformations = null;
         var gfsfmsg:GameFightShowFighterMessage = null;
         var gfhrsmsg:GameFightHumanReadyStateMessage = null;
         var ac2:AnimatedCharacter = null;
         var gedmsg:GameEntityDispositionMessage = null;
         var gedsmsg:GameEntitiesDispositionMessage = null;
         var gcrelmsg:GameContextRefreshEntityLookMessage = null;
         var tiphonSprite:TiphonSprite = null;
         var fighterRemovedId:* = 0;
         var scsmsg:ShowCellSpectatorMessage = null;
         var stext:String = null;
         var scmsg:ShowCellMessage = null;
         var fightFrame:FightContextFrame = null;
         var name:String = null;
         var text:String = null;
         var mcidmsg:MapComplementaryInformationsDataMessage = null;
         var gafccmsg:GameActionFightCarryCharacterMessage = null;
         var gaftcmsg:GameActionFightThrowCharacterMessage = null;
         var gafdcmsg:GameActionFightDropCharacterMessage = null;
         var psum:PlayerStatusUpdateMessage = null;
         var staticRandomAnimModifier:IAnimationModifier = null;
         var swords:Sprite = null;
         var disposition:IdentifiedEntityDispositionInformations = null;
         var mciwcmsg:MapComplementaryInformationsWithCoordsMessage = null;
         var mcidihmsg:MapComplementaryInformationsDataInHouseMessage = null;
         var playerHouse:* = false;
         var mo:MapObstacle = null;
         var ie:InteractiveElement = null;
         var se:StatedElement = null;
         var ent:GameFightFighterInformations = null;
         switch(true)
         {
            case msg is GameFightRefreshFighterMessage:
               gfrfmsg = msg as GameFightRefreshFighterMessage;
               actorId = gfrfmsg.informations.contextualId;
               fullInfos = _entities[actorId];
               if(fullInfos != null)
               {
                  fullInfos.disposition = gfrfmsg.informations.disposition;
                  fullInfos.look = gfrfmsg.informations.look;
                  this._realFightersLooks[gfrfmsg.informations.contextualId] = gfrfmsg.informations.look;
                  this.updateActor(fullInfos,true);
               }
               if(Kernel.getWorker().getFrame(FightPreparationFrame))
               {
                  KernelEventsManager.getInstance().processCallback(FightHookList.UpdatePreFightersList,actorId);
                  if(Dofus.getInstance().options.orderFighters)
                  {
                     this.updateAllEntitiesNumber(this.getOrdonnedPreFighters());
                  }
               }
               return true;
            case msg is GameFightShowFighterMessage:
               gfsfmsg = msg as GameFightShowFighterMessage;
               this._realFightersLooks[gfsfmsg.informations.contextualId] = gfsfmsg.informations.look;
               if(msg is GameFightShowFighterRandomStaticPoseMessage)
               {
                  staticRandomAnimModifier = new CustomAnimStatiqueAnimationModifier();
                  (staticRandomAnimModifier as CustomAnimStatiqueAnimationModifier).randomStatique = true;
                  this.updateFighter(gfsfmsg.informations,staticRandomAnimModifier);
                  this._illusionEntities[gfsfmsg.informations.contextualId] = true;
               }
               else
               {
                  this.updateFighter(gfsfmsg.informations);
                  this._illusionEntities[gfsfmsg.informations.contextualId] = false;
                  if(Kernel.getWorker().getFrame(FightPreparationFrame))
                  {
                     KernelEventsManager.getInstance().processCallback(FightHookList.UpdatePreFightersList,gfsfmsg.informations.contextualId);
                     if(Dofus.getInstance().options.orderFighters)
                     {
                        this.updateAllEntitiesNumber(this.getOrdonnedPreFighters());
                     }
                  }
               }
               return true;
            case msg is GameFightHumanReadyStateMessage:
               gfhrsmsg = msg as GameFightHumanReadyStateMessage;
               ac2 = this.addOrUpdateActor(getEntityInfos(gfhrsmsg.characterId) as GameFightFighterInformations);
               if(gfhrsmsg.isReady)
               {
                  swords = EmbedAssets.getSprite("SWORDS_CLIP");
                  ac2.addBackground("readySwords",swords);
               }
               else
               {
                  ac2.removeBackground("readySwords");
               }
               return true;
            case msg is GameEntityDispositionMessage:
               gedmsg = msg as GameEntityDispositionMessage;
               if(gedmsg.disposition.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  SoundManager.getInstance().manager.playUISound(UISoundEnum.FIGHT_POSITION);
               }
               this.updateActorDisposition(gedmsg.disposition.id,gedmsg.disposition);
               KernelEventsManager.getInstance().processCallback(FightHookList.GameEntityDisposition,gedmsg.disposition.id,gedmsg.disposition.cellId,gedmsg.disposition.direction);
               return true;
            case msg is GameEntitiesDispositionMessage:
               gedsmsg = msg as GameEntitiesDispositionMessage;
               for each (disposition in gedsmsg.dispositions)
               {
                  if((getEntityInfos(disposition.id)) && (!(GameFightFighterInformations(getEntityInfos(disposition.id)).stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE)))
                  {
                     this.updateActorDisposition(disposition.id,disposition);
                  }
                  KernelEventsManager.getInstance().processCallback(FightHookList.GameEntityDisposition,disposition.id,disposition.cellId,disposition.direction);
               }
               return true;
            case msg is GameContextRefreshEntityLookMessage:
               gcrelmsg = msg as GameContextRefreshEntityLookMessage;
               tiphonSprite = DofusEntities.getEntity(gcrelmsg.id) as TiphonSprite;
               if(tiphonSprite)
               {
                  tiphonSprite.setAnimation(AnimationEnum.ANIM_STATIQUE);
               }
               updateActorLook(gcrelmsg.id,gcrelmsg.look);
               return true;
            case msg is ToggleDematerializationAction:
               this.showCreaturesInFight(!_creaturesFightMode);
               KernelEventsManager.getInstance().processCallback(FightHookList.DematerializationChanged,_creaturesFightMode);
               return true;
            case msg is RemoveEntityAction:
               fighterRemovedId = RemoveEntityAction(msg).actorId;
               this._entitiesNumber[fighterRemovedId] = null;
               removeActor(fighterRemovedId);
               KernelEventsManager.getInstance().processCallback(FightHookList.UpdatePreFightersList);
               delete this._realFightersLooks[[fighterRemovedId]];
               return true;
            case msg is ShowCellSpectatorMessage:
               scsmsg = msg as ShowCellSpectatorMessage;
               HyperlinkShowCellManager.showCell(scsmsg.cellId);
               stext = I18n.getUiText("ui.fight.showCell",[scsmsg.playerName,scsmsg.cellId]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,stext,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is ShowCellMessage:
               scmsg = msg as ShowCellMessage;
               HyperlinkShowCellManager.showCell(scmsg.cellId);
               fightFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               name = fightFrame?fightFrame.getFighterName(scmsg.sourceId):"???";
               text = I18n.getUiText("ui.fight.showCell",[name,"{cell," + scmsg.cellId + "::" + scmsg.cellId + "}"]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,text,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is MapComplementaryInformationsDataMessage:
               mcidmsg = msg as MapComplementaryInformationsDataMessage;
               _interactiveElements = mcidmsg.interactiveElements;
               if(msg is MapComplementaryInformationsWithCoordsMessage)
               {
                  mciwcmsg = msg as MapComplementaryInformationsWithCoordsMessage;
                  if(PlayedCharacterManager.getInstance().isInHouse)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                  }
                  PlayedCharacterManager.getInstance().isInHouse = false;
                  PlayedCharacterManager.getInstance().isInHisHouse = false;
                  PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(mciwcmsg.worldX,mciwcmsg.worldY);
                  _worldPoint = new WorldPointWrapper(mciwcmsg.mapId,true,mciwcmsg.worldX,mciwcmsg.worldY);
               }
               else
               {
                  if(msg is MapComplementaryInformationsDataInHouseMessage)
                  {
                     mcidihmsg = msg as MapComplementaryInformationsDataInHouseMessage;
                     playerHouse = PlayerManager.getInstance().nickname == mcidihmsg.currentHouse.ownerName;
                     PlayedCharacterManager.getInstance().isInHouse = true;
                     if(playerHouse)
                     {
                        PlayedCharacterManager.getInstance().isInHisHouse = true;
                     }
                     PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(mcidihmsg.currentHouse.worldX,mcidihmsg.currentHouse.worldY);
                     KernelEventsManager.getInstance().processCallback(HookList.HouseEntered,playerHouse,mcidihmsg.currentHouse.ownerId,mcidihmsg.currentHouse.ownerName,mcidihmsg.currentHouse.price,mcidihmsg.currentHouse.isLocked,mcidihmsg.currentHouse.worldX,mcidihmsg.currentHouse.worldY,HouseWrapper.manualCreate(mcidihmsg.currentHouse.modelId,-1,mcidihmsg.currentHouse.ownerName,!(mcidihmsg.currentHouse.price == 0)));
                     _worldPoint = new WorldPointWrapper(mcidihmsg.mapId,true,mcidihmsg.currentHouse.worldX,mcidihmsg.currentHouse.worldY);
                  }
                  else
                  {
                     _worldPoint = new WorldPointWrapper(mcidmsg.mapId);
                     if(PlayedCharacterManager.getInstance().isInHouse)
                     {
                        KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                     }
                     PlayedCharacterManager.getInstance().isInHouse = false;
                     PlayedCharacterManager.getInstance().isInHisHouse = false;
                  }
               }
               _currentSubAreaId = mcidmsg.subAreaId;
               PlayedCharacterManager.getInstance().currentMap = _worldPoint;
               PlayedCharacterManager.getInstance().currentSubArea = SubArea.getSubAreaById(_currentSubAreaId);
               TooltipManager.hide();
               for each (mo in mcidmsg.obstacles)
               {
                  InteractiveCellManager.getInstance().updateCell(mo.obstacleCellId,mo.state == MapObstacleStateEnum.OBSTACLE_OPENED);
               }
               for each (ie in mcidmsg.interactiveElements)
               {
                  if(ie.enabledSkills.length)
                  {
                     this.registerInteractive(ie,ie.enabledSkills[0].skillId);
                  }
                  else
                  {
                     if(ie.disabledSkills.length)
                     {
                        this.registerInteractive(ie,ie.disabledSkills[0].skillId);
                     }
                  }
               }
               for each (se in mcidmsg.statedElements)
               {
                  this.updateStatedElement(se);
               }
               KernelEventsManager.getInstance().processCallback(HookList.MapComplementaryInformationsData,PlayedCharacterManager.getInstance().currentMap,_currentSubAreaId,Dofus.getInstance().options.mapCoordinates);
               KernelEventsManager.getInstance().processCallback(HookList.MapFightCount,0);
               return true;
            case msg is GameActionFightCarryCharacterMessage:
               gafccmsg = msg as GameActionFightCarryCharacterMessage;
               if(gafccmsg.cellId != -1)
               {
                  for each (ent in _entities)
                  {
                     if(ent.contextualId == gafccmsg.targetId)
                     {
                        (ent.disposition as FightEntityDispositionInformations).carryingCharacterId = gafccmsg.sourceId;
                        this._tempFighterList.push(new TmpFighterInfos(ent.contextualId,gafccmsg.sourceId));
                        break;
                     }
                  }
               }
               return true;
            case msg is GameActionFightThrowCharacterMessage:
               gaftcmsg = msg as GameActionFightThrowCharacterMessage;
               this.dropEntity(gaftcmsg.targetId);
               return true;
            case msg is GameActionFightDropCharacterMessage:
               gafdcmsg = msg as GameActionFightDropCharacterMessage;
               this.dropEntity(gafdcmsg.targetId);
               return true;
            case msg is PlayerStatusUpdateMessage:
               psum = msg as PlayerStatusUpdateMessage;
               this._lastKnownPlayerStatus[psum.playerId] = psum.status.statusId;
               return false;
         }
      }
      
      private function dropEntity(targetId:int) : void {
         var index:* = 0;
         var ent:GameFightFighterInformations = null;
         for each (ent in _entities)
         {
            if(ent.contextualId == targetId)
            {
               (ent.disposition as FightEntityDispositionInformations).carryingCharacterId = NaN;
               index = this.getTmpFighterInfoIndex(ent.contextualId);
               if((!(this._tempFighterList == null)) && (!(this._tempFighterList.length == 0)) && (!(index == -1)))
               {
                  this._tempFighterList.splice(index,1);
               }
               return;
            }
         }
      }
      
      public function showCreaturesInFight(activated:Boolean=false) : void {
         var ent:GameFightFighterInformations = null;
         var ac:AnimatedCharacter = null;
         _creaturesFightMode = activated;
         _justSwitchingCreaturesFightMode = true;
         for each (ent in _entities)
         {
            this.updateFighter(ent);
         }
         _justSwitchingCreaturesFightMode = false;
      }
      
      public function entityIsIllusion(id:int) : Boolean {
         return this._illusionEntities[id];
      }
      
      public function getLastKnownEntityPosition(id:int) : int {
         return !(this._lastKnownPosition[id] == null)?this._lastKnownPosition[id]:-1;
      }
      
      public function setLastKnownEntityPosition(id:int, value:int) : void {
         this._lastKnownPosition[id] = value;
      }
      
      public function getLastKnownEntityMovementPoint(id:int) : int {
         return !(this._lastKnownMovementPoint[id] == null)?this._lastKnownMovementPoint[id]:0;
      }
      
      public function setLastKnownEntityMovementPoint(id:int, value:int, add:Boolean=false) : void {
         if(this._lastKnownMovementPoint[id] == null)
         {
            this._lastKnownMovementPoint[id] = 0;
         }
         if(!add)
         {
            this._lastKnownMovementPoint[id] = value;
         }
         else
         {
            this._lastKnownMovementPoint[id] = this._lastKnownMovementPoint[id] + value;
         }
      }
      
      override public function pulled() : Boolean {
         var obj:Object = null;
         var fighterId:* = undefined;
         Dofus.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         this._tempFighterList = null;
         for each (obj in this._ie)
         {
            this.removeInteractive(obj.element as InteractiveElement);
         }
         for (fighterId in this._realFightersLooks)
         {
            delete this._realFightersLooks[[fighterId]];
         }
         return super.pulled();
      }
      
      private function onTimeOut() : void {
         clearTimeout(this._showCellStart);
         removeActor(this.arrowId);
         this._showCellStart = 0;
      }
      
      private function registerInteractive(ie:InteractiveElement, firstSkill:int) : void {
         var s:String = null;
         var cie:InteractiveElement = null;
         var worldObject:InteractiveObject = Atouin.getInstance().getIdentifiedElement(ie.elementId);
         if(!worldObject)
         {
            _log.error("Unknown identified element " + ie.elementId + ", unable to register it as interactive.");
            return;
         }
         var found:Boolean = false;
         for (s in interactiveElements)
         {
            cie = interactiveElements[int(s)];
            if(cie.elementId == ie.elementId)
            {
               found = true;
               interactiveElements[int(s)] = ie;
               break;
            }
         }
         if(!found)
         {
            interactiveElements.push(ie);
         }
         var worldPos:MapPoint = Atouin.getInstance().getIdentifiedElementPosition(ie.elementId);
         this._ie[worldObject] = 
            {
               "element":ie,
               "position":worldPos,
               "firstSkill":firstSkill
            };
      }
      
      private function updateStatedElement(se:StatedElement) : void {
         var worldObject:InteractiveObject = Atouin.getInstance().getIdentifiedElement(se.elementId);
         if(!worldObject)
         {
            _log.error("Unknown identified element " + se.elementId + "; unable to change its state to " + se.elementState + " !");
            return;
         }
         var ts:TiphonSprite = worldObject is DisplayObjectContainer?this.findTiphonSprite(worldObject as DisplayObjectContainer):null;
         if(!ts)
         {
            _log.warn("Unable to find an animated element for the stated element " + se.elementId + " on cell " + se.elementCellId + ", this element is probably invisible or is not configured as an animated element.");
            return;
         }
         ts.setAnimationAndDirection("AnimState1",0);
      }
      
      private function findTiphonSprite(doc:DisplayObjectContainer) : TiphonSprite {
         var child:DisplayObject = null;
         if(doc is TiphonSprite)
         {
            return doc as TiphonSprite;
         }
         if(!doc.numChildren)
         {
            return null;
         }
         var i:uint = 0;
         while(i < doc.numChildren)
         {
            child = doc.getChildAt(i);
            if(child is TiphonSprite)
            {
               return child as TiphonSprite;
            }
            if(child is DisplayObjectContainer)
            {
               return this.findTiphonSprite(child as DisplayObjectContainer);
            }
            i++;
         }
         return null;
      }
      
      private function removeInteractive(ie:InteractiveElement) : void {
         var interactiveElement:InteractiveObject = Atouin.getInstance().getIdentifiedElement(ie.elementId);
         delete this._ie[[interactiveElement]];
      }
      
      public function getOrdonnedPreFighters() : Vector.<int> {
         var badInit:* = 0;
         var goodInit:* = 0;
         var id:* = 0;
         var badStart:* = false;
         var fighter:GameFightFighterInformations = null;
         var stats:GameFightMinimalStatsPreparation = null;
         var entitiesIds:Vector.<int> = getEntitiesIdsList();
         var fighters:Vector.<int> = new Vector.<int>();
         if((!entitiesIds) || (entitiesIds.length <= 1))
         {
            return fighters;
         }
         var goodGuys:Array = new Array();
         var badGuys:Array = new Array();
         for each (id in entitiesIds)
         {
            fighter = getEntityInfos(id) as GameFightFighterInformations;
            if(fighter)
            {
               stats = fighter.stats as GameFightMinimalStatsPreparation;
               if(stats)
               {
                  if(fighter.teamId == 0)
                  {
                     badGuys.push(
                        {
                           "fighter":id,
                           "init":stats.initiative * stats.lifePoints / stats.maxLifePoints
                        });
                     badInit = badInit + stats.initiative * stats.lifePoints / stats.maxLifePoints;
                  }
                  else
                  {
                     goodGuys.push(
                        {
                           "fighter":id,
                           "init":stats.initiative * stats.lifePoints / stats.maxLifePoints
                        });
                     goodInit = goodInit + stats.initiative * stats.lifePoints / stats.maxLifePoints;
                  }
               }
            }
         }
         badGuys.sortOn(["init","fighter"],Array.DESCENDING | Array.NUMERIC);
         goodGuys.sortOn(["init","fighter"],Array.DESCENDING | Array.NUMERIC);
         badStart = true;
         if((badGuys.length == 0) || (goodGuys.length == 0) || (badInit / badGuys.length < goodInit / goodGuys.length))
         {
            badStart = false;
         }
         var length:int = Math.max(badGuys.length,goodGuys.length);
         var i:int = 0;
         while(i < length)
         {
            if(badStart)
            {
               if(badGuys[i])
               {
                  fighters.push(badGuys[i].fighter);
               }
               if(goodGuys[i])
               {
                  fighters.push(goodGuys[i].fighter);
               }
            }
            else
            {
               if(goodGuys[i])
               {
                  fighters.push(goodGuys[i].fighter);
               }
               if(badGuys[i])
               {
                  fighters.push(badGuys[i].fighter);
               }
            }
            i++;
         }
         return fighters;
      }
      
      public function removeSwords() : void {
         var entInfo:* = undefined;
         var ac:AnimatedCharacter = null;
         for each (entInfo in _entities)
         {
            if(!((entInfo is GameFightCharacterInformations) && (!GameFightCharacterInformations(entInfo).alive)))
            {
               ac = this.addOrUpdateActor(entInfo);
               ac.removeBackground("readySwords");
            }
         }
      }
      
      public function updateFighter(fighterInfos:GameFightFighterInformations, animationModifier:IAnimationModifier=null, finishingBuff:Array=null) : void {
         var i:* = 0;
         var buffArray:Array = null;
         var buff:BasicBuff = null;
         var statBuff:StatBuff = null;
         var statName:String = null;
         var effect:Effect = null;
         var lastInvisibilityStat:* = 0;
         var lastFighterInfo:GameFightFighterInformations = null;
         var ac:AnimatedCharacter = null;
         var inviStep:FightChangeVisibilityStep = null;
         var fighterId:int = fighterInfos.contextualId;
         if(finishingBuff)
         {
            i = 0;
            while(i < finishingBuff.length)
            {
               buffArray = BuffManager.getInstance().getAllBuff(fighterId);
               for each (buff in buffArray)
               {
                  if(buff.id == finishingBuff[i].id)
                  {
                     statBuff = finishingBuff[i] as StatBuff;
                     statName = statBuff.statName;
                     effect = Effect.getEffectById(statBuff.actionId);
                     if((statName) && (fighterInfos.stats.hasOwnProperty(statName)) && (effect.active))
                     {
                        if(statName == "actionPoints")
                        {
                           fighterInfos.stats["maxActionPoints"] = fighterInfos.stats["maxActionPoints"] - finishingBuff[i].delta;
                        }
                        fighterInfos.stats[statName] = fighterInfos.stats[statName] - finishingBuff[i].delta;
                     }
                  }
               }
               i++;
            }
         }
         if(fighterInfos.alive)
         {
            lastInvisibilityStat = -1;
            lastFighterInfo = _entities[fighterInfos.contextualId] as GameFightFighterInformations;
            if(lastFighterInfo)
            {
               lastInvisibilityStat = lastFighterInfo.stats.invisibilityState;
            }
            if((lastInvisibilityStat == GameActionFightInvisibilityStateEnum.INVISIBLE) && (fighterInfos.stats.invisibilityState == lastInvisibilityStat))
            {
               registerActor(fighterInfos);
               return;
            }
            if(lastFighterInfo != fighterInfos)
            {
               registerActor(fighterInfos);
               if(fighterInfos.contextualId == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
               }
            }
            ac = this.addOrUpdateActor(fighterInfos,animationModifier);
            if((!(fighterInfos.stats.invisibilityState == GameActionFightInvisibilityStateEnum.VISIBLE)) && (!(fighterInfos.stats.invisibilityState == lastInvisibilityStat)))
            {
               inviStep = new FightChangeVisibilityStep(fighterId,fighterInfos.stats.invisibilityState);
               inviStep.start();
            }
            this.addCircleToFighter(ac,fighterInfos.teamId == TeamEnum.TEAM_DEFENDER?TEAM_CIRCLE_COLOR_1:TEAM_CIRCLE_COLOR_2);
         }
         else
         {
            this.updateActor(fighterInfos,false);
         }
         this.updateCarriedEntities(fighterInfos);
      }
      
      public function updateActor(actorInfos:GameContextActorInformations, alive:Boolean=true, animationModifier:IAnimationModifier=null) : void {
         var ac:AnimatedCharacter = null;
         var actorId:int = actorInfos.contextualId;
         if(alive)
         {
            registerActor(actorInfos);
            ac = this.addOrUpdateActor(actorInfos,animationModifier);
         }
         else
         {
            if(_entities[actorId])
            {
               hideActor(actorId);
            }
            registerActor(actorInfos);
         }
      }
      
      private function addCircleToFighter(pAc:AnimatedCharacter, pColor:uint) : void {
         var circle:Sprite = new Sprite();
         var teamCircle:Sprite = EmbedAssets.getSprite("TEAM_CIRCLE_CLIP");
         circle.addChild(teamCircle);
         var colorTransform:ColorTransform = new ColorTransform();
         colorTransform.color = pColor;
         circle.filters = [new GlowFilter(16777215,0.5,2,2,3,3)];
         teamCircle.transform.colorTransform = colorTransform;
         pAc.addBackground("teamCircle",circle);
      }
      
      private function updateCarriedEntities(fighterInfos:GameContextActorInformations) : void {
         var infos:TmpFighterInfos = null;
         var carryingCharacterId:* = 0;
         var fedi:FightEntityDispositionInformations = null;
         var carryingEntity:IEntity = null;
         var carriedEntity:IEntity = null;
         var hasCarryingModifier:* = false;
         var carryingTs:TiphonSprite = null;
         var modifier:IAnimationModifier = null;
         var fighterId:int = fighterInfos.contextualId;
         var num:int = this._tempFighterList.length;
         var i:int = 0;
         while(i < num)
         {
            infos = this._tempFighterList[i];
            carryingCharacterId = infos.carryingCharacterId;
            if(fighterId == carryingCharacterId)
            {
               this._tempFighterList.splice(i,1);
               this.startCarryStep(carryingCharacterId,infos.contextualId);
               break;
            }
            i++;
         }
         if(fighterInfos.disposition is FightEntityDispositionInformations)
         {
            fedi = fighterInfos.disposition as FightEntityDispositionInformations;
            if(fedi.carryingCharacterId)
            {
               carryingEntity = DofusEntities.getEntity(fedi.carryingCharacterId);
               if(!carryingEntity)
               {
                  this._tempFighterList.push(new TmpFighterInfos(fighterInfos.contextualId,fedi.carryingCharacterId));
               }
               else
               {
                  carriedEntity = DofusEntities.getEntity(fighterInfos.contextualId);
                  if(carriedEntity)
                  {
                     hasCarryingModifier = false;
                     if((carryingEntity as AnimatedCharacter).isMounted())
                     {
                        carryingTs = (carryingEntity as TiphonSprite).getSubEntitySlot(2,0) as TiphonSprite;
                     }
                     else
                     {
                        carryingTs = carryingEntity as TiphonSprite;
                     }
                     if(carryingTs)
                     {
                        carryingTs.removeAnimationModifierByClass(CustomAnimStatiqueAnimationModifier);
                        for each (modifier in carryingTs.animationModifiers)
                        {
                           if(modifier is CarrierAnimationModifier)
                           {
                              hasCarryingModifier = true;
                              break;
                           }
                        }
                        if(!hasCarryingModifier)
                        {
                           carryingTs.addAnimationModifier(CarrierAnimationModifier.getInstance());
                        }
                     }
                     if((!hasCarryingModifier) || (!((carryingEntity is TiphonSprite) && (carriedEntity is TiphonSprite) && (TiphonSprite(carriedEntity).parentSprite == carryingEntity))))
                     {
                        this.startCarryStep(fedi.carryingCharacterId,fighterInfos.contextualId);
                     }
                  }
               }
            }
         }
      }
      
      private function startCarryStep(fighterId:int, carriedId:int) : void {
         var step:FightCarryCharacterStep = new FightCarryCharacterStep(fighterId,carriedId,-1,true);
         step.start();
         FightEventsHelper.sendAllFightEvent();
      }
      
      public function updateAllEntitiesNumber(ids:Vector.<int>) : void {
         var id:* = 0;
         var num:uint = 1;
         for each (id in ids)
         {
            if((_entities[id]) && (_entities[id].alive))
            {
               this.updateEntityNumber(id,num);
               num++;
            }
         }
      }
      
      public function updateEntityNumber(id:int, num:uint) : void {
         var number:Sprite = null;
         var lbl_number:Label = null;
         var ac:AnimatedCharacter = null;
         if((_entities[id]) && ((!(_entities[id] is GameFightCharacterInformations)) || (GameFightCharacterInformations(_entities[id]).alive)))
         {
            if((!this._entitiesNumber[id]) || (this._entitiesNumber[id] == null))
            {
               number = new Sprite();
               lbl_number = new Label();
               lbl_number.width = 30;
               lbl_number.height = 20;
               lbl_number.x = -45;
               lbl_number.y = -15;
               lbl_number.css = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "css/normal.css");
               lbl_number.text = num.toString();
               number.addChild(lbl_number);
               number.filters = [new GlowFilter(XmlConfig.getInstance().getEntry("colors.text.glow"),1,4,4,6,3)];
               this._entitiesNumber[id] = lbl_number;
               ac = DofusEntities.getEntity(id) as AnimatedCharacter;
               if(ac)
               {
                  ac.addBackground("fighterNumber",number);
               }
            }
            else
            {
               this._entitiesNumber[id].text = num.toString();
            }
         }
      }
      
      public function updateRemovedEntity(idEntity:int) : void {
         var num:uint = 0;
         var fightBFrame:FightBattleFrame = null;
         var entId:* = 0;
         this._entitiesNumber[idEntity] = null;
         if(Dofus.getInstance().options.orderFighters)
         {
            num = 1;
            fightBFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
            for each (entId in fightBFrame.fightersList)
            {
               if((!(entId == idEntity)) && ((getEntityInfos(entId) as GameFightFighterInformations).alive))
               {
                  this.updateEntityNumber(entId,num);
                  num++;
               }
            }
         }
      }
      
      override protected function onPropertyChanged(e:PropertyChangeEvent) : void {
         var id:String = null;
         var ac:AnimatedCharacter = null;
         var num:uint = 0;
         var fightBFrame:FightBattleFrame = null;
         var entId:* = 0;
         if(!_worldPoint)
         {
            _worldPoint = PlayedCharacterManager.getInstance().currentMap;
         }
         if(!_currentSubAreaId)
         {
            _currentSubAreaId = PlayedCharacterManager.getInstance().currentSubArea.id;
         }
         super.onPropertyChanged(e);
         if(e.propertyName == "cellSelectionOnly")
         {
            untargetableEntities = (e.propertyValue) || (Kernel.getWorker().getFrame(FightPreparationFrame));
         }
         else
         {
            if(e.propertyName == "orderFighters")
            {
               if(!e.propertyValue)
               {
                  for (id in this._entitiesNumber)
                  {
                     if(this._entitiesNumber[int(id)])
                     {
                        this._entitiesNumber[int(id)] = null;
                        ac = DofusEntities.getEntity(int(id)) as AnimatedCharacter;
                        if(ac)
                        {
                           ac.removeBackground("fighterNumber");
                        }
                     }
                  }
               }
               else
               {
                  num = 1;
                  fightBFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
                  if(fightBFrame)
                  {
                     for each (entId in fightBFrame.fightersList)
                     {
                        if((getEntityInfos(entId) as GameFightFighterInformations).alive)
                        {
                           this.updateEntityNumber(entId,num);
                           num++;
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function set cellSelectionOnly(enabled:Boolean) : void {
         var infos:GameContextActorInformations = null;
         var entity:AnimatedCharacter = null;
         for each (infos in _entities)
         {
            entity = DofusEntities.getEntity(infos.contextualId) as AnimatedCharacter;
            if(entity)
            {
               entity.mouseEnabled = !enabled;
            }
         }
      }
      
      public function get dematerialization() : Boolean {
         return _creaturesFightMode;
      }
      
      public function get lastKnownPlayerStatus() : Dictionary {
         return this._lastKnownPlayerStatus;
      }
      
      public function getRealFighterLook(pFighterId:int) : EntityLook {
         return this._realFightersLooks[pFighterId];
      }
      
      override protected function updateActorDisposition(actorId:int, newDisposition:EntityDispositionInformations) : void {
         var actor:IEntity = null;
         super.updateActorDisposition(actorId,newDisposition);
         if(newDisposition.cellId == -1)
         {
            actor = DofusEntities.getEntity(actorId);
            if(actor)
            {
               FightEntitiesHolder.getInstance().holdEntity(actor);
            }
         }
         else
         {
            FightEntitiesHolder.getInstance().unholdEntity(actorId);
         }
      }
      
      private function getTmpFighterInfoIndex(pId:int) : int {
         var infos:TmpFighterInfos = null;
         for each (infos in this._tempFighterList)
         {
            if(infos.contextualId == pId)
            {
               return this._tempFighterList.indexOf(infos);
            }
         }
         return -1;
      }
   }
}
class TmpFighterInfos extends Object
{
   
   function TmpFighterInfos(pId:int, pCarryindId:int) {
      super();
      this.contextualId = pId;
      this.carryingCharacterId = pCarryindId;
   }
   
   public var contextualId:int;
   
   public var carryingCharacterId:int;
}
