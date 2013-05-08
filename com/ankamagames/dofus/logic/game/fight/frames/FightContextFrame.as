package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.filters.GlowFilter;
   import flash.filters.ColorMatrixFilter;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import com.ankamagames.atouin.types.Selection;
   import flash.utils.Timer;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
   import com.ankamagames.atouin.Atouin;
   import flash.events.TimerEvent;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterNamedInformations;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMutantInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.internalDatacenter.fight.ChallengeWrapper;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightStartingMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import flash.utils.ByteArray;
   import com.ankamagames.dofus.network.messages.game.context.GameContextReadyMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightResumeMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightResumeSlaveInfo;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightUpdateTeamMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSpectateMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCarryCharacterMessage;
   import com.ankamagames.atouin.messages.CellOutMessage;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.atouin.messages.CellOverMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOverAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TogglePointCellAction;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.ChallengeTargetsListRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeTargetsListRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeTargetsListMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeInfoMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeTargetUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeResultMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapObstacleUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightNoSpellCastMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapInformationsRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightResumeWithSlavesMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightSpellCooldown;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
   import com.ankamagames.dofus.logic.game.common.misc.SpellModificator;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
   import com.ankamagames.dofus.network.types.game.action.fight.FightDispellableEffectExtendedInformations;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMark;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMarkedCell;
   import com.ankamagames.dofus.types.sequences.AddGlyphGfxStep;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.logic.game.common.messages.FightEndingMessage;
   import com.ankamagames.dofus.internalDatacenter.fight.FightResultEntryWrapper;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultListEntry;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
   import com.ankamagames.dofus.logic.game.fight.managers.TacticModeManager;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.hurlant.util.Hex;
   import com.ankamagames.atouin.messages.MapsLoadingCompleteMessage;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOutAction;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultPlayerListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultTaxCollectorListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultFighterListEntry;
   import com.ankamagames.dofus.network.enums.FightOutcomeEnum;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowCellManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.dofus.network.enums.MapObstacleStateEnum;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.atouin.messages.MapLoadedMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightStartMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowTacticModeAction;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import flash.display.Sprite;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.jerakine.types.Color;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.logic.game.fight.miscs.FightReachableCellsMaker;
   import com.ankamagames.jerakine.types.zones.Custom;
   import flash.display.DisplayObject;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;


   public class FightContextFrame extends Object implements Frame
   {
         

      public function FightContextFrame() {
         super();
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightContextFrame));

      public static var preFightIsActive:Boolean = true;

      public static var fighterEntityTooltipId:int;

      public static var timelineOverEntityId:int;

      public static var currentCell:int = -1;

      private const TYPE_LOG_FIGHT:uint = 30000.0;

      private const INVISIBLE_POSITION_SELECTION:String = "invisible_position";

      private var _entitiesFrame:FightEntitiesFrame;

      private var _preparationFrame:FightPreparationFrame;

      private var _battleFrame:FightBattleFrame;

      private var _pointCellFrame:FightPointCellFrame;

      private var _overEffectOk:GlowFilter;

      private var _overEffectKo:GlowFilter;

      private var _linkedEffect:ColorMatrixFilter;

      private var _linkedMainEffect:ColorMatrixFilter;

      private var _lastEffectEntity:WeakReference;

      private var _reachableRangeSelection:Selection;

      private var _unreachableRangeSelection:Selection;

      private var _timerFighterInfo:Timer;

      private var _timerMovementRange:Timer;

      private var _currentFighterInfo:GameFightFighterInformations;

      private var _currentMapRenderId:int = -1;

      public var _challengesList:Array;

      private var _fightType:uint;

      public var isFightLeader:Boolean;

      public function get priority() : int {
         return Priority.NORMAL;
      }

      public function get entitiesFrame() : FightEntitiesFrame {
         return this._entitiesFrame;
      }

      public function get battleFrame() : FightBattleFrame {
         return this._battleFrame;
      }

      public function get challengesList() : Array {
         return this._challengesList;
      }

      public function get fightType() : uint {
         return this._fightType;
      }

      public function set fightType(t:uint) : void {
         this._fightType=t;
         var partyFrame:PartyManagementFrame = Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
         partyFrame.lastFightType=t;
      }

      public function pushed() : Boolean {
         if(!Kernel.beingInReconection)
         {
            Atouin.getInstance().displayGrid(true,true);
         }
         currentCell=-1;
         timelineOverEntityId=0;
         this._overEffectOk=new GlowFilter(16777215,1,4,4,3,1);
         this._overEffectKo=new GlowFilter(14090240,1,4,4,3,1);
         var matrix:Array = new Array();
         matrix=matrix.concat([0.5,0,0,0,100]);
         matrix=matrix.concat([0,0.5,0,0,100]);
         matrix=matrix.concat([0,0,0.5,0,100]);
         matrix=matrix.concat([0,0,0,1,0]);
         this._linkedEffect=new ColorMatrixFilter(matrix);
         var matrix2:Array = new Array();
         matrix2=matrix2.concat([0.5,0,0,0,0]);
         matrix2=matrix2.concat([0,0.5,0,0,0]);
         matrix2=matrix2.concat([0,0,0.5,0,0]);
         matrix2=matrix2.concat([0,0,0,1,0]);
         this._linkedMainEffect=new ColorMatrixFilter(matrix2);
         this._entitiesFrame=new FightEntitiesFrame();
         this._preparationFrame=new FightPreparationFrame(this);
         this._battleFrame=new FightBattleFrame();
         this._pointCellFrame=new FightPointCellFrame();
         this._challengesList=new Array();
         this._timerFighterInfo=new Timer(100,1);
         this._timerFighterInfo.addEventListener(TimerEvent.TIMER,this.showFighterInfo,false,0,true);
         this._timerMovementRange=new Timer(200,1);
         this._timerMovementRange.addEventListener(TimerEvent.TIMER,this.showMovementRange,false,0,true);
         if(MapDisplayManager.getInstance().getDataMapContainer())
         {
            MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(false);
         }
         return true;
      }

      public function getFighterName(fighterId:int) : String {
         var fighterInfos:GameFightFighterInformations = null;
         var taxInfos:GameFightTaxCollectorInformations = null;
         fighterInfos=this.getFighterInfos(fighterId);
         if(!fighterInfos)
         {
            return "Unknown Fighter";
         }
         switch(true)
         {
            case fighterInfos is GameFightFighterNamedInformations:
               return (fighterInfos as GameFightFighterNamedInformations).name;
            case fighterInfos is GameFightMonsterInformations:
               return Monster.getMonsterById((fighterInfos as GameFightMonsterInformations).creatureGenericId).name;
            case fighterInfos is GameFightTaxCollectorInformations:
               taxInfos=fighterInfos as GameFightTaxCollectorInformations;
               return TaxCollectorFirstname.getTaxCollectorFirstnameById(taxInfos.firstNameId).firstname+" "+TaxCollectorName.getTaxCollectorNameById(taxInfos.lastNameId).name;
            default:
               return "Unknown Fighter Type";
         }
      }

      public function getFighterStatus(fighterId:int) : uint {
         var fighterInfos:GameFightFighterInformations = this.getFighterInfos(fighterId);
         if(!fighterInfos)
         {
            return 1;
         }
         switch(true)
         {
            case fighterInfos is GameFightFighterNamedInformations:
               return (fighterInfos as GameFightFighterNamedInformations).status.statusId;
            default:
               return 1;
         }
      }

      public function getFighterLevel(fighterId:int) : uint {
         var fighterInfos:GameFightFighterInformations = null;
         var monster:Monster = null;
         fighterInfos=this.getFighterInfos(fighterId);
         if(!fighterInfos)
         {
            return 0;
         }
         switch(true)
         {
            case fighterInfos is GameFightMutantInformations:
               return (fighterInfos as GameFightMutantInformations).powerLevel;
            case fighterInfos is GameFightCharacterInformations:
               return (fighterInfos as GameFightCharacterInformations).level;
            case fighterInfos is GameFightMonsterInformations:
               monster=Monster.getMonsterById((fighterInfos as GameFightMonsterInformations).creatureGenericId);
               return monster.getMonsterGrade((fighterInfos as GameFightMonsterInformations).creatureGrade).level;
            case fighterInfos is GameFightTaxCollectorInformations:
               return (fighterInfos as GameFightTaxCollectorInformations).level;
            default:
               return 0;
         }
      }

      public function getChallengeById(challengeId:uint) : ChallengeWrapper {
         var challenge:ChallengeWrapper = null;
         for each (challenge in this._challengesList)
         {
            if(challenge.id==challengeId)
            {
               return challenge;
            }
         }
         return null;
      }

      public function process(msg:Message) : Boolean {
         var gfsmsg:GameFightStartingMessage = null;
         var mcmsg:CurrentMapMessage = null;
         var wp:WorldPointWrapper = null;
         var decryptionKey:ByteArray = null;
         var gcrmsg:GameContextReadyMessage = null;
         var gfrmsg:GameFightResumeMessage = null;
         var cooldownInfos:Vector.<GameFightResumeSlaveInfo> = null;
         var playerCoolDownInfo:GameFightResumeSlaveInfo = null;
         var playedFighterManager:CurrentPlayedFighterManager = null;
         var num:* = 0;
         var castingSpellPool:Array = null;
         var targetPool:Array = null;
         var durationPool:Array = null;
         var castingSpell:CastingSpell = null;
         var gfutmsg:GameFightUpdateTeamMessage = null;
         var gfspmsg:GameFightSpectateMessage = null;
         var castingSpellPools:Array = null;
         var targetPools:Array = null;
         var durationPools:Array = null;
         var castingSpells:CastingSpell = null;
         var gfjmsg:GameFightJoinMessage = null;
         var timeBeforeStart:* = 0;
         var gafccmsg:GameActionFightCarryCharacterMessage = null;
         var coutMsg:CellOutMessage = null;
         var cellEntity2:AnimatedCharacter = null;
         var conmsg:CellOverMessage = null;
         var cellEntity:AnimatedCharacter = null;
         var emovmsg:EntityMouseOverMessage = null;
         var emomsg:EntityMouseOutMessage = null;
         var teoa:TimelineEntityOverAction = null;
         var tpca:TogglePointCellAction = null;
         var gfemsg:GameFightEndMessage = null;
         var ctlra:ChallengeTargetsListRequestAction = null;
         var ctlrmsg:ChallengeTargetsListRequestMessage = null;
         var ctlmsg:ChallengeTargetsListMessage = null;
         var cimsg:ChallengeInfoMessage = null;
         var challenge:ChallengeWrapper = null;
         var ctumsg:ChallengeTargetUpdateMessage = null;
         var crmsg:ChallengeResultMessage = null;
         var moumsg:MapObstacleUpdateMessage = null;
         var gafnscmsg:GameActionFightNoSpellCastMessage = null;
         var canceledApAmout:uint = 0;
         var mirmsg:MapInformationsRequestMessage = null;
         var decryptionKeyString:String = null;
         var gfrwsmsg:GameFightResumeWithSlavesMessage = null;
         var i:* = 0;
         var infos:GameFightResumeSlaveInfo = null;
         var numCoolDown:* = 0;
         var k:* = 0;
         var spellCooldown:GameFightSpellCooldown = null;
         var spellW:SpellWrapper = null;
         var spellLevel:SpellLevel = null;
         var spellCastManager:SpellCastInFightManager = null;
         var interval:* = 0;
         var spellModifs:SpellModificator = null;
         var characteristics:CharacterCharacteristicsInformations = null;
         var spellModification:CharacterSpellModification = null;
         var buff:FightDispellableEffectExtendedInformations = null;
         var buffTmp:BasicBuff = null;
         var mark:GameActionMark = null;
         var spell:Spell = null;
         var cellZone:GameActionMarkedCell = null;
         var step:AddGlyphGfxStep = null;
         var buffS:FightDispellableEffectExtendedInformations = null;
         var buffTmpS:BasicBuff = null;
         var markS:GameActionMark = null;
         var spellS:Spell = null;
         var cellZoneS:GameActionMarkedCell = null;
         var stepS:AddGlyphGfxStep = null;
         var entity2:IEntity = null;
         var entity:IEntity = null;
         var fightEnding:FightEndingMessage = null;
         var results:Vector.<FightResultEntryWrapper> = null;
         var resultIndex:uint = 0;
         var hardcoreLoots:FightResultEntryWrapper = null;
         var winners:Vector.<FightResultEntryWrapper> = null;
         var resultEntry:FightResultListEntry = null;
         var resultsRecap:Object = null;
         var frew:FightResultEntryWrapper = null;
         var currentWinner:uint = 0;
         var loot:ItemWrapper = null;
         var kamas:* = 0;
         var kamasPerWinner:* = 0;
         var winner:FightResultEntryWrapper = null;
         var cell:* = NaN;
         var mo:MapObstacle = null;
         var sl:SpellLevel = null;
         switch(true)
         {
            case msg is MapLoadedMessage:
               MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(false);
               if(PlayedCharacterManager.getInstance().isSpectator)
               {
                  mirmsg=new MapInformationsRequestMessage();
                  mirmsg.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                  ConnectionsHandler.getConnection().send(mirmsg);
               }
               return false;
               break;
            case msg is GameFightStartingMessage:
               gfsmsg=msg as GameFightStartingMessage;
               TooltipManager.hideAll();
               Atouin.getInstance().cancelZoom();
               KernelEventsManager.getInstance().processCallback(HookList.StartZoom,false);
               MapDisplayManager.getInstance().activeIdentifiedElements(false);
               FightEventsHelper.reset();
               KernelEventsManager.getInstance().processCallback(HookList.GameFightStarting,gfsmsg.fightType);
               this.fightType=gfsmsg.fightType;
               CurrentPlayedFighterManager.getInstance().currentFighterId=PlayedCharacterManager.getInstance().id;
               CurrentPlayedFighterManager.getInstance().getSpellCastManager().currentTurn=0;
               SoundManager.getInstance().manager.prepareFightMusic();
               SoundManager.getInstance().manager.playUISound(UISoundEnum.INTRO_FIGHT);
               return true;
               break;
            case msg is CurrentMapMessage:
               mcmsg=msg as CurrentMapMessage;
               ConnectionsHandler.pause();
               Kernel.getWorker().pause();
               if(TacticModeManager.getInstance().tacticModeActivated)
               {
                  TacticModeManager.getInstance().hide();
               }
               wp=new WorldPointWrapper(mcmsg.mapId);
               KernelEventsManager.getInstance().processCallback(HookList.StartZoom,false);
               Atouin.getInstance().initPreDisplay(wp);
               Atouin.getInstance().clearEntities();
               if((mcmsg.mapKey)&&(mcmsg.mapKey.length))
               {
                  decryptionKeyString=XmlConfig.getInstance().getEntry("config.maps.encryptionKey");
                  if(!decryptionKeyString)
                  {
                     decryptionKeyString=mcmsg.mapKey;
                  }
                  decryptionKey=Hex.toArray(Hex.fromString(decryptionKeyString));
               }
               this._currentMapRenderId=Atouin.getInstance().display(wp,decryptionKey);
               _log.info("Ask map render for fight #"+this._currentMapRenderId);
               PlayedCharacterManager.getInstance().currentMap=wp;
               KernelEventsManager.getInstance().processCallback(HookList.CurrentMap,mcmsg.mapId);
               return true;
               break;
            case msg is MapsLoadingCompleteMessage:
               _log.info("MapsLoadingCompleteMessage #"+MapsLoadingCompleteMessage(msg).renderRequestId);
               if(this._currentMapRenderId!=MapsLoadingCompleteMessage(msg).renderRequestId)
               {
                  return false;
               }
               Atouin.getInstance().showWorld(true);
               Atouin.getInstance().displayGrid(true,true);
               Atouin.getInstance().cellOverEnabled=true;
               gcrmsg=new GameContextReadyMessage();
               gcrmsg.initGameContextReadyMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
               ConnectionsHandler.getConnection().send(gcrmsg);
               Kernel.getWorker().resume();
               ConnectionsHandler.resume();
               break;
            case msg is GameFightResumeMessage:
               gfrmsg=msg as GameFightResumeMessage;
               this.tacticModeHandler();
               PlayedCharacterManager.getInstance().currentSummonedCreature=gfrmsg.summonCount;
               this._battleFrame.turnsCount=gfrmsg.gameTurn-1;
               CurrentPlayedFighterManager.getInstance().getSpellCastManager().currentTurn=gfrmsg.gameTurn-1;
               KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated,gfrmsg.gameTurn-1);
               if(msg is GameFightResumeWithSlavesMessage)
               {
                  gfrwsmsg=msg as GameFightResumeWithSlavesMessage;
                  cooldownInfos=gfrwsmsg.slavesInfo;
               }
               else
               {
                  cooldownInfos=new Vector.<GameFightResumeSlaveInfo>();
               }
               playerCoolDownInfo=new GameFightResumeSlaveInfo();
               playerCoolDownInfo.spellCooldowns=gfrmsg.spellCooldowns;
               playerCoolDownInfo.slaveId=PlayedCharacterManager.getInstance().id;
               cooldownInfos.unshift(playerCoolDownInfo);
               playedFighterManager=CurrentPlayedFighterManager.getInstance();
               num=cooldownInfos.length;
               i=0;
               while(i<num)
               {
                  infos=cooldownInfos[i];
                  numCoolDown=infos.spellCooldowns.length;
                  k=0;
                  while(k<numCoolDown)
                  {
                     spellCooldown=infos.spellCooldowns[k];
                     spellW=SpellWrapper.getFirstSpellWrapperById(spellCooldown.spellId,infos.slaveId);
                     if((spellW)&&(spellW.spellLevel<0))
                     {
                        spellLevel=spellW.spell.getSpellLevel(spellW.spellLevel);
                        spellCastManager=playedFighterManager.getSpellCastManagerById(infos.slaveId);
                        spellCastManager.castSpell(spellW.id,spellW.spellLevel,[],false);
                        interval=spellLevel.minCastInterval;
                        if(spellCooldown.cooldown!=63)
                        {
                           spellModifs=new SpellModificator();
                           characteristics=PlayedCharacterManager.getInstance().characteristics;
                           for each (spellModification in characteristics.spellModifications)
                           {
                              if(spellModification.spellId==spellCooldown.spellId)
                              {
                                 switch(spellModification.modificationType)
                                 {
                                    case CharacterSpellModificationTypeEnum.CAST_INTERVAL:
                                       spellModifs.castInterval=spellModification.value;
                                       break;
                                    case CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET:
                                       spellModifs.castIntervalSet=spellModification.value;
                                       break;
                                 }
                              }
                           }
                           if(spellModifs.getTotalBonus(spellModifs.castIntervalSet))
                           {
                              interval=-spellModifs.getTotalBonus(spellModifs.castInterval)+spellModifs.getTotalBonus(spellModifs.castIntervalSet);
                           }
                           else
                           {
                              interval=interval-spellModifs.getTotalBonus(spellModifs.castInterval);
                           }
                        }
                        spellCastManager.getSpellManagerBySpellId(spellW.id).forceLastCastTurn(gfrmsg.gameTurn-1+spellCooldown.cooldown-interval);
                     }
                     k++;
                  }
                  i++;
               }
               castingSpellPool=[];
               for each (buff in gfrmsg.effects)
               {
                  if(!castingSpellPool[buff.effect.targetId])
                  {
                     castingSpellPool[buff.effect.targetId]=[];
                  }
                  targetPool=castingSpellPool[buff.effect.targetId];
                  if(!targetPool[buff.effect.turnDuration])
                  {
                     targetPool[buff.effect.turnDuration]=[];
                  }
                  durationPool=targetPool[buff.effect.turnDuration];
                  castingSpell=durationPool[buff.effect.spellId];
                  if(!castingSpell)
                  {
                     castingSpell=new CastingSpell();
                     castingSpell.casterId=buff.sourceId;
                     castingSpell.spell=Spell.getSpellById(buff.effect.spellId);
                     durationPool[buff.effect.spellId]=castingSpell;
                  }
                  buffTmp=BuffManager.makeBuffFromEffect(buff.effect,castingSpell,buff.actionId);
                  BuffManager.getInstance().addBuff(buffTmp);
               }
               for each (mark in gfrmsg.marks)
               {
                  spell=Spell.getSpellById(mark.markSpellId);
                  MarkedCellsManager.getInstance().addMark(mark.markId,mark.markType,spell,mark.cells);
                  if(spell.getParamByName("glyphGfxId"))
                  {
                     for each (cellZone in mark.cells)
                     {
                        step=new AddGlyphGfxStep(spell.getParamByName("glyphGfxId"),cellZone.cellId,mark.markId,mark.markType);
                        step.start();
                     }
                  }
               }
               Kernel.beingInReconection=false;
               return true;
               break;
            case msg is GameFightUpdateTeamMessage:
               gfutmsg=msg as GameFightUpdateTeamMessage;
               PlayedCharacterManager.getInstance().teamId=gfutmsg.team.teamId;
               return true;
               break;
            case msg is GameFightSpectateMessage:
               gfspmsg=msg as GameFightSpectateMessage;
               this.tacticModeHandler();
               this._battleFrame.turnsCount=gfspmsg.gameTurn-1;
               KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated,gfspmsg.gameTurn-1);
               castingSpellPools=[];
               for each (buffS in gfspmsg.effects)
               {
                  if(!castingSpellPools[buffS.effect.targetId])
                  {
                     castingSpellPools[buffS.effect.targetId]=[];
                  }
                  targetPools=castingSpellPools[buffS.effect.targetId];
                  if(!targetPools[buffS.effect.turnDuration])
                  {
                     targetPools[buffS.effect.turnDuration]=[];
                  }
                  durationPools=targetPools[buffS.effect.turnDuration];
                  castingSpells=durationPools[buffS.effect.spellId];
                  if(!castingSpells)
                  {
                     castingSpells=new CastingSpell();
                     castingSpells.casterId=buffS.sourceId;
                     castingSpells.spell=Spell.getSpellById(buffS.effect.spellId);
                     durationPools[buffS.effect.spellId]=castingSpells;
                  }
                  buffTmpS=BuffManager.makeBuffFromEffect(buffS.effect,castingSpells,buffS.actionId);
                  BuffManager.getInstance().addBuff(buffTmpS,!(buffTmpS is StatBuff));
               }
               for each (markS in gfspmsg.marks)
               {
                  spellS=Spell.getSpellById(markS.markSpellId);
                  MarkedCellsManager.getInstance().addMark(markS.markId,markS.markType,spellS,markS.cells);
                  if(spellS.getParamByName("glyphGfxId"))
                  {
                     for each (cellZoneS in markS.cells)
                     {
                        stepS=new AddGlyphGfxStep(spellS.getParamByName("glyphGfxId"),cellZoneS.cellId,markS.markId,markS.markType);
                        stepS.start();
                     }
                  }
               }
               FightEventsHelper.sendAllFightEvent();
               return true;
         }
         return false;
      }

      public function pulled() : Boolean {
         if(TacticModeManager.getInstance().tacticModeActivated)
         {
            TacticModeManager.getInstance().hide(true);
         }
         if(this._entitiesFrame)
         {
            Kernel.getWorker().removeFrame(this._entitiesFrame);
         }
         if(this._preparationFrame)
         {
            Kernel.getWorker().removeFrame(this._preparationFrame);
         }
         if(this._battleFrame)
         {
            Kernel.getWorker().removeFrame(this._battleFrame);
         }
         if(this._pointCellFrame)
         {
            Kernel.getWorker().removeFrame(this._pointCellFrame);
         }
         SerialSequencer.clearByType(FightSequenceFrame.FIGHT_SEQUENCERS_CATEGORY);
         this._preparationFrame=null;
         this._battleFrame=null;
         this._pointCellFrame=null;
         this._lastEffectEntity=null;
         TooltipManager.hideAll();
         this._timerFighterInfo.reset();
         this._timerFighterInfo.removeEventListener(TimerEvent.TIMER,this.showFighterInfo);
         this._timerFighterInfo=null;
         this._timerMovementRange.reset();
         this._timerMovementRange.removeEventListener(TimerEvent.TIMER,this.showMovementRange);
         this._timerMovementRange=null;
         this._currentFighterInfo=null;
         if(MapDisplayManager.getInstance().getDataMapContainer())
         {
            MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(true);
         }
         Atouin.getInstance().displayGrid(false);
         return true;
      }

      public function outEntity(id:int) : void {
         this._timerFighterInfo.reset();
         this._timerMovementRange.reset();
         var entitiesIdsList:Vector.<int> = this._entitiesFrame.getEntitiesIdsList();
         fighterEntityTooltipId=id;
         var entity:IEntity = DofusEntities.getEntity(fighterEntityTooltipId);
         if(!entity)
         {
            if(entitiesIdsList.indexOf(fighterEntityTooltipId)==-1)
            {
               _log.warn("Mouse over an unknown entity : "+id);
               return;
            }
         }
         if((this._lastEffectEntity)&&(this._lastEffectEntity.object))
         {
            Sprite(this._lastEffectEntity.object).filters=[];
         }
         this._lastEffectEntity=null;
         var ttName:String = "tooltipOverEntity_"+id;
         if(TooltipManager.isVisible(ttName))
         {
            TooltipManager.hide(ttName);
         }
         if(entity!=null)
         {
            Sprite(entity).filters=[];
         }
         this.hideMovementRange();
         var inviSel:Selection = SelectionManager.getInstance().getSelection(this.INVISIBLE_POSITION_SELECTION);
         if(inviSel)
         {
            inviSel.remove();
         }
         this.removeAsLinkEntityEffect();
         if((this._currentFighterInfo)&&(this._currentFighterInfo.contextualId==id))
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate,null);
         }
      }

      private function getFighterInfos(fighterId:int) : GameFightFighterInformations {
         return this.entitiesFrame.getEntityInfos(fighterId) as GameFightFighterInformations;
      }

      private function showFighterInfo(event:TimerEvent) : void {
         this._timerFighterInfo.reset();
         KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate,this._currentFighterInfo);
      }

      private function showMovementRange(event:TimerEvent) : void {
         this._timerMovementRange.reset();
         this._reachableRangeSelection=new Selection();
         this._reachableRangeSelection.renderer=new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
         this._reachableRangeSelection.color=new Color(52326);
         this._unreachableRangeSelection=new Selection();
         this._unreachableRangeSelection.renderer=new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
         this._unreachableRangeSelection.color=new Color(6684672);
         var timer:int = getTimer();
         var reachableCells:FightReachableCellsMaker = new FightReachableCellsMaker(this._currentFighterInfo);
         this._reachableRangeSelection.zone=new Custom(reachableCells.reachableCells);
         this._unreachableRangeSelection.zone=new Custom(reachableCells.unreachableCells);
         SelectionManager.getInstance().addSelection(this._reachableRangeSelection,"movementReachableRange",this._currentFighterInfo.disposition.cellId);
         SelectionManager.getInstance().addSelection(this._unreachableRangeSelection,"movementUnreachableRange",this._currentFighterInfo.disposition.cellId);
      }

      private function hideMovementRange() : void {
         var s:Selection = SelectionManager.getInstance().getSelection("movementReachableRange");
         if(s)
         {
            s.remove();
            this._reachableRangeSelection=null;
         }
         s=SelectionManager.getInstance().getSelection("movementUnreachableRange");
         if(s)
         {
            s.remove();
            this._unreachableRangeSelection=null;
         }
      }

      private function removeAsLinkEntityEffect() : void {
         var entityId:* = 0;
         var entity:DisplayObject = null;
         var index:* = 0;
         loop0:
         for each (entityId in this._entitiesFrame.getEntitiesIdsList())
         {
            entity=DofusEntities.getEntity(entityId) as DisplayObject;
            if((entity)&&(entity.filters)&&(entity.filters.length))
            {
               index=0;
               while(index<entity.filters.length)
               {
                  if(entity.filters[index] is ColorMatrixFilter)
                  {
                     entity.filters=entity.filters.splice(index,index);
                     continue loop0;
                  }
                  index++;
               }
            }
         }
      }

      private function highlightAsLinkedEntity(id:int, isMainEntity:Boolean) : void {
         var filter:ColorMatrixFilter = null;
         var entity:IEntity = DofusEntities.getEntity(id);
         if(!entity)
         {
            return;
         }
         var entitySprite:Sprite = entity as Sprite;
         if((entitySprite)&&(Dofus.getInstance().options.showGlowOverTarget))
         {
            filter=isMainEntity?this._linkedMainEffect:this._linkedEffect;
            if(entitySprite.filters.length)
            {
               if(entitySprite.filters[0]!=filter)
               {
                  entitySprite.filters=[filter];
               }
            }
            else
            {
               entitySprite.filters=[filter];
            }
         }
      }

      private function overEntity(id:int, showRange:Boolean=true) : void {
         var entityId:* = 0;
         var entityInfo:GameFightFighterInformations = null;
         var inviSelection:Selection = null;
         var pos:* = 0;
         var reachableCells:FightReachableCellsMaker = null;
         var fscf:FightSpellCastFrame = null;
         var effect:GlowFilter = null;
         var fightTurnFrame:FightTurnFrame = null;
         var myTurn:* = false;
         var entitiesIdsList:Vector.<int> = this._entitiesFrame.getEntitiesIdsList();
         fighterEntityTooltipId=id;
         var entity:IEntity = DofusEntities.getEntity(fighterEntityTooltipId);
         if(!entity)
         {
            if(entitiesIdsList.indexOf(fighterEntityTooltipId)==-1)
            {
               _log.warn("Mouse over an unknown entity : "+id);
               return;
            }
            showRange=false;
         }
         var infos:GameFightFighterInformations = this._entitiesFrame.getEntityInfos(id) as GameFightFighterInformations;
         if(!infos)
         {
            _log.warn("Mouse over an unknown entity : "+id);
            return;
         }
         var summonerId:int = infos.stats.summoner;
         for each (entityId in entitiesIdsList)
         {
            if(entityId!=id)
            {
               entityInfo=this._entitiesFrame.getEntityInfos(entityId) as GameFightFighterInformations;
               if((entityInfo.stats.summoner==id)||(summonerId==entityId)||(entityInfo.stats.summoner==summonerId)&&(summonerId))
               {
                  this.highlightAsLinkedEntity(entityId,summonerId==entityId);
               }
            }
         }
         this._currentFighterInfo=infos;
         if(Dofus.getInstance().options.showEntityInfos)
         {
            this._timerFighterInfo.reset();
            this._timerFighterInfo.start();
         }
         if(infos.stats.invisibilityState==GameActionFightInvisibilityStateEnum.INVISIBLE)
         {
            _log.warn("Mouse over an invisible entity.");
            inviSelection=SelectionManager.getInstance().getSelection(this.INVISIBLE_POSITION_SELECTION);
            if(!inviSelection)
            {
               inviSelection=new Selection();
               inviSelection.color=new Color(52326);
               inviSelection.renderer=new ZoneDARenderer();
               SelectionManager.getInstance().addSelection(inviSelection,this.INVISIBLE_POSITION_SELECTION);
            }
            pos=FightEntitiesFrame.getCurrentInstance().getLastKnownEntityPosition(infos.contextualId);
            if(pos>-1)
            {
               reachableCells=new FightReachableCellsMaker(this._currentFighterInfo,pos,FightEntitiesFrame.getCurrentInstance().getLastKnownEntityMovementPoint(infos.contextualId));
               inviSelection.zone=new Custom(reachableCells.reachableCells);
               SelectionManager.getInstance().update(this.INVISIBLE_POSITION_SELECTION,pos);
            }
            return;
         }
         if((infos is GameFightCharacterInformations)&&(!(entity==null)))
         {
            TooltipManager.show(infos,(entity as IDisplayable).absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"tooltipOverEntity_"+infos.contextualId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,null,null,null,"PlayerShortInfos");
         }
         else
         {
            if(entity!=null)
            {
               TooltipManager.show(infos,(entity as IDisplayable).absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"tooltipOverEntity_"+infos.contextualId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,"monsterFighter",null,null,"EntityShortInfos");
            }
         }
         var movementSelection:Selection = SelectionManager.getInstance().getSelection(FightTurnFrame.SELECTION_PATH);
         if(movementSelection)
         {
            movementSelection.remove();
         }
         if(showRange)
         {
            if((Dofus.getInstance().options.showMovementRange)&&(Kernel.getWorker().contains(FightBattleFrame))&&(!Kernel.getWorker().contains(FightSpellCastFrame)))
            {
               this._timerMovementRange.reset();
               this._timerMovementRange.start();
            }
         }
         if((this._lastEffectEntity)&&(this._lastEffectEntity.object is Sprite)&&(!(this._lastEffectEntity.object==entity)))
         {
            Sprite(this._lastEffectEntity.object).filters=[];
         }
         var entitySprite:Sprite = entity as Sprite;
         if((entitySprite)&&(Dofus.getInstance().options.showGlowOverTarget))
         {
            fscf=Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
            fightTurnFrame=Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
            myTurn=fightTurnFrame?fightTurnFrame.myTurn:true;
            if(((!fscf)||((fscf)&&(fscf.currentTargetIsTargetable)))&&(myTurn))
            {
               effect=this._overEffectOk;
            }
            else
            {
               effect=this._overEffectKo;
            }
            if(entitySprite.filters.length)
            {
               if(entitySprite.filters[0]!=effect)
               {
                  entitySprite.filters=[effect];
               }
            }
            else
            {
               entitySprite.filters=[effect];
            }
            this._lastEffectEntity=new WeakReference(entity);
         }
      }

      private function tacticModeHandler(forceOpen:Boolean=false) : void {
         if((forceOpen)&&(!TacticModeManager.getInstance().tacticModeActivated))
         {
            TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap);
         }
         else
         {
            if(TacticModeManager.getInstance().tacticModeActivated)
            {
               TacticModeManager.getInstance().hide();
            }
         }
      }
   }

}