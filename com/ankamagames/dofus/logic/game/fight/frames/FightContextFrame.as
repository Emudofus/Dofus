package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.filters.GlowFilter;
   import flash.filters.ColorMatrixFilter;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import flash.utils.Timer;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
   import com.ankamagames.atouin.Atouin;
   import flash.events.TimerEvent;
   import com.ankamagames.dofus.logic.game.roleplay.frames.MonstersInfoFrame;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.atouin.managers.*;
   import com.ankamagames.atouin.renderers.*;
   import com.ankamagames.atouin.types.*;
   import com.ankamagames.jerakine.entities.interfaces.*;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.event.UiUnloadEvent;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCompanionInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterNamedInformations;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.I18n;
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
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightResumeSlaveInfo;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
   import com.ankamagames.dofus.network.types.game.action.fight.FightDispellableEffectExtendedInformations;
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
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOutAction;
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
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMark;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMarkedCell;
   import com.ankamagames.dofus.types.sequences.AddGlyphGfxStep;
   import com.ankamagames.dofus.logic.game.common.messages.FightEndingMessage;
   import com.ankamagames.dofus.internalDatacenter.fight.FightResultEntryWrapper;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultListEntry;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
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
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultPlayerListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultTaxCollectorListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultFighterListEntry;
   import com.ankamagames.dofus.network.enums.FightOutcomeEnum;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowCellManager;
   import com.ankamagames.dofus.network.enums.MapObstacleStateEnum;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.atouin.messages.MapLoadedMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightStartMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowTacticModeAction;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import flash.display.Sprite;
   import com.ankamagames.dofus.logic.game.fight.miscs.PushUtil;
   import com.ankamagames.berilia.types.tooltip.TooltipPlacer;
   import com.ankamagames.dofus.logic.game.fight.types.SpellDamageInfo;
   import com.ankamagames.dofus.logic.game.fight.types.SpellDamage;
   import com.ankamagames.dofus.logic.game.fight.types.EffectDamage;
   import com.ankamagames.jerakine.types.zones.IZone;
   import com.ankamagames.dofus.logic.game.fight.types.PushedEntity;
   import com.ankamagames.dofus.logic.game.fight.types.TriggeredSpell;
   import com.ankamagames.dofus.logic.game.fight.types.SplashDamage;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
   import com.ankamagames.dofus.logic.game.fight.miscs.DamageUtil;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.jerakine.types.Color;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.logic.game.fight.miscs.FightReachableCellsMaker;
   import com.ankamagames.jerakine.types.zones.Custom;
   import flash.display.DisplayObject;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   
   public class FightContextFrame extends Object implements Frame
   {
      
      public function FightContextFrame() {
         this._spellTargetsTooltips = new Dictionary();
         this._spellDamages = new Dictionary();
         super();
      }
      
      protected static const _log:Logger;
      
      public static var preFightIsActive:Boolean = true;
      
      public static var fighterEntityTooltipId:int;
      
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
      
      private var _timelineOverEntity:Boolean;
      
      private var _timelineOverEntityId:int;
      
      private var _showPermanentTooltips:Boolean;
      
      private var _hideTooltipTimer:Timer;
      
      private var _hideTooltipEntityId:int;
      
      private var _hideTooltipsTimer:Timer;
      
      private var _hideTooltips:Boolean;
      
      public var _challengesList:Array;
      
      private var _fightType:uint;
      
      private var _fightAttackerId:uint;
      
      private var _spellTargetsTooltips:Dictionary;
      
      private var _spellDamages:Dictionary;
      
      private var _spellAlreadyTriggered:Boolean;
      
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
         this._fightType = t;
         var partyFrame:PartyManagementFrame = Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
         partyFrame.lastFightType = t;
      }
      
      public function get timelineOverEntity() : Boolean {
         return this._timelineOverEntity;
      }
      
      public function get timelineOverEntityId() : int {
         return this._timelineOverEntityId;
      }
      
      public function get showPermanentTooltips() : Boolean {
         return this._showPermanentTooltips;
      }
      
      public function pushed() : Boolean {
         if(!Kernel.beingInReconection)
         {
            Atouin.getInstance().displayGrid(true,true);
         }
         currentCell = -1;
         this._overEffectOk = new GlowFilter(16777215,1,4,4,3,1);
         this._overEffectKo = new GlowFilter(14090240,1,4,4,3,1);
         var matrix:Array = new Array();
         matrix = matrix.concat([0.5,0,0,0,100]);
         matrix = matrix.concat([0,0.5,0,0,100]);
         matrix = matrix.concat([0,0,0.5,0,100]);
         matrix = matrix.concat([0,0,0,1,0]);
         this._linkedEffect = new ColorMatrixFilter(matrix);
         var matrix2:Array = new Array();
         matrix2 = matrix2.concat([0.5,0,0,0,0]);
         matrix2 = matrix2.concat([0,0.5,0,0,0]);
         matrix2 = matrix2.concat([0,0,0.5,0,0]);
         matrix2 = matrix2.concat([0,0,0,1,0]);
         this._linkedMainEffect = new ColorMatrixFilter(matrix2);
         this._entitiesFrame = new FightEntitiesFrame();
         this._preparationFrame = new FightPreparationFrame(this);
         this._battleFrame = new FightBattleFrame();
         this._pointCellFrame = new FightPointCellFrame();
         this._challengesList = new Array();
         this._timerFighterInfo = new Timer(100,1);
         this._timerFighterInfo.addEventListener(TimerEvent.TIMER,this.showFighterInfo,false,0,true);
         this._timerMovementRange = new Timer(200,1);
         this._timerMovementRange.addEventListener(TimerEvent.TIMER,this.showMovementRange,false,0,true);
         if(MapDisplayManager.getInstance().getDataMapContainer())
         {
            MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(false);
         }
         if(Kernel.getWorker().contains(MonstersInfoFrame))
         {
            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(MonstersInfoFrame) as MonstersInfoFrame);
         }
         this._showPermanentTooltips = OptionManager.getOptionManager("dofus")["showPermanentTargetsTooltips"];
         OptionManager.getOptionManager("dofus").addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE,this.onUiUnloaded);
         return true;
      }
      
      private function onUiUnloaded(pEvent:UiUnloadEvent) : void {
         var entityId:* = 0;
         if((this._showPermanentTooltips) && (this.battleFrame))
         {
            for each(entityId in this.battleFrame.targetedEntities)
            {
               this.displayEntityTooltip(entityId);
            }
         }
      }
      
      public function getFighterName(fighterId:int) : String {
         var fighterInfos:GameFightFighterInformations = null;
         var compInfos:GameFightCompanionInformations = null;
         var name:String = null;
         var genericName:String = null;
         var taxInfos:GameFightTaxCollectorInformations = null;
         var masterName:String = null;
         fighterInfos = this.getFighterInfos(fighterId);
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
            case fighterInfos is GameFightCompanionInformations:
               compInfos = fighterInfos as GameFightCompanionInformations;
               genericName = Companion.getCompanionById(compInfos.companionGenericId).name;
               if(compInfos.masterId != PlayedCharacterManager.getInstance().id)
               {
                  masterName = this.getFighterName(compInfos.masterId);
                  name = I18n.getUiText("ui.common.belonging",[genericName,masterName]);
               }
               else
               {
                  name = genericName;
               }
               return name;
            case fighterInfos is GameFightTaxCollectorInformations:
               taxInfos = fighterInfos as GameFightTaxCollectorInformations;
               return TaxCollectorFirstname.getTaxCollectorFirstnameById(taxInfos.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(taxInfos.lastNameId).name;
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
         fighterInfos = this.getFighterInfos(fighterId);
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
            case fighterInfos is GameFightCompanionInformations:
               return (fighterInfos as GameFightCompanionInformations).level;
            case fighterInfos is GameFightMonsterInformations:
               monster = Monster.getMonsterById((fighterInfos as GameFightMonsterInformations).creatureGenericId);
               return monster.getMonsterGrade((fighterInfos as GameFightMonsterInformations).creatureGrade).level;
            case fighterInfos is GameFightTaxCollectorInformations:
               return (fighterInfos as GameFightTaxCollectorInformations).level;
            default:
               return 0;
         }
      }
      
      public function getChallengeById(challengeId:uint) : ChallengeWrapper {
         var challenge:ChallengeWrapper = null;
         for each(challenge in this._challengesList)
         {
            if(challenge.id == challengeId)
            {
               return challenge;
            }
         }
         return null;
      }
      
      public function process(msg:Message) : Boolean {
         var ttEntityId:* = undefined;
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
         var i:* = 0;
         var numEffects:uint = 0;
         var buff:FightDispellableEffectExtendedInformations = null;
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
         var fscf:FightSpellCastFrame = null;
         var tleoutaction:TimelineEntityOutAction = null;
         var entityId:* = 0;
         var entities:Vector.<int> = null;
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
         var infos:GameFightResumeSlaveInfo = null;
         var spellCastManager:SpellCastInFightManager = null;
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
         var temp:Array = null;
         var resultEntryTemp:FightResultListEntry = null;
         var resultsRecap:Object = null;
         var frew:FightResultEntryWrapper = null;
         var id:* = 0;
         var resultEntry:FightResultListEntry = null;
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
                  mirmsg = new MapInformationsRequestMessage();
                  mirmsg.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                  ConnectionsHandler.getConnection().send(mirmsg);
               }
               return true;
            case msg is GameFightStartingMessage:
               gfsmsg = msg as GameFightStartingMessage;
               TooltipManager.hideAll();
               Atouin.getInstance().cancelZoom();
               KernelEventsManager.getInstance().processCallback(HookList.StartZoom,false);
               MapDisplayManager.getInstance().activeIdentifiedElements(false);
               FightEventsHelper.reset();
               KernelEventsManager.getInstance().processCallback(HookList.GameFightStarting,gfsmsg.fightType);
               this.fightType = gfsmsg.fightType;
               this._fightAttackerId = gfsmsg.attackerId;
               CurrentPlayedFighterManager.getInstance().currentFighterId = PlayedCharacterManager.getInstance().id;
               CurrentPlayedFighterManager.getInstance().getSpellCastManager().currentTurn = 0;
               SoundManager.getInstance().manager.prepareFightMusic();
               SoundManager.getInstance().manager.playUISound(UISoundEnum.INTRO_FIGHT);
               return true;
            case msg is CurrentMapMessage:
               mcmsg = msg as CurrentMapMessage;
               ConnectionsHandler.pause();
               Kernel.getWorker().pause();
               if(TacticModeManager.getInstance().tacticModeActivated)
               {
                  TacticModeManager.getInstance().hide();
               }
               wp = new WorldPointWrapper(mcmsg.mapId);
               KernelEventsManager.getInstance().processCallback(HookList.StartZoom,false);
               Atouin.getInstance().initPreDisplay(wp);
               Atouin.getInstance().clearEntities();
               if((mcmsg.mapKey) && (mcmsg.mapKey.length))
               {
                  decryptionKeyString = XmlConfig.getInstance().getEntry("config.maps.encryptionKey");
                  if(!decryptionKeyString)
                  {
                     decryptionKeyString = mcmsg.mapKey;
                  }
                  decryptionKey = Hex.toArray(Hex.fromString(decryptionKeyString));
               }
               this._currentMapRenderId = Atouin.getInstance().display(wp,decryptionKey);
               _log.info("Ask map render for fight #" + this._currentMapRenderId);
               PlayedCharacterManager.getInstance().currentMap = wp;
               KernelEventsManager.getInstance().processCallback(HookList.CurrentMap,mcmsg.mapId);
               return true;
            case msg is MapsLoadingCompleteMessage:
               _log.info("MapsLoadingCompleteMessage #" + MapsLoadingCompleteMessage(msg).renderRequestId);
               if(this._currentMapRenderId != MapsLoadingCompleteMessage(msg).renderRequestId)
               {
                  return false;
               }
               Atouin.getInstance().showWorld(true);
               Atouin.getInstance().displayGrid(true,true);
               Atouin.getInstance().cellOverEnabled = true;
               gcrmsg = new GameContextReadyMessage();
               gcrmsg.initGameContextReadyMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
               ConnectionsHandler.getConnection().send(gcrmsg);
               Kernel.getWorker().resume();
               ConnectionsHandler.resume();
               return true;
            case msg is GameFightResumeMessage:
               gfrmsg = msg as GameFightResumeMessage;
               this.tacticModeHandler();
               PlayedCharacterManager.getInstance().currentSummonedCreature = gfrmsg.summonCount;
               this._battleFrame.turnsCount = gfrmsg.gameTurn - 1;
               KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated,gfrmsg.gameTurn - 1);
               if(msg is GameFightResumeWithSlavesMessage)
               {
                  gfrwsmsg = msg as GameFightResumeWithSlavesMessage;
                  cooldownInfos = gfrwsmsg.slavesInfo;
               }
               else
               {
                  cooldownInfos = new Vector.<GameFightResumeSlaveInfo>();
               }
               playerCoolDownInfo = new GameFightResumeSlaveInfo();
               playerCoolDownInfo.spellCooldowns = gfrmsg.spellCooldowns;
               playerCoolDownInfo.slaveId = PlayedCharacterManager.getInstance().id;
               cooldownInfos.unshift(playerCoolDownInfo);
               playedFighterManager = CurrentPlayedFighterManager.getInstance();
               num = cooldownInfos.length;
               i = 0;
               while(i < num)
               {
                  infos = cooldownInfos[i];
                  spellCastManager = playedFighterManager.getSpellCastManagerById(infos.slaveId);
                  spellCastManager.currentTurn = gfrmsg.gameTurn - 1;
                  spellCastManager.updateCooldowns(cooldownInfos[i].spellCooldowns);
                  i++;
               }
               castingSpellPool = [];
               numEffects = gfrmsg.effects.length;
               i = 0;
               while(i < numEffects)
               {
                  buff = gfrmsg.effects[i];
                  if(!castingSpellPool[buff.effect.targetId])
                  {
                     castingSpellPool[buff.effect.targetId] = [];
                  }
                  targetPool = castingSpellPool[buff.effect.targetId];
                  if(!targetPool[buff.effect.turnDuration])
                  {
                     targetPool[buff.effect.turnDuration] = [];
                  }
                  durationPool = targetPool[buff.effect.turnDuration];
                  castingSpell = durationPool[buff.effect.spellId];
                  if(!castingSpell)
                  {
                     castingSpell = new CastingSpell();
                     castingSpell.casterId = buff.sourceId;
                     castingSpell.spell = Spell.getSpellById(buff.effect.spellId);
                     durationPool[buff.effect.spellId] = castingSpell;
                  }
                  buffTmp = BuffManager.makeBuffFromEffect(buff.effect,castingSpell,buff.actionId);
                  BuffManager.getInstance().addBuff(buffTmp);
                  i++;
               }
               for each(mark in gfrmsg.marks)
               {
                  spell = Spell.getSpellById(mark.markSpellId);
                  MarkedCellsManager.getInstance().addMark(mark.markId,mark.markType,spell,mark.cells);
                  if(spell.getParamByName("glyphGfxId"))
                  {
                     for each(cellZone in mark.cells)
                     {
                        step = new AddGlyphGfxStep(spell.getParamByName("glyphGfxId"),cellZone.cellId,mark.markId,mark.markType);
                        step.start();
                     }
                  }
               }
               Kernel.beingInReconection = false;
               return true;
            case msg is GameFightUpdateTeamMessage:
               gfutmsg = msg as GameFightUpdateTeamMessage;
               PlayedCharacterManager.getInstance().teamId = gfutmsg.team.teamId;
               return true;
            case msg is GameFightSpectateMessage:
               gfspmsg = msg as GameFightSpectateMessage;
               this.tacticModeHandler();
               this._battleFrame.turnsCount = gfspmsg.gameTurn - 1;
               KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated,gfspmsg.gameTurn - 1);
               castingSpellPools = [];
               for each(buffS in gfspmsg.effects)
               {
                  if(!castingSpellPools[buffS.effect.targetId])
                  {
                     castingSpellPools[buffS.effect.targetId] = [];
                  }
                  targetPools = castingSpellPools[buffS.effect.targetId];
                  if(!targetPools[buffS.effect.turnDuration])
                  {
                     targetPools[buffS.effect.turnDuration] = [];
                  }
                  durationPools = targetPools[buffS.effect.turnDuration];
                  castingSpells = durationPools[buffS.effect.spellId];
                  if(!castingSpells)
                  {
                     castingSpells = new CastingSpell();
                     castingSpells.casterId = buffS.sourceId;
                     castingSpells.spell = Spell.getSpellById(buffS.effect.spellId);
                     durationPools[buffS.effect.spellId] = castingSpells;
                  }
                  buffTmpS = BuffManager.makeBuffFromEffect(buffS.effect,castingSpells,buffS.actionId);
                  BuffManager.getInstance().addBuff(buffTmpS,!(buffTmpS is StatBuff));
               }
               for each(markS in gfspmsg.marks)
               {
                  spellS = Spell.getSpellById(markS.markSpellId);
                  MarkedCellsManager.getInstance().addMark(markS.markId,markS.markType,spellS,markS.cells);
                  if(spellS.getParamByName("glyphGfxId"))
                  {
                     for each(cellZoneS in markS.cells)
                     {
                        stepS = new AddGlyphGfxStep(spellS.getParamByName("glyphGfxId"),cellZoneS.cellId,markS.markId,markS.markType);
                        stepS.start();
                     }
                  }
               }
               FightEventsHelper.sendAllFightEvent();
               return true;
         }
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
         this._preparationFrame = null;
         this._battleFrame = null;
         this._pointCellFrame = null;
         this._lastEffectEntity = null;
         TooltipManager.hideAll();
         this._timerFighterInfo.reset();
         this._timerFighterInfo.removeEventListener(TimerEvent.TIMER,this.showFighterInfo);
         this._timerFighterInfo = null;
         this._timerMovementRange.reset();
         this._timerMovementRange.removeEventListener(TimerEvent.TIMER,this.showMovementRange);
         this._timerMovementRange = null;
         this._currentFighterInfo = null;
         if(MapDisplayManager.getInstance().getDataMapContainer())
         {
            MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(true);
         }
         Atouin.getInstance().displayGrid(false);
         OptionManager.getOptionManager("dofus").removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         Berilia.getInstance().removeEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE,this.onUiUnloaded);
         if(this._hideTooltipsTimer)
         {
            this._hideTooltipsTimer.removeEventListener(TimerEvent.TIMER,this.onShowPermanentTooltips);
            this._hideTooltipsTimer.stop();
         }
         if(this._hideTooltipTimer)
         {
            this._hideTooltipTimer.removeEventListener(TimerEvent.TIMER,this.onShowTooltip);
            this._hideTooltipTimer.stop();
         }
         var simf:SpellInventoryManagementFrame = Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame;
         simf.deleteSpellsGlobalCoolDownsData();
         return true;
      }
      
      public function outEntity(id:int) : void {
         var entityId:* = 0;
         this._timerFighterInfo.reset();
         this._timerMovementRange.reset();
         var entitiesIdsList:Vector.<int> = this._entitiesFrame.getEntitiesIdsList();
         fighterEntityTooltipId = id;
         var entity:IEntity = DofusEntities.getEntity(fighterEntityTooltipId);
         if(!entity)
         {
            if(entitiesIdsList.indexOf(fighterEntityTooltipId) == -1)
            {
               _log.warn("Mouse over an unknown entity : " + id);
               return;
            }
         }
         if((this._lastEffectEntity) && (this._lastEffectEntity.object))
         {
            Sprite(this._lastEffectEntity.object).filters = [];
         }
         this._lastEffectEntity = null;
         var ttName:String = "tooltipOverEntity_" + id;
         if(((!this._showPermanentTooltips) || (this._showPermanentTooltips) && (this.battleFrame.targetedEntities.indexOf(id) == -1)) && (TooltipManager.isVisible(ttName)))
         {
            TooltipManager.hide(ttName);
         }
         if(this._showPermanentTooltips)
         {
            for each(entityId in this.battleFrame.targetedEntities)
            {
               this.displayEntityTooltip(entityId);
            }
         }
         if(entity != null)
         {
            Sprite(entity).filters = [];
         }
         this.hideMovementRange();
         var inviSel:Selection = SelectionManager.getInstance().getSelection(this.INVISIBLE_POSITION_SELECTION);
         if(inviSel)
         {
            inviSel.remove();
         }
         this.removeAsLinkEntityEffect();
         if((this._currentFighterInfo) && (this._currentFighterInfo.contextualId == id))
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate,null);
         }
      }
      
      public function removeSpellTargetsTooltips() : void {
         var ttEntityId:* = undefined;
         PushUtil.reset();
         this._spellAlreadyTriggered = false;
         for(ttEntityId in this._spellTargetsTooltips)
         {
            TooltipPlacer.removeTooltipPositionByName("tooltip_tooltipOverEntity_" + ttEntityId);
            delete this._spellTargetsTooltips[ttEntityId];
            TooltipManager.hide("tooltipOverEntity_" + ttEntityId);
            delete this._spellDamages[ttEntityId];
            if((this._showPermanentTooltips) && (!(this._battleFrame.targetedEntities.indexOf(ttEntityId) == -1)))
            {
               this.displayEntityTooltip(ttEntityId);
            }
         }
      }
      
      public function displayEntityTooltip(pEntityId:int, pSpell:Object = null, pSpellInfo:SpellDamageInfo = null, pForceRefresh:Boolean = false, pSpellImpactCell:int = -1) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function hideEntityTooltip(pEntityId:int, pDelay:uint) : void {
         if((!((this._showPermanentTooltips) && (!(this._battleFrame.targetedEntities.indexOf(pEntityId) == -1)))) && (TooltipManager.isVisible("tooltipOverEntity_" + pEntityId)))
         {
            TooltipManager.hide("tooltipOverEntity_" + pEntityId);
            this._hideTooltipEntityId = pEntityId;
            if(!this._hideTooltipTimer)
            {
               this._hideTooltipTimer = new Timer(pDelay);
            }
            this._hideTooltipTimer.stop();
            this._hideTooltipTimer.delay = pDelay;
            this._hideTooltipTimer.removeEventListener(TimerEvent.TIMER,this.onShowTooltip);
            this._hideTooltipTimer.addEventListener(TimerEvent.TIMER,this.onShowTooltip);
            this._hideTooltipTimer.start();
         }
      }
      
      public function hidePermanentTooltips(pDelay:uint) : void {
         var entityId:* = 0;
         this._hideTooltips = true;
         if(this._battleFrame.targetedEntities.length > 0)
         {
            for each(entityId in this._battleFrame.targetedEntities)
            {
               TooltipManager.hide("tooltipOverEntity_" + entityId);
            }
            if(!this._hideTooltipsTimer)
            {
               this._hideTooltipsTimer = new Timer(pDelay);
            }
            this._hideTooltipsTimer.stop();
            this._hideTooltipsTimer.delay = pDelay;
            this._hideTooltipsTimer.removeEventListener(TimerEvent.TIMER,this.onShowPermanentTooltips);
            this._hideTooltipsTimer.addEventListener(TimerEvent.TIMER,this.onShowPermanentTooltips);
            this._hideTooltipsTimer.start();
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
         this._reachableRangeSelection = new Selection();
         this._reachableRangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
         this._reachableRangeSelection.color = new Color(52326);
         this._unreachableRangeSelection = new Selection();
         this._unreachableRangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
         this._unreachableRangeSelection.color = new Color(6684672);
         var timer:int = getTimer();
         var reachableCells:FightReachableCellsMaker = new FightReachableCellsMaker(this._currentFighterInfo);
         this._reachableRangeSelection.zone = new Custom(reachableCells.reachableCells);
         this._unreachableRangeSelection.zone = new Custom(reachableCells.unreachableCells);
         SelectionManager.getInstance().addSelection(this._reachableRangeSelection,"movementReachableRange",this._currentFighterInfo.disposition.cellId);
         SelectionManager.getInstance().addSelection(this._unreachableRangeSelection,"movementUnreachableRange",this._currentFighterInfo.disposition.cellId);
      }
      
      private function hideMovementRange() : void {
         var s:Selection = SelectionManager.getInstance().getSelection("movementReachableRange");
         if(s)
         {
            s.remove();
            this._reachableRangeSelection = null;
         }
         s = SelectionManager.getInstance().getSelection("movementUnreachableRange");
         if(s)
         {
            s.remove();
            this._unreachableRangeSelection = null;
         }
      }
      
      private function removeAsLinkEntityEffect() : void {
         var entityId:* = 0;
         var entity:DisplayObject = null;
         var index:* = 0;
         loop0:
         for each(entityId in this._entitiesFrame.getEntitiesIdsList())
         {
            entity = DofusEntities.getEntity(entityId) as DisplayObject;
            if((entity) && (entity.filters) && (entity.filters.length))
            {
               index = 0;
               while(index < entity.filters.length)
               {
                  if(entity.filters[index] is ColorMatrixFilter)
                  {
                     entity.filters = entity.filters.splice(index,index);
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
         if((entitySprite) && (Dofus.getInstance().options.showGlowOverTarget))
         {
            filter = isMainEntity?this._linkedMainEffect:this._linkedEffect;
            if(entitySprite.filters.length)
            {
               if(entitySprite.filters[0] != filter)
               {
                  entitySprite.filters = [filter];
               }
            }
            else
            {
               entitySprite.filters = [filter];
            }
         }
      }
      
      private function overEntity(id:int, showRange:Boolean = true) : void {
         var entityId:* = 0;
         var entityInfo:GameFightFighterInformations = null;
         var inviSelection:Selection = null;
         var pos:* = 0;
         var lastMovPoint:* = 0;
         var reachableCells:FightReachableCellsMaker = null;
         var effect:GlowFilter = null;
         var fightTurnFrame:FightTurnFrame = null;
         var myTurn:* = false;
         var entitiesIdsList:Vector.<int> = this._entitiesFrame.getEntitiesIdsList();
         fighterEntityTooltipId = id;
         var entity:IEntity = DofusEntities.getEntity(fighterEntityTooltipId);
         if(!entity)
         {
            if(entitiesIdsList.indexOf(fighterEntityTooltipId) == -1)
            {
               _log.warn("Mouse over an unknown entity : " + id);
               return;
            }
            showRange = false;
         }
         var infos:GameFightFighterInformations = this._entitiesFrame.getEntityInfos(id) as GameFightFighterInformations;
         if(!infos)
         {
            _log.warn("Mouse over an unknown entity : " + id);
            return;
         }
         var summonerId:int = infos.stats.summoner;
         if(infos is GameFightCompanionInformations)
         {
            summonerId = (infos as GameFightCompanionInformations).masterId;
         }
         for each(entityId in entitiesIdsList)
         {
            if(entityId != id)
            {
               entityInfo = this._entitiesFrame.getEntityInfos(entityId) as GameFightFighterInformations;
               if((entityInfo.stats.summoner == id || summonerId == entityId) || (entityInfo.stats.summoner == summonerId && summonerId) || (entityInfo is GameFightCompanionInformations) && ((entityInfo as GameFightCompanionInformations).masterId == id))
               {
                  this.highlightAsLinkedEntity(entityId,summonerId == entityId);
               }
            }
         }
         this._currentFighterInfo = infos;
         if(Dofus.getInstance().options.showEntityInfos)
         {
            this._timerFighterInfo.reset();
            this._timerFighterInfo.start();
         }
         if(infos.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE)
         {
            _log.warn("Mouse over an invisible entity.");
            inviSelection = SelectionManager.getInstance().getSelection(this.INVISIBLE_POSITION_SELECTION);
            if(!inviSelection)
            {
               inviSelection = new Selection();
               inviSelection.color = new Color(52326);
               inviSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
               SelectionManager.getInstance().addSelection(inviSelection,this.INVISIBLE_POSITION_SELECTION);
            }
            pos = FightEntitiesFrame.getCurrentInstance().getLastKnownEntityPosition(infos.contextualId);
            if(pos > -1)
            {
               lastMovPoint = FightEntitiesFrame.getCurrentInstance().getLastKnownEntityMovementPoint(infos.contextualId);
               reachableCells = new FightReachableCellsMaker(this._currentFighterInfo,pos,lastMovPoint);
               inviSelection.zone = new Custom(reachableCells.reachableCells);
               SelectionManager.getInstance().update(this.INVISIBLE_POSITION_SELECTION,pos);
            }
            return;
         }
         var fscf:FightSpellCastFrame = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
         var spell:Object = null;
         if((fscf) && ((SelectionManager.getInstance().isInside(currentCell,"SpellCastTarget")) || (this._spellTargetsTooltips[id])))
         {
            spell = fscf.currentSpell;
         }
         this.displayEntityTooltip(id,spell);
         var movementSelection:Selection = SelectionManager.getInstance().getSelection(FightTurnFrame.SELECTION_PATH);
         if(movementSelection)
         {
            movementSelection.remove();
         }
         if(showRange)
         {
            if((Dofus.getInstance().options.showMovementRange) && (Kernel.getWorker().contains(FightBattleFrame)) && (!Kernel.getWorker().contains(FightSpellCastFrame)))
            {
               this._timerMovementRange.reset();
               this._timerMovementRange.start();
            }
         }
         if((this._lastEffectEntity) && (this._lastEffectEntity.object is Sprite) && (!(this._lastEffectEntity.object == entity)))
         {
            Sprite(this._lastEffectEntity.object).filters = [];
         }
         var entitySprite:Sprite = entity as Sprite;
         if((entitySprite) && (Dofus.getInstance().options.showGlowOverTarget))
         {
            fightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
            myTurn = fightTurnFrame?fightTurnFrame.myTurn:true;
            if(((!fscf) || (FightSpellCastFrame.isCurrentTargetTargetable())) && (myTurn))
            {
               effect = this._overEffectOk;
            }
            else
            {
               effect = this._overEffectKo;
            }
            if(entitySprite.filters.length)
            {
               if(entitySprite.filters[0] != effect)
               {
                  entitySprite.filters = [effect];
               }
            }
            else
            {
               entitySprite.filters = [effect];
            }
            this._lastEffectEntity = new WeakReference(entity);
         }
      }
      
      private function tacticModeHandler(forceOpen:Boolean = false) : void {
         if((forceOpen) && (!TacticModeManager.getInstance().tacticModeActivated))
         {
            TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap);
         }
         else if(TacticModeManager.getInstance().tacticModeActivated)
         {
            TacticModeManager.getInstance().hide();
         }
         
      }
      
      private function onPropertyChanged(pEvent:PropertyChangeEvent) : void {
         var entityId:* = 0;
         switch(pEvent.propertyName)
         {
            case "showPermanentTargetsTooltips":
               this._showPermanentTooltips = pEvent.propertyValue as Boolean;
               for each(entityId in this._battleFrame.targetedEntities)
               {
                  if(!this._showPermanentTooltips)
                  {
                     TooltipManager.hide("tooltipOverEntity_" + entityId);
                  }
                  else
                  {
                     this.displayEntityTooltip(entityId);
                  }
               }
               break;
         }
      }
      
      private function onShowPermanentTooltips(pEvent:TimerEvent) : void {
         var entityId:* = 0;
         this._hideTooltips = false;
         this._hideTooltipsTimer.removeEventListener(TimerEvent.TIMER,this.onShowPermanentTooltips);
         this._hideTooltipsTimer.stop();
         for each(entityId in this._battleFrame.targetedEntities)
         {
            this.displayEntityTooltip(entityId);
         }
      }
      
      private function onShowTooltip(pEvent:TimerEvent) : void {
         this._hideTooltipTimer.removeEventListener(TimerEvent.TIMER,this.onShowTooltip);
         this._hideTooltipTimer.stop();
         var entityInfo:GameContextActorInformations = this._entitiesFrame.getEntityInfos(this._hideTooltipEntityId);
         if((entityInfo) && ((entityInfo.disposition.cellId == currentCell) || (this.timelineOverEntity) && (this._hideTooltipEntityId == this.timelineOverEntityId)))
         {
            this.displayEntityTooltip(this._hideTooltipEntityId);
         }
      }
   }
}
