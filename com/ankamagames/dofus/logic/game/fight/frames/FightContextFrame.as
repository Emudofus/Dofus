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
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
   import com.ankamagames.atouin.Atouin;
   import flash.events.TimerEvent;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.logic.game.roleplay.frames.MonstersInfoFrame;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.atouin.managers.*;
   import com.ankamagames.atouin.renderers.*;
   import com.ankamagames.atouin.types.*;
   import com.ankamagames.jerakine.entities.interfaces.*;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
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
   import com.ankamagames.dofus.network.types.game.action.fight.FightDispellableEffectExtendedInformations;
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
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.logic.game.fight.miscs.DamageUtil;
   import com.ankamagames.dofus.logic.game.fight.types.SpellDamageInfo;
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
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightContextFrame));
      
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
      
      public function set fightType(param1:uint) : void {
         this._fightType = param1;
         var _loc2_:PartyManagementFrame = Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
         _loc2_.lastFightType = param1;
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
         var _loc1_:Array = new Array();
         _loc1_ = _loc1_.concat([0.5,0,0,0,100]);
         _loc1_ = _loc1_.concat([0,0.5,0,0,100]);
         _loc1_ = _loc1_.concat([0,0,0.5,0,100]);
         _loc1_ = _loc1_.concat([0,0,0,1,0]);
         this._linkedEffect = new ColorMatrixFilter(_loc1_);
         var _loc2_:Array = new Array();
         _loc2_ = _loc2_.concat([0.5,0,0,0,0]);
         _loc2_ = _loc2_.concat([0,0.5,0,0,0]);
         _loc2_ = _loc2_.concat([0,0,0.5,0,0]);
         _loc2_ = _loc2_.concat([0,0,0,1,0]);
         this._linkedMainEffect = new ColorMatrixFilter(_loc2_);
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
         var _loc3_:UiRootContainer = Berilia.getInstance().getUi("mapInfo");
         if(_loc3_)
         {
            _loc3_.visible = false;
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
      
      private function onUiUnloaded(param1:UiUnloadEvent) : void {
         var _loc2_:* = 0;
         if((this._showPermanentTooltips) && (this.battleFrame))
         {
            for each (_loc2_ in this.battleFrame.targetedEntities)
            {
               this.displayEntityTooltip(_loc2_);
            }
         }
      }
      
      public function getFighterName(param1:int) : String {
         var _loc2_:GameFightFighterInformations = null;
         var _loc3_:GameFightCompanionInformations = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:GameFightTaxCollectorInformations = null;
         var _loc7_:String = null;
         _loc2_ = this.getFighterInfos(param1);
         if(!_loc2_)
         {
            return "Unknown Fighter";
         }
         switch(true)
         {
            case _loc2_ is GameFightFighterNamedInformations:
               return (_loc2_ as GameFightFighterNamedInformations).name;
            case _loc2_ is GameFightMonsterInformations:
               return Monster.getMonsterById((_loc2_ as GameFightMonsterInformations).creatureGenericId).name;
            case _loc2_ is GameFightCompanionInformations:
               _loc3_ = _loc2_ as GameFightCompanionInformations;
               _loc5_ = Companion.getCompanionById(_loc3_.companionGenericId).name;
               if(_loc3_.masterId != PlayedCharacterManager.getInstance().id)
               {
                  _loc7_ = this.getFighterName(_loc3_.masterId);
                  _loc4_ = I18n.getUiText("ui.common.belonging",[_loc5_,_loc7_]);
               }
               else
               {
                  _loc4_ = _loc5_;
               }
               return _loc4_;
            case _loc2_ is GameFightTaxCollectorInformations:
               _loc6_ = _loc2_ as GameFightTaxCollectorInformations;
               return TaxCollectorFirstname.getTaxCollectorFirstnameById(_loc6_.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(_loc6_.lastNameId).name;
            default:
               return "Unknown Fighter Type";
         }
      }
      
      public function getFighterStatus(param1:int) : uint {
         var _loc2_:GameFightFighterInformations = this.getFighterInfos(param1);
         if(!_loc2_)
         {
            return 1;
         }
         switch(true)
         {
            case _loc2_ is GameFightFighterNamedInformations:
               return (_loc2_ as GameFightFighterNamedInformations).status.statusId;
            default:
               return 1;
         }
      }
      
      public function getFighterLevel(param1:int) : uint {
         var _loc2_:GameFightFighterInformations = null;
         var _loc3_:Monster = null;
         _loc2_ = this.getFighterInfos(param1);
         if(!_loc2_)
         {
            return 0;
         }
         switch(true)
         {
            case _loc2_ is GameFightMutantInformations:
               return (_loc2_ as GameFightMutantInformations).powerLevel;
            case _loc2_ is GameFightCharacterInformations:
               return (_loc2_ as GameFightCharacterInformations).level;
            case _loc2_ is GameFightCompanionInformations:
               return (_loc2_ as GameFightCompanionInformations).level;
            case _loc2_ is GameFightMonsterInformations:
               _loc3_ = Monster.getMonsterById((_loc2_ as GameFightMonsterInformations).creatureGenericId);
               return _loc3_.getMonsterGrade((_loc2_ as GameFightMonsterInformations).creatureGrade).level;
            case _loc2_ is GameFightTaxCollectorInformations:
               return (_loc2_ as GameFightTaxCollectorInformations).level;
            default:
               return 0;
         }
      }
      
      public function getChallengeById(param1:uint) : ChallengeWrapper {
         var _loc2_:ChallengeWrapper = null;
         for each (_loc2_ in this._challengesList)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:GameFightStartingMessage = null;
         var _loc3_:CurrentMapMessage = null;
         var _loc4_:WorldPointWrapper = null;
         var _loc5_:ByteArray = null;
         var _loc6_:GameContextReadyMessage = null;
         var _loc7_:GameFightResumeMessage = null;
         var _loc8_:Vector.<GameFightResumeSlaveInfo> = null;
         var _loc9_:GameFightResumeSlaveInfo = null;
         var _loc10_:CurrentPlayedFighterManager = null;
         var _loc11_:* = 0;
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         var _loc14_:Array = null;
         var _loc15_:CastingSpell = null;
         var _loc16_:GameFightUpdateTeamMessage = null;
         var _loc17_:GameFightSpectateMessage = null;
         var _loc18_:Array = null;
         var _loc19_:Array = null;
         var _loc20_:Array = null;
         var _loc21_:CastingSpell = null;
         var _loc22_:GameFightJoinMessage = null;
         var _loc23_:* = 0;
         var _loc24_:GameActionFightCarryCharacterMessage = null;
         var _loc25_:CellOutMessage = null;
         var _loc26_:AnimatedCharacter = null;
         var _loc27_:CellOverMessage = null;
         var _loc28_:AnimatedCharacter = null;
         var _loc29_:EntityMouseOverMessage = null;
         var _loc30_:EntityMouseOutMessage = null;
         var _loc31_:TimelineEntityOverAction = null;
         var _loc32_:TimelineEntityOutAction = null;
         var _loc33_:* = 0;
         var _loc34_:Vector.<int> = null;
         var _loc35_:TogglePointCellAction = null;
         var _loc36_:GameFightEndMessage = null;
         var _loc37_:ChallengeTargetsListRequestAction = null;
         var _loc38_:ChallengeTargetsListRequestMessage = null;
         var _loc39_:ChallengeTargetsListMessage = null;
         var _loc40_:ChallengeInfoMessage = null;
         var _loc41_:ChallengeWrapper = null;
         var _loc42_:ChallengeTargetUpdateMessage = null;
         var _loc43_:ChallengeResultMessage = null;
         var _loc44_:MapObstacleUpdateMessage = null;
         var _loc45_:GameActionFightNoSpellCastMessage = null;
         var _loc46_:uint = 0;
         var _loc47_:MapInformationsRequestMessage = null;
         var _loc48_:String = null;
         var _loc49_:GameFightResumeWithSlavesMessage = null;
         var _loc50_:* = 0;
         var _loc51_:GameFightResumeSlaveInfo = null;
         var _loc52_:SpellCastInFightManager = null;
         var _loc53_:FightDispellableEffectExtendedInformations = null;
         var _loc54_:BasicBuff = null;
         var _loc55_:GameActionMark = null;
         var _loc56_:Spell = null;
         var _loc57_:GameActionMarkedCell = null;
         var _loc58_:AddGlyphGfxStep = null;
         var _loc59_:FightDispellableEffectExtendedInformations = null;
         var _loc60_:BasicBuff = null;
         var _loc61_:GameActionMark = null;
         var _loc62_:Spell = null;
         var _loc63_:GameActionMarkedCell = null;
         var _loc64_:AddGlyphGfxStep = null;
         var _loc65_:IEntity = null;
         var _loc66_:IEntity = null;
         var _loc67_:FightEndingMessage = null;
         var _loc68_:Vector.<FightResultEntryWrapper> = null;
         var _loc69_:uint = 0;
         var _loc70_:FightResultEntryWrapper = null;
         var _loc71_:Vector.<FightResultEntryWrapper> = null;
         var _loc72_:FightResultListEntry = null;
         var _loc73_:Object = null;
         var _loc74_:FightResultEntryWrapper = null;
         var _loc75_:* = 0;
         var _loc76_:uint = 0;
         var _loc77_:ItemWrapper = null;
         var _loc78_:* = 0;
         var _loc79_:* = 0;
         var _loc80_:FightResultEntryWrapper = null;
         var _loc81_:* = NaN;
         var _loc82_:MapObstacle = null;
         var _loc83_:SpellLevel = null;
         switch(true)
         {
            case param1 is MapLoadedMessage:
               MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(false);
               if(PlayedCharacterManager.getInstance().isSpectator)
               {
                  _loc47_ = new MapInformationsRequestMessage();
                  _loc47_.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                  ConnectionsHandler.getConnection().send(_loc47_);
               }
               return true;
            case param1 is GameFightStartingMessage:
               _loc2_ = param1 as GameFightStartingMessage;
               TooltipManager.hideAll();
               Atouin.getInstance().cancelZoom();
               KernelEventsManager.getInstance().processCallback(HookList.StartZoom,false);
               MapDisplayManager.getInstance().activeIdentifiedElements(false);
               FightEventsHelper.reset();
               KernelEventsManager.getInstance().processCallback(HookList.GameFightStarting,_loc2_.fightType);
               this.fightType = _loc2_.fightType;
               this._fightAttackerId = _loc2_.attackerId;
               CurrentPlayedFighterManager.getInstance().currentFighterId = PlayedCharacterManager.getInstance().id;
               CurrentPlayedFighterManager.getInstance().getSpellCastManager().currentTurn = 0;
               SoundManager.getInstance().manager.prepareFightMusic();
               SoundManager.getInstance().manager.playUISound(UISoundEnum.INTRO_FIGHT);
               return true;
            case param1 is CurrentMapMessage:
               _loc3_ = param1 as CurrentMapMessage;
               ConnectionsHandler.pause();
               Kernel.getWorker().pause();
               if(TacticModeManager.getInstance().tacticModeActivated)
               {
                  TacticModeManager.getInstance().hide();
               }
               _loc4_ = new WorldPointWrapper(_loc3_.mapId);
               KernelEventsManager.getInstance().processCallback(HookList.StartZoom,false);
               Atouin.getInstance().initPreDisplay(_loc4_);
               Atouin.getInstance().clearEntities();
               if((_loc3_.mapKey) && (_loc3_.mapKey.length))
               {
                  _loc48_ = XmlConfig.getInstance().getEntry("config.maps.encryptionKey");
                  if(!_loc48_)
                  {
                     _loc48_ = _loc3_.mapKey;
                  }
                  _loc5_ = Hex.toArray(Hex.fromString(_loc48_));
               }
               this._currentMapRenderId = Atouin.getInstance().display(_loc4_,_loc5_);
               _log.info("Ask map render for fight #" + this._currentMapRenderId);
               PlayedCharacterManager.getInstance().currentMap = _loc4_;
               KernelEventsManager.getInstance().processCallback(HookList.CurrentMap,_loc3_.mapId);
               return true;
            case param1 is MapsLoadingCompleteMessage:
               _log.info("MapsLoadingCompleteMessage #" + MapsLoadingCompleteMessage(param1).renderRequestId);
               if(this._currentMapRenderId != MapsLoadingCompleteMessage(param1).renderRequestId)
               {
                  return false;
               }
               Atouin.getInstance().showWorld(true);
               Atouin.getInstance().displayGrid(true,true);
               Atouin.getInstance().cellOverEnabled = true;
               _loc6_ = new GameContextReadyMessage();
               _loc6_.initGameContextReadyMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
               ConnectionsHandler.getConnection().send(_loc6_);
               Kernel.getWorker().resume();
               ConnectionsHandler.resume();
               return true;
            case param1 is GameFightResumeMessage:
               _loc7_ = param1 as GameFightResumeMessage;
               this.tacticModeHandler();
               PlayedCharacterManager.getInstance().currentSummonedCreature = _loc7_.summonCount;
               this._battleFrame.turnsCount = _loc7_.gameTurn-1;
               KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated,_loc7_.gameTurn-1);
               if(param1 is GameFightResumeWithSlavesMessage)
               {
                  _loc49_ = param1 as GameFightResumeWithSlavesMessage;
                  _loc8_ = _loc49_.slavesInfo;
               }
               else
               {
                  _loc8_ = new Vector.<GameFightResumeSlaveInfo>();
               }
               _loc9_ = new GameFightResumeSlaveInfo();
               _loc9_.spellCooldowns = _loc7_.spellCooldowns;
               _loc9_.slaveId = PlayedCharacterManager.getInstance().id;
               _loc8_.unshift(_loc9_);
               _loc10_ = CurrentPlayedFighterManager.getInstance();
               _loc11_ = _loc8_.length;
               _loc50_ = 0;
               while(_loc50_ < _loc11_)
               {
                  _loc51_ = _loc8_[_loc50_];
                  _loc52_ = _loc10_.getSpellCastManagerById(_loc51_.slaveId);
                  _loc52_.currentTurn = _loc7_.gameTurn-1;
                  _loc52_.updateCooldowns(_loc8_[_loc50_].spellCooldowns);
                  _loc50_++;
               }
               _loc12_ = [];
               for each (_loc53_ in _loc7_.effects)
               {
                  if(!_loc12_[_loc53_.effect.targetId])
                  {
                     _loc12_[_loc53_.effect.targetId] = [];
                  }
                  _loc13_ = _loc12_[_loc53_.effect.targetId];
                  if(!_loc13_[_loc53_.effect.turnDuration])
                  {
                     _loc13_[_loc53_.effect.turnDuration] = [];
                  }
                  _loc14_ = _loc13_[_loc53_.effect.turnDuration];
                  _loc15_ = _loc14_[_loc53_.effect.spellId];
                  if(!_loc15_)
                  {
                     _loc15_ = new CastingSpell();
                     _loc15_.casterId = _loc53_.sourceId;
                     _loc15_.spell = Spell.getSpellById(_loc53_.effect.spellId);
                     _loc14_[_loc53_.effect.spellId] = _loc15_;
                  }
                  _loc54_ = BuffManager.makeBuffFromEffect(_loc53_.effect,_loc15_,_loc53_.actionId);
                  BuffManager.getInstance().addBuff(_loc54_);
               }
               for each (_loc55_ in _loc7_.marks)
               {
                  _loc56_ = Spell.getSpellById(_loc55_.markSpellId);
                  MarkedCellsManager.getInstance().addMark(_loc55_.markId,_loc55_.markType,_loc56_,_loc55_.cells);
                  if(_loc56_.getParamByName("glyphGfxId"))
                  {
                     for each (_loc57_ in _loc55_.cells)
                     {
                        _loc58_ = new AddGlyphGfxStep(_loc56_.getParamByName("glyphGfxId"),_loc57_.cellId,_loc55_.markId,_loc55_.markType);
                        _loc58_.start();
                     }
                  }
               }
               Kernel.beingInReconection = false;
               return true;
            case param1 is GameFightUpdateTeamMessage:
               _loc16_ = param1 as GameFightUpdateTeamMessage;
               PlayedCharacterManager.getInstance().teamId = _loc16_.team.teamId;
               return true;
            case param1 is GameFightSpectateMessage:
               _loc17_ = param1 as GameFightSpectateMessage;
               this.tacticModeHandler();
               this._battleFrame.turnsCount = _loc17_.gameTurn-1;
               KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated,_loc17_.gameTurn-1);
               _loc18_ = [];
               for each (_loc59_ in _loc17_.effects)
               {
                  if(!_loc18_[_loc59_.effect.targetId])
                  {
                     _loc18_[_loc59_.effect.targetId] = [];
                  }
                  _loc19_ = _loc18_[_loc59_.effect.targetId];
                  if(!_loc19_[_loc59_.effect.turnDuration])
                  {
                     _loc19_[_loc59_.effect.turnDuration] = [];
                  }
                  _loc20_ = _loc19_[_loc59_.effect.turnDuration];
                  _loc21_ = _loc20_[_loc59_.effect.spellId];
                  if(!_loc21_)
                  {
                     _loc21_ = new CastingSpell();
                     _loc21_.casterId = _loc59_.sourceId;
                     _loc21_.spell = Spell.getSpellById(_loc59_.effect.spellId);
                     _loc20_[_loc59_.effect.spellId] = _loc21_;
                  }
                  _loc60_ = BuffManager.makeBuffFromEffect(_loc59_.effect,_loc21_,_loc59_.actionId);
                  BuffManager.getInstance().addBuff(_loc60_,!(_loc60_ is StatBuff));
               }
               for each (_loc61_ in _loc17_.marks)
               {
                  _loc62_ = Spell.getSpellById(_loc61_.markSpellId);
                  MarkedCellsManager.getInstance().addMark(_loc61_.markId,_loc61_.markType,_loc62_,_loc61_.cells);
                  if(_loc62_.getParamByName("glyphGfxId"))
                  {
                     for each (_loc63_ in _loc61_.cells)
                     {
                        _loc64_ = new AddGlyphGfxStep(_loc62_.getParamByName("glyphGfxId"),_loc63_.cellId,_loc61_.markId,_loc61_.markType);
                        _loc64_.start();
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
         var _loc1_:UiRootContainer = Berilia.getInstance().getUi("mapInfo");
         if(_loc1_)
         {
            _loc1_.visible = true;
         }
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
         var _loc2_:SpellInventoryManagementFrame = Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame;
         _loc2_.deleteSpellsGlobalCoolDownsData();
         return true;
      }
      
      public function outEntity(param1:int) : void {
         var _loc6_:* = 0;
         this._timerFighterInfo.reset();
         this._timerMovementRange.reset();
         var _loc2_:Vector.<int> = this._entitiesFrame.getEntitiesIdsList();
         fighterEntityTooltipId = param1;
         var _loc3_:IEntity = DofusEntities.getEntity(fighterEntityTooltipId);
         if(!_loc3_)
         {
            if(_loc2_.indexOf(fighterEntityTooltipId) == -1)
            {
               _log.warn("Mouse over an unknown entity : " + param1);
               return;
            }
         }
         if((this._lastEffectEntity) && (this._lastEffectEntity.object))
         {
            Sprite(this._lastEffectEntity.object).filters = [];
         }
         this._lastEffectEntity = null;
         var _loc4_:String = "tooltipOverEntity_" + param1;
         if((!this._showPermanentTooltips || (this._showPermanentTooltips) && this.battleFrame.targetedEntities.indexOf(param1) == -1) && (TooltipManager.isVisible(_loc4_)))
         {
            TooltipManager.hide(_loc4_);
         }
         if(this._showPermanentTooltips)
         {
            for each (_loc6_ in this.battleFrame.targetedEntities)
            {
               this.displayEntityTooltip(_loc6_);
            }
         }
         if(_loc3_ != null)
         {
            Sprite(_loc3_).filters = [];
         }
         this.hideMovementRange();
         var _loc5_:Selection = SelectionManager.getInstance().getSelection(this.INVISIBLE_POSITION_SELECTION);
         if(_loc5_)
         {
            _loc5_.remove();
         }
         this.removeAsLinkEntityEffect();
         if((this._currentFighterInfo) && this._currentFighterInfo.contextualId == param1)
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate,null);
         }
      }
      
      public function displayEntityTooltip(param1:int, param2:Object=null) : void {
         var _loc5_:Object = null;
         var _loc7_:AnimatedCharacter = null;
         var _loc8_:* = false;
         var _loc9_:* = false;
         var _loc3_:IDisplayable = DofusEntities.getEntity(param1) as IDisplayable;
         if(!_loc3_ || !(this._battleFrame.targetedEntities.indexOf(param1) == -1) && (this._hideTooltips))
         {
            return;
         }
         var _loc4_:GameFightFighterInformations = this._entitiesFrame.getEntityInfos(param1) as GameFightFighterInformations;
         if(!(_loc4_.disposition.cellId == currentCell) && !((this._timelineOverEntity) && param1 == this.timelineOverEntityId))
         {
            if(!_loc5_)
            {
               _loc5_ = new Object();
            }
            _loc5_.showName = false;
         }
         var _loc6_:Boolean = BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG || BuildInfos.BUILD_TYPE == BuildTypeEnum.INTERNAL;
         if(_loc6_)
         {
            _loc7_ = _loc3_ as AnimatedCharacter;
            _loc8_ = (_loc7_) && (_loc7_.parentSprite) && _loc7_.parentSprite.carriedEntity == _loc7_;
            _loc9_ = (param2) && (DamageUtil.isDamagedOrHealedBySpell(CurrentPlayedFighterManager.getInstance().currentFighterId,param1,param2));
            if((_loc8_) && !_loc9_)
            {
               return;
            }
            if(_loc9_)
            {
               if(!_loc5_)
               {
                  _loc5_ = new Object();
               }
               _loc5_.spellDamage = DamageUtil.getSpellDamage(SpellDamageInfo.fromCurrentPlayer(param2,param1));
            }
         }
         if(_loc4_ is GameFightCharacterInformations)
         {
            TooltipManager.show(_loc4_,_loc3_.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"tooltipOverEntity_" + _loc4_.contextualId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,null,null,_loc5_,"PlayerShortInfos" + _loc4_.contextualId,false,StrataEnum.STRATA_WORLD);
         }
         else
         {
            if(_loc4_ is GameFightCompanionInformations)
            {
               TooltipManager.show(_loc4_,_loc3_.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"tooltipOverEntity_" + _loc4_.contextualId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,"companionFighter",null,_loc5_,"EntityShortInfos" + _loc4_.contextualId);
            }
            else
            {
               TooltipManager.show(_loc4_,_loc3_.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"tooltipOverEntity_" + _loc4_.contextualId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,"monsterFighter",null,_loc5_,"EntityShortInfos" + _loc4_.contextualId,false,StrataEnum.STRATA_WORLD);
            }
         }
      }
      
      public function hideEntityTooltip(param1:int, param2:uint) : void {
         if(!((this._showPermanentTooltips) && !(this._battleFrame.targetedEntities.indexOf(param1) == -1)) && (TooltipManager.isVisible("tooltipOverEntity_" + param1)))
         {
            TooltipManager.hide("tooltipOverEntity_" + param1);
            this._hideTooltipEntityId = param1;
            if(!this._hideTooltipTimer)
            {
               this._hideTooltipTimer = new Timer(param2);
            }
            this._hideTooltipTimer.stop();
            this._hideTooltipTimer.delay = param2;
            this._hideTooltipTimer.removeEventListener(TimerEvent.TIMER,this.onShowTooltip);
            this._hideTooltipTimer.addEventListener(TimerEvent.TIMER,this.onShowTooltip);
            this._hideTooltipTimer.start();
         }
      }
      
      public function hidePermanentTooltips(param1:uint) : void {
         var _loc2_:* = 0;
         this._hideTooltips = true;
         if(this._battleFrame.targetedEntities.length > 0)
         {
            for each (_loc2_ in this._battleFrame.targetedEntities)
            {
               TooltipManager.hide("tooltipOverEntity_" + _loc2_);
            }
            if(!this._hideTooltipsTimer)
            {
               this._hideTooltipsTimer = new Timer(param1);
            }
            this._hideTooltipsTimer.stop();
            this._hideTooltipsTimer.delay = param1;
            this._hideTooltipsTimer.removeEventListener(TimerEvent.TIMER,this.onShowPermanentTooltips);
            this._hideTooltipsTimer.addEventListener(TimerEvent.TIMER,this.onShowPermanentTooltips);
            this._hideTooltipsTimer.start();
         }
      }
      
      private function getFighterInfos(param1:int) : GameFightFighterInformations {
         return this.entitiesFrame.getEntityInfos(param1) as GameFightFighterInformations;
      }
      
      private function showFighterInfo(param1:TimerEvent) : void {
         this._timerFighterInfo.reset();
         KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate,this._currentFighterInfo);
      }
      
      private function showMovementRange(param1:TimerEvent) : void {
         this._timerMovementRange.reset();
         this._reachableRangeSelection = new Selection();
         this._reachableRangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
         this._reachableRangeSelection.color = new Color(52326);
         this._unreachableRangeSelection = new Selection();
         this._unreachableRangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
         this._unreachableRangeSelection.color = new Color(6684672);
         var _loc2_:int = getTimer();
         var _loc3_:FightReachableCellsMaker = new FightReachableCellsMaker(this._currentFighterInfo);
         this._reachableRangeSelection.zone = new Custom(_loc3_.reachableCells);
         this._unreachableRangeSelection.zone = new Custom(_loc3_.unreachableCells);
         SelectionManager.getInstance().addSelection(this._reachableRangeSelection,"movementReachableRange",this._currentFighterInfo.disposition.cellId);
         SelectionManager.getInstance().addSelection(this._unreachableRangeSelection,"movementUnreachableRange",this._currentFighterInfo.disposition.cellId);
      }
      
      private function hideMovementRange() : void {
         var _loc1_:Selection = SelectionManager.getInstance().getSelection("movementReachableRange");
         if(_loc1_)
         {
            _loc1_.remove();
            this._reachableRangeSelection = null;
         }
         _loc1_ = SelectionManager.getInstance().getSelection("movementUnreachableRange");
         if(_loc1_)
         {
            _loc1_.remove();
            this._unreachableRangeSelection = null;
         }
      }
      
      private function removeAsLinkEntityEffect() : void {
         var _loc1_:* = 0;
         var _loc2_:DisplayObject = null;
         var _loc3_:* = 0;
         for each (_loc1_ in this._entitiesFrame.getEntitiesIdsList())
         {
            _loc2_ = DofusEntities.getEntity(_loc1_) as DisplayObject;
            if((_loc2_) && (_loc2_.filters) && (_loc2_.filters.length))
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_.filters.length)
               {
                  if(_loc2_.filters[_loc3_] is ColorMatrixFilter)
                  {
                     _loc2_.filters = _loc2_.filters.splice(_loc3_,_loc3_);
                     break;
                  }
                  _loc3_++;
               }
            }
         }
      }
      
      private function highlightAsLinkedEntity(param1:int, param2:Boolean) : void {
         var _loc5_:ColorMatrixFilter = null;
         var _loc3_:IEntity = DofusEntities.getEntity(param1);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:Sprite = _loc3_ as Sprite;
         if((_loc4_) && (Dofus.getInstance().options.showGlowOverTarget))
         {
            _loc5_ = param2?this._linkedMainEffect:this._linkedEffect;
            if(_loc4_.filters.length)
            {
               if(_loc4_.filters[0] != _loc5_)
               {
                  _loc4_.filters = [_loc5_];
               }
            }
            else
            {
               _loc4_.filters = [_loc5_];
            }
         }
      }
      
      private function overEntity(param1:int, param2:Boolean=true) : void {
         var _loc7_:* = 0;
         var _loc8_:FightSpellCastFrame = null;
         var _loc12_:GameFightFighterInformations = null;
         var _loc13_:Selection = null;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:FightReachableCellsMaker = null;
         var _loc17_:GlowFilter = null;
         var _loc18_:FightTurnFrame = null;
         var _loc19_:* = false;
         var _loc3_:Vector.<int> = this._entitiesFrame.getEntitiesIdsList();
         fighterEntityTooltipId = param1;
         var _loc4_:IEntity = DofusEntities.getEntity(fighterEntityTooltipId);
         if(!_loc4_)
         {
            if(_loc3_.indexOf(fighterEntityTooltipId) == -1)
            {
               _log.warn("Mouse over an unknown entity : " + param1);
               return;
            }
            param2 = false;
         }
         var _loc5_:GameFightFighterInformations = this._entitiesFrame.getEntityInfos(param1) as GameFightFighterInformations;
         if(!_loc5_)
         {
            _log.warn("Mouse over an unknown entity : " + param1);
            return;
         }
         var _loc6_:int = _loc5_.stats.summoner;
         if(_loc5_ is GameFightCompanionInformations)
         {
            _loc6_ = (_loc5_ as GameFightCompanionInformations).masterId;
         }
         for each (_loc7_ in _loc3_)
         {
            if(_loc7_ != param1)
            {
               _loc12_ = this._entitiesFrame.getEntityInfos(_loc7_) as GameFightFighterInformations;
               if((_loc12_.stats.summoner == param1 || _loc6_ == _loc7_) || ((_loc12_.stats.summoner == _loc6_) && (_loc6_)) || _loc12_ is GameFightCompanionInformations && (_loc12_ as GameFightCompanionInformations).masterId == param1)
               {
                  this.highlightAsLinkedEntity(_loc7_,_loc6_ == _loc7_);
               }
            }
         }
         this._currentFighterInfo = _loc5_;
         if(Dofus.getInstance().options.showEntityInfos)
         {
            this._timerFighterInfo.reset();
            this._timerFighterInfo.start();
         }
         if(_loc5_.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE)
         {
            _log.warn("Mouse over an invisible entity.");
            _loc13_ = SelectionManager.getInstance().getSelection(this.INVISIBLE_POSITION_SELECTION);
            if(!_loc13_)
            {
               _loc13_ = new Selection();
               _loc13_.color = new Color(52326);
               _loc13_.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
               SelectionManager.getInstance().addSelection(_loc13_,this.INVISIBLE_POSITION_SELECTION);
            }
            _loc14_ = FightEntitiesFrame.getCurrentInstance().getLastKnownEntityPosition(_loc5_.contextualId);
            if(_loc14_ > -1)
            {
               _loc15_ = FightEntitiesFrame.getCurrentInstance().getLastKnownEntityMovementPoint(_loc5_.contextualId);
               _loc16_ = new FightReachableCellsMaker(this._currentFighterInfo,_loc14_,_loc15_);
               _loc13_.zone = new Custom(_loc16_.reachableCells);
               SelectionManager.getInstance().update(this.INVISIBLE_POSITION_SELECTION,_loc14_);
            }
            return;
         }
         _loc8_ = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
         var _loc9_:Object = null;
         if((_loc8_) && (_loc8_.currentCellEntityInTargetSelection))
         {
            _loc9_ = _loc8_.currentSpell;
         }
         this.displayEntityTooltip(param1,_loc9_);
         var _loc10_:Selection = SelectionManager.getInstance().getSelection(FightTurnFrame.SELECTION_PATH);
         if(_loc10_)
         {
            _loc10_.remove();
         }
         if(param2)
         {
            if((Dofus.getInstance().options.showMovementRange) && (Kernel.getWorker().contains(FightBattleFrame)) && !Kernel.getWorker().contains(FightSpellCastFrame))
            {
               this._timerMovementRange.reset();
               this._timerMovementRange.start();
            }
         }
         if((this._lastEffectEntity) && (this._lastEffectEntity.object is Sprite) && !(this._lastEffectEntity.object == _loc4_))
         {
            Sprite(this._lastEffectEntity.object).filters = [];
         }
         var _loc11_:Sprite = _loc4_ as Sprite;
         if((_loc11_) && (Dofus.getInstance().options.showGlowOverTarget))
         {
            _loc8_ = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
            _loc18_ = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
            _loc19_ = _loc18_?_loc18_.myTurn:true;
            if(((!_loc8_) || ((_loc8_) && (_loc8_.currentTargetIsTargetable))) && (_loc19_))
            {
               _loc17_ = this._overEffectOk;
            }
            else
            {
               _loc17_ = this._overEffectKo;
            }
            if(_loc11_.filters.length)
            {
               if(_loc11_.filters[0] != _loc17_)
               {
                  _loc11_.filters = [_loc17_];
               }
            }
            else
            {
               _loc11_.filters = [_loc17_];
            }
            this._lastEffectEntity = new WeakReference(_loc4_);
         }
      }
      
      private function tacticModeHandler(param1:Boolean=false) : void {
         if((param1) && !TacticModeManager.getInstance().tacticModeActivated)
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
      
      private function onPropertyChanged(param1:PropertyChangeEvent) : void {
         var _loc2_:* = 0;
         switch(param1.propertyName)
         {
            case "showPermanentTargetsTooltips":
               this._showPermanentTooltips = param1.propertyValue as Boolean;
               for each (_loc2_ in this._battleFrame.targetedEntities)
               {
                  if(!this._showPermanentTooltips)
                  {
                     TooltipManager.hide("tooltipOverEntity_" + _loc2_);
                  }
                  else
                  {
                     this.displayEntityTooltip(_loc2_);
                  }
               }
               break;
         }
      }
      
      private function onShowPermanentTooltips(param1:TimerEvent) : void {
         var _loc2_:* = 0;
         this._hideTooltips = false;
         this._hideTooltipsTimer.removeEventListener(TimerEvent.TIMER,this.onShowPermanentTooltips);
         this._hideTooltipsTimer.stop();
         for each (_loc2_ in this._battleFrame.targetedEntities)
         {
            this.displayEntityTooltip(_loc2_);
         }
      }
      
      private function onShowTooltip(param1:TimerEvent) : void {
         this._hideTooltipTimer.removeEventListener(TimerEvent.TIMER,this.onShowTooltip);
         this._hideTooltipTimer.stop();
         var _loc2_:GameContextActorInformations = this._entitiesFrame.getEntityInfos(this._hideTooltipEntityId);
         if((_loc2_) && (_loc2_.disposition.cellId == currentCell || (this.timelineOverEntity) && this._hideTooltipEntityId == this.timelineOverEntityId))
         {
            this.displayEntityTooltip(this._hideTooltipEntityId);
         }
      }
   }
}
