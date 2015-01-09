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
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.NamedPartyTeam;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
    import com.ankamagames.atouin.Atouin;
    import flash.events.TimerEvent;
    import com.ankamagames.atouin.managers.MapDisplayManager;
    import com.ankamagames.dofus.logic.game.roleplay.frames.MonstersInfoFrame;
    import com.ankamagames.jerakine.managers.OptionManager;
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
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightStartingMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
    import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
    import flash.utils.ByteArray;
    import com.ankamagames.dofus.network.messages.game.context.GameContextReadyMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightResumeMessage;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightResumeSlaveInfo;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
    import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
    import com.ankamagames.dofus.network.types.game.action.fight.FightDispellableEffectExtendedInformations;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightUpdateTeamMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSpectateMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSpectatorJoinMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCarryCharacterMessage;
    import com.ankamagames.atouin.messages.CellOverMessage;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
    import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
    import com.ankamagames.atouin.messages.CellOutMessage;
    import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
    import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightLeaveMessage;
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
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightResumeWithSlavesMessage;
    import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.dofus.types.entities.Glyph;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.logic.game.common.messages.FightEndingMessage;
    import com.ankamagames.dofus.internalDatacenter.fight.FightResultEntryWrapper;
    import com.ankamagames.dofus.network.types.game.context.fight.FightResultListEntry;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.NamedPartyTeamWithOutcome;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import com.ankamagames.atouin.messages.MapLoadedMessage;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
    import com.ankamagames.dofus.kernel.sound.SoundManager;
    import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.logic.game.fight.managers.TacticModeManager;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.hurlant.util.Hex;
    import com.ankamagames.atouin.messages.MapsLoadingCompleteMessage;
    import com.ankamagames.dofus.misc.lists.FightHookList;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
    import com.ankamagames.dofus.network.enums.TeamEnum;
    import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.jerakine.entities.interfaces.IInteractive;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightStartMessage;
    import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
    import com.ankamagames.dofus.logic.game.fight.managers.LinkedCellsManager;
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
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import com.ankamagames.dofus.network.enums.MapObstacleStateEnum;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.logic.game.fight.actions.ShowTacticModeAction;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.sequencer.SerialSequencer;
    import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import flash.display.Sprite;
    import com.ankamagames.atouin.managers.SelectionManager;
    import com.ankamagames.dofus.logic.game.fight.miscs.PushUtil;
    import com.ankamagames.berilia.types.tooltip.TooltipPlacer;
    import com.ankamagames.dofus.logic.game.fight.types.SpellDamageInfo;
    import com.ankamagames.dofus.logic.game.fight.types.SpellDamage;
    import com.ankamagames.dofus.logic.game.fight.types.EffectDamage;
    import com.ankamagames.jerakine.types.zones.IZone;
    import com.ankamagames.dofus.logic.game.fight.types.PushedEntity;
    import com.ankamagames.dofus.logic.game.fight.types.TriggeredSpell;
    import com.ankamagames.dofus.logic.game.fight.types.SplashDamage;
    import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
    import com.ankamagames.dofus.logic.game.fight.miscs.DamageUtil;
    import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.berilia.enums.StrataEnum;
    import com.ankamagames.atouin.renderers.ZoneDARenderer;
    import com.ankamagames.atouin.enums.PlacementStrataEnums;
    import com.ankamagames.jerakine.types.Color;
    import com.ankamagames.dofus.logic.game.fight.miscs.FightReachableCellsMaker;
    import com.ankamagames.jerakine.types.zones.Custom;
    import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMark;
    import com.ankamagames.dofus.types.sequences.AddGlyphGfxStep;
    import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMarkedCell;
    import flash.display.DisplayObject;
    import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.atouin.managers.*;
    import __AS3__.vec.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.renderers.*;
    import com.ankamagames.jerakine.entities.interfaces.*;

    public class FightContextFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightContextFrame));
        public static var preFightIsActive:Boolean = true;
        public static var fighterEntityTooltipId:int;
        public static var currentCell:int = -1;

        private const TYPE_LOG_FIGHT:uint = 30000;
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
        private var _namedPartyTeams:Vector.<NamedPartyTeam>;
        private var _fightersPositionsHistory:Dictionary;
        private var _fighterNumPositions:Dictionary;
        public var isFightLeader:Boolean;

        public function FightContextFrame()
        {
            this._spellTargetsTooltips = new Dictionary();
            this._spellDamages = new Dictionary();
            this._fightersPositionsHistory = new Dictionary();
            this._fighterNumPositions = new Dictionary();
            super();
        }

        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get entitiesFrame():FightEntitiesFrame
        {
            return (this._entitiesFrame);
        }

        public function get battleFrame():FightBattleFrame
        {
            return (this._battleFrame);
        }

        public function get challengesList():Array
        {
            return (this._challengesList);
        }

        public function get fightType():uint
        {
            return (this._fightType);
        }

        public function set fightType(t:uint):void
        {
            this._fightType = t;
            var partyFrame:PartyManagementFrame = (Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame);
            partyFrame.lastFightType = t;
        }

        public function get timelineOverEntity():Boolean
        {
            return (this._timelineOverEntity);
        }

        public function get timelineOverEntityId():int
        {
            return (this._timelineOverEntityId);
        }

        public function get showPermanentTooltips():Boolean
        {
            return (this._showPermanentTooltips);
        }

        public function get fightersPositionsHistory():Dictionary
        {
            return (this._fightersPositionsHistory);
        }

        public function get fighterNumPositions():Dictionary
        {
            return (this._fighterNumPositions);
        }

        public function pushed():Boolean
        {
            if (!(Kernel.beingInReconection))
            {
                Atouin.getInstance().displayGrid(true, true);
            };
            currentCell = -1;
            this._overEffectOk = new GlowFilter(0xFFFFFF, 1, 4, 4, 3, 1);
            this._overEffectKo = new GlowFilter(0xD70000, 1, 4, 4, 3, 1);
            var matrix:Array = new Array();
            matrix = matrix.concat([0.5, 0, 0, 0, 100]);
            matrix = matrix.concat([0, 0.5, 0, 0, 100]);
            matrix = matrix.concat([0, 0, 0.5, 0, 100]);
            matrix = matrix.concat([0, 0, 0, 1, 0]);
            this._linkedEffect = new ColorMatrixFilter(matrix);
            var matrix2:Array = new Array();
            matrix2 = matrix2.concat([0.5, 0, 0, 0, 0]);
            matrix2 = matrix2.concat([0, 0.5, 0, 0, 0]);
            matrix2 = matrix2.concat([0, 0, 0.5, 0, 0]);
            matrix2 = matrix2.concat([0, 0, 0, 1, 0]);
            this._linkedMainEffect = new ColorMatrixFilter(matrix2);
            this._entitiesFrame = new FightEntitiesFrame();
            this._preparationFrame = new FightPreparationFrame(this);
            this._battleFrame = new FightBattleFrame();
            this._pointCellFrame = new FightPointCellFrame();
            this._challengesList = new Array();
            this._timerFighterInfo = new Timer(100, 1);
            this._timerFighterInfo.addEventListener(TimerEvent.TIMER, this.showFighterInfo, false, 0, true);
            this._timerMovementRange = new Timer(200, 1);
            this._timerMovementRange.addEventListener(TimerEvent.TIMER, this.showMovementRange, false, 0, true);
            if (MapDisplayManager.getInstance().getDataMapContainer())
            {
                MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(false);
            };
            if (Kernel.getWorker().contains(MonstersInfoFrame))
            {
                Kernel.getWorker().removeFrame((Kernel.getWorker().getFrame(MonstersInfoFrame) as MonstersInfoFrame));
            };
            this._showPermanentTooltips = OptionManager.getOptionManager("dofus")["showPermanentTargetsTooltips"];
            OptionManager.getOptionManager("dofus").addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE, this.onUiUnloaded);
            return (true);
        }

        private function onUiUnloaded(pEvent:UiUnloadEvent):void
        {
            var entityId:int;
            if (((this._showPermanentTooltips) && (this.battleFrame)))
            {
                for each (entityId in this.battleFrame.targetedEntities)
                {
                    this.displayEntityTooltip(entityId);
                };
            };
        }

        public function getFighterName(fighterId:int):String
        {
            var fighterInfos:GameFightFighterInformations;
            var _local_3:GameFightCompanionInformations;
            var _local_4:String;
            var _local_5:String;
            var _local_6:GameFightTaxCollectorInformations;
            var masterName:String;
            fighterInfos = this.getFighterInfos(fighterId);
            if (!(fighterInfos))
            {
                return ("Unknown Fighter");
            };
            switch (true)
            {
                case (fighterInfos is GameFightFighterNamedInformations):
                    return ((fighterInfos as GameFightFighterNamedInformations).name);
                case (fighterInfos is GameFightMonsterInformations):
                    return (Monster.getMonsterById((fighterInfos as GameFightMonsterInformations).creatureGenericId).name);
                case (fighterInfos is GameFightCompanionInformations):
                    _local_3 = (fighterInfos as GameFightCompanionInformations);
                    _local_5 = Companion.getCompanionById(_local_3.companionGenericId).name;
                    if (_local_3.masterId != PlayedCharacterManager.getInstance().id)
                    {
                        masterName = this.getFighterName(_local_3.masterId);
                        _local_4 = I18n.getUiText("ui.common.belonging", [_local_5, masterName]);
                    }
                    else
                    {
                        _local_4 = _local_5;
                    };
                    return (_local_4);
                case (fighterInfos is GameFightTaxCollectorInformations):
                    _local_6 = (fighterInfos as GameFightTaxCollectorInformations);
                    return (((TaxCollectorFirstname.getTaxCollectorFirstnameById(_local_6.firstNameId).firstname + " ") + TaxCollectorName.getTaxCollectorNameById(_local_6.lastNameId).name));
            };
            return ("Unknown Fighter Type");
        }

        public function getFighterStatus(fighterId:int):uint
        {
            var fighterInfos:GameFightFighterInformations = this.getFighterInfos(fighterId);
            if (!(fighterInfos))
            {
                return (1);
            };
            switch (true)
            {
                case (fighterInfos is GameFightFighterNamedInformations):
                    return ((fighterInfos as GameFightFighterNamedInformations).status.statusId);
            };
            return (1);
        }

        public function getFighterLevel(fighterId:int):uint
        {
            var fighterInfos:GameFightFighterInformations;
            var _local_3:Monster;
            fighterInfos = this.getFighterInfos(fighterId);
            if (!(fighterInfos))
            {
                return (0);
            };
            switch (true)
            {
                case (fighterInfos is GameFightMutantInformations):
                    return ((fighterInfos as GameFightMutantInformations).powerLevel);
                case (fighterInfos is GameFightCharacterInformations):
                    return ((fighterInfos as GameFightCharacterInformations).level);
                case (fighterInfos is GameFightCompanionInformations):
                    return ((fighterInfos as GameFightCompanionInformations).level);
                case (fighterInfos is GameFightMonsterInformations):
                    _local_3 = Monster.getMonsterById((fighterInfos as GameFightMonsterInformations).creatureGenericId);
                    return (_local_3.getMonsterGrade((fighterInfos as GameFightMonsterInformations).creatureGrade).level);
                case (fighterInfos is GameFightTaxCollectorInformations):
                    return ((fighterInfos as GameFightTaxCollectorInformations).level);
            };
            return (0);
        }

        public function getChallengeById(challengeId:uint):ChallengeWrapper
        {
            var challenge:ChallengeWrapper;
            for each (challenge in this._challengesList)
            {
                if (challenge.id == challengeId)
                {
                    return (challenge);
                };
            };
            return (null);
        }

        public function process(msg:Message):Boolean
        {
            var ttEntityId:*;
            var _local_3:GameFightStartingMessage;
            var _local_4:CurrentMapMessage;
            var _local_5:WorldPointWrapper;
            var _local_6:ByteArray;
            var _local_7:GameContextReadyMessage;
            var _local_8:GameFightResumeMessage;
            var _local_9:int;
            var _local_10:Vector.<GameFightResumeSlaveInfo>;
            var _local_11:GameFightResumeSlaveInfo;
            var _local_12:CurrentPlayedFighterManager;
            var _local_13:int;
            var _local_14:int;
            var _local_15:GameFightResumeSlaveInfo;
            var _local_16:SpellCastInFightManager;
            var _local_17:Array;
            var _local_18:Array;
            var _local_19:Array;
            var _local_20:CastingSpell;
            var _local_21:uint;
            var _local_22:FightDispellableEffectExtendedInformations;
            var _local_23:GameFightUpdateTeamMessage;
            var _local_24:GameFightSpectateMessage;
            var _local_25:Number;
            var _local_26:String;
            var _local_27:String;
            var _local_28:Array;
            var _local_29:Array;
            var _local_30:Array;
            var _local_31:CastingSpell;
            var _local_32:GameFightSpectatorJoinMessage;
            var _local_33:int;
            var _local_34:String;
            var _local_35:String;
            var _local_36:GameFightJoinMessage;
            var _local_37:int;
            var _local_38:GameActionFightCarryCharacterMessage;
            var _local_39:CellOverMessage;
            var _local_40:AnimatedCharacter;
            var _local_41:MarkedCellsManager;
            var _local_42:MarkInstance;
            var _local_43:CellOutMessage;
            var _local_44:AnimatedCharacter;
            var _local_45:MarkedCellsManager;
            var _local_46:MarkInstance;
            var _local_47:EntityMouseOverMessage;
            var _local_48:EntityMouseOutMessage;
            var _local_49:GameFightLeaveMessage;
            var _local_50:TimelineEntityOverAction;
            var _local_51:FightSpellCastFrame;
            var _local_52:TimelineEntityOutAction;
            var _local_53:int;
            var _local_54:Vector.<int>;
            var _local_55:TogglePointCellAction;
            var _local_56:GameFightEndMessage;
            var _local_57:ChallengeTargetsListRequestAction;
            var _local_58:ChallengeTargetsListRequestMessage;
            var _local_59:ChallengeTargetsListMessage;
            var _local_60:ChallengeInfoMessage;
            var _local_61:ChallengeWrapper;
            var _local_62:ChallengeTargetUpdateMessage;
            var _local_63:ChallengeResultMessage;
            var _local_64:MapObstacleUpdateMessage;
            var _local_65:GameActionFightNoSpellCastMessage;
            var _local_66:uint;
            var decryptionKeyString:String;
            var gfrwsmsg:GameFightResumeWithSlavesMessage;
            var buffTmp:BasicBuff;
            var namedTeam:NamedPartyTeam;
            var buffS:FightDispellableEffectExtendedInformations;
            var buffTmpS:BasicBuff;
            var namedTeam2:NamedPartyTeam;
            var entity:IEntity;
            var mi:MarkInstance;
            var glyph:Glyph;
            var mpWithPortals:Vector.<MapPoint>;
            var links:Vector.<uint>;
            var entity2:IEntity;
            var miOut:MarkInstance;
            var glyphOut:Glyph;
            var _local_82:FightEndingMessage;
            var _local_83:Vector.<FightResultEntryWrapper>;
            var _local_84:uint;
            var _local_85:FightResultEntryWrapper;
            var _local_86:Vector.<FightResultEntryWrapper>;
            var _local_87:Array;
            var _local_88:FightResultListEntry;
            var _local_89:String;
            var _local_90:String;
            var _local_91:NamedPartyTeamWithOutcome;
            var _local_92:Object;
            var frew:FightResultEntryWrapper;
            var id:int;
            var resultEntry:FightResultListEntry;
            var currentWinner:uint;
            var loot:ItemWrapper;
            var kamas:int;
            var kamasPerWinner:int;
            var winner:FightResultEntryWrapper;
            var cell:Number;
            var mo:MapObstacle;
            var sl:SpellLevel;
            switch (true)
            {
                case (msg is MapLoadedMessage):
                    MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(false);
                    return (true);
                case (msg is GameFightStartingMessage):
                    _local_3 = (msg as GameFightStartingMessage);
                    TooltipManager.hideAll();
                    Atouin.getInstance().cancelZoom();
                    KernelEventsManager.getInstance().processCallback(HookList.StartZoom, false);
                    MapDisplayManager.getInstance().activeIdentifiedElements(false);
                    FightEventsHelper.reset();
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightStarting, _local_3.fightType);
                    this.fightType = _local_3.fightType;
                    this._fightAttackerId = _local_3.attackerId;
                    CurrentPlayedFighterManager.getInstance().currentFighterId = PlayedCharacterManager.getInstance().id;
                    CurrentPlayedFighterManager.getInstance().getSpellCastManager().currentTurn = 0;
                    SoundManager.getInstance().manager.prepareFightMusic();
                    SoundManager.getInstance().manager.playUISound(UISoundEnum.INTRO_FIGHT);
                    return (true);
                case (msg is CurrentMapMessage):
                    _local_4 = (msg as CurrentMapMessage);
                    ConnectionsHandler.pause();
                    Kernel.getWorker().pause();
                    if (TacticModeManager.getInstance().tacticModeActivated)
                    {
                        TacticModeManager.getInstance().hide();
                    };
                    _local_5 = new WorldPointWrapper(_local_4.mapId);
                    KernelEventsManager.getInstance().processCallback(HookList.StartZoom, false);
                    Atouin.getInstance().initPreDisplay(_local_5);
                    Atouin.getInstance().clearEntities();
                    if (((_local_4.mapKey) && (_local_4.mapKey.length)))
                    {
                        decryptionKeyString = XmlConfig.getInstance().getEntry("config.maps.encryptionKey");
                        if (!(decryptionKeyString))
                        {
                            decryptionKeyString = _local_4.mapKey;
                        };
                        _local_6 = Hex.toArray(Hex.fromString(decryptionKeyString));
                    };
                    this._currentMapRenderId = Atouin.getInstance().display(_local_5, _local_6);
                    _log.info(("Ask map render for fight #" + this._currentMapRenderId));
                    PlayedCharacterManager.getInstance().currentMap = _local_5;
                    KernelEventsManager.getInstance().processCallback(HookList.CurrentMap, _local_4.mapId);
                    return (true);
                case (msg is MapsLoadingCompleteMessage):
                    _log.info(("MapsLoadingCompleteMessage #" + MapsLoadingCompleteMessage(msg).renderRequestId));
                    if (this._currentMapRenderId != MapsLoadingCompleteMessage(msg).renderRequestId)
                    {
                        return (false);
                    };
                    Atouin.getInstance().showWorld(true);
                    Atouin.getInstance().displayGrid(true, true);
                    Atouin.getInstance().cellOverEnabled = true;
                    _local_7 = new GameContextReadyMessage();
                    _local_7.initGameContextReadyMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                    ConnectionsHandler.getConnection().send(_local_7);
                    Kernel.getWorker().resume();
                    ConnectionsHandler.resume();
                    return (true);
                case (msg is GameFightResumeMessage):
                    _local_8 = (msg as GameFightResumeMessage);
                    _local_9 = PlayedCharacterManager.getInstance().id;
                    this.tacticModeHandler();
                    CurrentPlayedFighterManager.getInstance().setCurrentSummonedCreature(_local_8.summonCount, _local_9);
                    CurrentPlayedFighterManager.getInstance().setCurrentSummonedBomb(_local_8.bombCount, _local_9);
                    this._battleFrame.turnsCount = (_local_8.gameTurn - 1);
                    KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated, (_local_8.gameTurn - 1));
                    if ((msg is GameFightResumeWithSlavesMessage))
                    {
                        gfrwsmsg = (msg as GameFightResumeWithSlavesMessage);
                        _local_10 = gfrwsmsg.slavesInfo;
                    }
                    else
                    {
                        _local_10 = new Vector.<GameFightResumeSlaveInfo>();
                    };
                    _local_11 = new GameFightResumeSlaveInfo();
                    _local_11.spellCooldowns = _local_8.spellCooldowns;
                    _local_11.slaveId = PlayedCharacterManager.getInstance().id;
                    _local_10.unshift(_local_11);
                    _local_12 = CurrentPlayedFighterManager.getInstance();
                    _local_14 = _local_10.length;
                    _local_13 = 0;
                    while (_local_13 < _local_14)
                    {
                        _local_15 = _local_10[_local_13];
                        _local_16 = _local_12.getSpellCastManagerById(_local_15.slaveId);
                        _local_16.currentTurn = (_local_8.gameTurn - 1);
                        _local_16.updateCooldowns(_local_10[_local_13].spellCooldowns);
                        if (_local_15.slaveId != _local_9)
                        {
                            CurrentPlayedFighterManager.getInstance().setCurrentSummonedCreature(_local_15.summonCount, _local_15.slaveId);
                            CurrentPlayedFighterManager.getInstance().setCurrentSummonedBomb(_local_15.bombCount, _local_15.slaveId);
                        };
                        _local_13++;
                    };
                    _local_17 = [];
                    _local_21 = _local_8.effects.length;
                    _local_13 = 0;
                    while (_local_13 < _local_21)
                    {
                        _local_22 = _local_8.effects[_local_13];
                        if (!(_local_17[_local_22.effect.targetId]))
                        {
                            _local_17[_local_22.effect.targetId] = [];
                        };
                        _local_18 = _local_17[_local_22.effect.targetId];
                        if (!(_local_18[_local_22.effect.turnDuration]))
                        {
                            _local_18[_local_22.effect.turnDuration] = [];
                        };
                        _local_19 = _local_18[_local_22.effect.turnDuration];
                        _local_20 = _local_19[_local_22.effect.spellId];
                        if (!(_local_20))
                        {
                            _local_20 = new CastingSpell();
                            _local_20.casterId = _local_22.sourceId;
                            _local_20.spell = Spell.getSpellById(_local_22.effect.spellId);
                            _local_19[_local_22.effect.spellId] = _local_20;
                        };
                        buffTmp = BuffManager.makeBuffFromEffect(_local_22.effect, _local_20, _local_22.actionId);
                        BuffManager.getInstance().addBuff(buffTmp);
                        _local_13++;
                    };
                    this.addMarks(_local_8.marks);
                    Kernel.beingInReconection = false;
                    return (true);
                case (msg is GameFightUpdateTeamMessage):
                    _local_23 = (msg as GameFightUpdateTeamMessage);
                    PlayedCharacterManager.getInstance().teamId = _local_23.team.teamId;
                    return (true);
                case (msg is GameFightSpectateMessage):
                    _local_24 = (msg as GameFightSpectateMessage);
                    this.tacticModeHandler();
                    this._battleFrame.turnsCount = (_local_24.gameTurn - 1);
                    KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated, (_local_24.gameTurn - 1));
                    _local_25 = _local_24.fightStart;
                    _local_26 = "";
                    _local_27 = "";
                    for each (namedTeam in this._namedPartyTeams)
                    {
                        if (((namedTeam.partyName) && (!((namedTeam.partyName == "")))))
                        {
                            if (namedTeam.teamId == TeamEnum.TEAM_CHALLENGER)
                            {
                                _local_26 = namedTeam.partyName;
                            }
                            else
                            {
                                if (namedTeam.teamId == TeamEnum.TEAM_DEFENDER)
                                {
                                    _local_27 = namedTeam.partyName;
                                };
                            };
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(FightHookList.SpectateUpdate, _local_25, _local_26, _local_27);
                    _local_28 = [];
                    for each (buffS in _local_24.effects)
                    {
                        if (!(_local_28[buffS.effect.targetId]))
                        {
                            _local_28[buffS.effect.targetId] = [];
                        };
                        _local_29 = _local_28[buffS.effect.targetId];
                        if (!(_local_29[buffS.effect.turnDuration]))
                        {
                            _local_29[buffS.effect.turnDuration] = [];
                        };
                        _local_30 = _local_29[buffS.effect.turnDuration];
                        _local_31 = _local_30[buffS.effect.spellId];
                        if (!(_local_31))
                        {
                            _local_31 = new CastingSpell();
                            _local_31.casterId = buffS.sourceId;
                            _local_31.spell = Spell.getSpellById(buffS.effect.spellId);
                            _local_30[buffS.effect.spellId] = _local_31;
                        };
                        buffTmpS = BuffManager.makeBuffFromEffect(buffS.effect, _local_31, buffS.actionId);
                        BuffManager.getInstance().addBuff(buffTmpS, !((buffTmpS is StatBuff)));
                    };
                    this.addMarks(_local_24.marks);
                    FightEventsHelper.sendAllFightEvent();
                    return (true);
                case (msg is GameFightSpectatorJoinMessage):
                    _local_32 = (msg as GameFightSpectatorJoinMessage);
                    preFightIsActive = !(_local_32.isFightStarted);
                    this.fightType = _local_32.fightType;
                    Kernel.getWorker().addFrame(this._entitiesFrame);
                    if (preFightIsActive)
                    {
                        Kernel.getWorker().addFrame(this._preparationFrame);
                    }
                    else
                    {
                        Kernel.getWorker().removeFrame(this._preparationFrame);
                        Kernel.getWorker().addFrame(this._battleFrame);
                        KernelEventsManager.getInstance().processCallback(HookList.GameFightStart);
                    };
                    PlayedCharacterManager.getInstance().isSpectator = true;
                    PlayedCharacterManager.getInstance().isFighting = true;
                    _local_33 = _local_32.timeMaxBeforeFightStart;
                    if ((((_local_33 == 0)) && (preFightIsActive)))
                    {
                        _local_33 = -1;
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightJoin, _local_32.canBeCancelled, _local_32.canSayReady, true, _local_33, _local_32.fightType);
                    this._namedPartyTeams = _local_32.namedPartyTeams;
                    _local_34 = "";
                    _local_35 = "";
                    for each (namedTeam2 in _local_32.namedPartyTeams)
                    {
                        if (((namedTeam2.partyName) && (!((namedTeam2.partyName == "")))))
                        {
                            if (namedTeam2.teamId == TeamEnum.TEAM_CHALLENGER)
                            {
                                _local_34 = namedTeam2.partyName;
                            }
                            else
                            {
                                if (namedTeam2.teamId == TeamEnum.TEAM_DEFENDER)
                                {
                                    _local_35 = namedTeam2.partyName;
                                };
                            };
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(FightHookList.SpectateUpdate, 0, _local_34, _local_35);
                    return (true);
                case (((msg is INetworkMessage)) && ((INetworkMessage(msg).getMessageId() == GameFightJoinMessage.protocolId))):
                    _local_36 = (msg as GameFightJoinMessage);
                    preFightIsActive = !(_local_36.isFightStarted);
                    this.fightType = _local_36.fightType;
                    Kernel.getWorker().addFrame(this._entitiesFrame);
                    if (preFightIsActive)
                    {
                        Kernel.getWorker().addFrame(this._preparationFrame);
                    }
                    else
                    {
                        Kernel.getWorker().removeFrame(this._preparationFrame);
                        Kernel.getWorker().addFrame(this._battleFrame);
                        KernelEventsManager.getInstance().processCallback(HookList.GameFightStart);
                    };
                    PlayedCharacterManager.getInstance().isSpectator = false;
                    PlayedCharacterManager.getInstance().isFighting = true;
                    _local_37 = _local_36.timeMaxBeforeFightStart;
                    if ((((_local_37 == 0)) && (preFightIsActive)))
                    {
                        _local_37 = -1;
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightJoin, _local_36.canBeCancelled, _local_36.canSayReady, false, _local_37, _local_36.fightType);
                    return (true);
                case (msg is GameActionFightCarryCharacterMessage):
                    _local_38 = (msg as GameActionFightCarryCharacterMessage);
                    if (((this._lastEffectEntity) && ((this._lastEffectEntity.object.id == _local_38.targetId))))
                    {
                        this.process(new EntityMouseOutMessage((this._lastEffectEntity.object as IInteractive)));
                    };
                    return (false);
                case (msg is GameFightStartMessage):
                    preFightIsActive = false;
                    Kernel.getWorker().removeFrame(this._preparationFrame);
                    this._entitiesFrame.removeSwords();
                    CurrentPlayedFighterManager.getInstance().getSpellCastManager().resetInitialCooldown();
                    Kernel.getWorker().addFrame(this._battleFrame);
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightStart);
                    SoundManager.getInstance().manager.playFightMusic();
                    return (true);
                case (msg is GameContextDestroyMessage):
                    TooltipManager.hide();
                    Kernel.getWorker().removeFrame(this);
                    return (true);
                case (msg is CellOverMessage):
                    _local_39 = (msg as CellOverMessage);
                    for each (entity in EntitiesManager.getInstance().getEntitiesOnCell(_local_39.cellId))
                    {
                        if ((((entity is AnimatedCharacter)) && (!((entity as AnimatedCharacter).isMoving))))
                        {
                            _local_40 = (entity as AnimatedCharacter);
                            break;
                        };
                    };
                    currentCell = _local_39.cellId;
                    if (_local_40)
                    {
                        this.overEntity(_local_40.id);
                    };
                    _local_41 = MarkedCellsManager.getInstance();
                    _local_42 = _local_41.getMarkAtCellId(_local_39.cellId, GameActionMarkTypeEnum.PORTAL);
                    if (_local_42)
                    {
                        for each (mi in _local_41.getMarks(_local_42.markType, _local_42.teamId, false))
                        {
                            glyph = _local_41.getGlyph(mi.markId);
                            if (((glyph) && (glyph.lbl_number)))
                            {
                                glyph.lbl_number.visible = true;
                            };
                        };
                        if (((_local_42.active) && ((_local_41.getActivePortalsCount(_local_42.teamId) >= 2))))
                        {
                            mpWithPortals = _local_41.getMarksMapPoint(GameActionMarkTypeEnum.PORTAL, _local_42.teamId);
                            links = LinkedCellsManager.getInstance().getLinks(MapPoint.fromCellId(_local_39.cellId), mpWithPortals);
                            if (links)
                            {
                                LinkedCellsManager.getInstance().drawPortalLinks(links);
                            };
                        };
                    };
                    return (true);
                case (msg is CellOutMessage):
                    _local_43 = (msg as CellOutMessage);
                    for each (entity2 in EntitiesManager.getInstance().getEntitiesOnCell(_local_43.cellId))
                    {
                        if ((entity2 is AnimatedCharacter))
                        {
                            _local_44 = (entity2 as AnimatedCharacter);
                            break;
                        };
                    };
                    currentCell = -1;
                    if (_local_44)
                    {
                        TooltipManager.hide();
                        TooltipManager.hide("fighter");
                        this.outEntity(_local_44.id);
                    };
                    _local_45 = MarkedCellsManager.getInstance();
                    _local_46 = _local_45.getMarkAtCellId(_local_43.cellId, GameActionMarkTypeEnum.PORTAL);
                    if (_local_46)
                    {
                        for each (miOut in _local_45.getMarks(_local_46.markType, _local_46.teamId, false))
                        {
                            glyphOut = _local_45.getGlyph(miOut.markId);
                            if (((glyphOut) && (glyphOut.lbl_number)))
                            {
                                glyphOut.lbl_number.visible = false;
                            };
                        };
                    };
                    LinkedCellsManager.getInstance().clearLinks();
                    return (true);
                case (msg is EntityMouseOverMessage):
                    _local_47 = (msg as EntityMouseOverMessage);
                    currentCell = _local_47.entity.position.cellId;
                    this.overEntity(_local_47.entity.id);
                    return (true);
                case (msg is EntityMouseOutMessage):
                    _local_48 = (msg as EntityMouseOutMessage);
                    currentCell = -1;
                    this.outEntity(_local_48.entity.id);
                    return (true);
                case (msg is GameFightLeaveMessage):
                    _local_49 = (msg as GameFightLeaveMessage);
                    if (TooltipManager.isVisible(("tooltipOverEntity_" + _local_49.charId)))
                    {
                        currentCell = -1;
                        this.outEntity(_local_49.charId);
                    };
                    return (false);
                case (msg is TimelineEntityOverAction):
                    _local_50 = (msg as TimelineEntityOverAction);
                    this._timelineOverEntity = true;
                    this._timelineOverEntityId = _local_50.targetId;
                    this.removeSpellTargetsTooltips();
                    _local_51 = (Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame);
                    if (_local_51)
                    {
                        _local_51.refreshTarget();
                    };
                    this.overEntity(_local_50.targetId, _local_50.showRange);
                    return (true);
                case (msg is TimelineEntityOutAction):
                    _local_52 = (msg as TimelineEntityOutAction);
                    _local_54 = this._entitiesFrame.getEntitiesIdsList();
                    for each (_local_53 in _local_54)
                    {
                        if (((((!(this._showPermanentTooltips)) || (((this._showPermanentTooltips) && ((this._battleFrame.targetedEntities.indexOf(_local_53) == -1)))))) && (!((_local_53 == _local_52.targetId)))))
                        {
                            TooltipManager.hide(("tooltipOverEntity_" + _local_53));
                        };
                    };
                    this._timelineOverEntity = false;
                    this.outEntity(_local_52.targetId);
                    this.removeSpellTargetsTooltips();
                    return (true);
                case (msg is TogglePointCellAction):
                    _local_55 = (msg as TogglePointCellAction);
                    if (Kernel.getWorker().contains(FightPointCellFrame))
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.ShowCell);
                        Kernel.getWorker().removeFrame(this._pointCellFrame);
                    }
                    else
                    {
                        Kernel.getWorker().addFrame(this._pointCellFrame);
                    };
                    return (true);
                case (msg is GameFightEndMessage):
                    _local_56 = (msg as GameFightEndMessage);
                    if (TacticModeManager.getInstance().tacticModeActivated)
                    {
                        TacticModeManager.getInstance().hide(true);
                    };
                    if (this._entitiesFrame.isInCreaturesFightMode())
                    {
                        this._entitiesFrame.showCreaturesInFight(false);
                    };
                    TooltipManager.hide();
                    TooltipManager.hide("fighter");
                    this.hideMovementRange();
                    CurrentPlayedFighterManager.getInstance().resetPlayerSpellList();
                    MapDisplayManager.getInstance().activeIdentifiedElements(true);
                    FightEventsHelper.sendAllFightEvent(true);
                    if (!(PlayedCharacterManager.getInstance().isSpectator))
                    {
                        FightEventsHelper.sendFightEvent(FightEventEnum.FIGHT_END, [], 0, -1, true);
                    };
                    SoundManager.getInstance().manager.stopFightMusic();
                    PlayedCharacterManager.getInstance().isFighting = false;
                    SpellWrapper.removeAllSpellWrapperBut(PlayedCharacterManager.getInstance().id, SecureCenter.ACCESS_KEY);
                    SpellWrapper.resetAllCoolDown(PlayedCharacterManager.getInstance().id, SecureCenter.ACCESS_KEY);
                    if (_local_56.results == null)
                    {
                        KernelEventsManager.getInstance().processCallback(FightHookList.SpectatorWantLeave);
                    }
                    else
                    {
                        _local_82 = new FightEndingMessage();
                        _local_82.initFightEndingMessage();
                        Kernel.getWorker().process(_local_82);
                        _local_83 = new Vector.<FightResultEntryWrapper>();
                        _local_84 = 0;
                        _local_86 = new Vector.<FightResultEntryWrapper>();
                        _local_87 = new Array();
                        for each (_local_88 in _local_56.results)
                        {
                            _local_87.push(_local_88);
                        };
                        _local_13 = 0;
                        while (_local_13 < _local_87.length)
                        {
                            resultEntry = _local_87[_local_13];
                            switch (true)
                            {
                                case (resultEntry is FightResultPlayerListEntry):
                                    id = (resultEntry as FightResultPlayerListEntry).id;
                                    frew = new FightResultEntryWrapper(resultEntry, (this._entitiesFrame.getEntityInfos(id) as GameFightFighterInformations));
                                    frew.alive = FightResultPlayerListEntry(resultEntry).alive;
                                    break;
                                case (resultEntry is FightResultTaxCollectorListEntry):
                                    id = (resultEntry as FightResultTaxCollectorListEntry).id;
                                    frew = new FightResultEntryWrapper(resultEntry, (this._entitiesFrame.getEntityInfos(id) as GameFightFighterInformations));
                                    frew.alive = FightResultTaxCollectorListEntry(resultEntry).alive;
                                    break;
                                case (resultEntry is FightResultFighterListEntry):
                                    id = (resultEntry as FightResultFighterListEntry).id;
                                    frew = new FightResultEntryWrapper(resultEntry, (this._entitiesFrame.getEntityInfos(id) as GameFightFighterInformations));
                                    frew.alive = FightResultFighterListEntry(resultEntry).alive;
                                    break;
                                case (resultEntry is FightResultListEntry):
                                    frew = new FightResultEntryWrapper(resultEntry);
                                    break;
                            };
                            if (this._fightAttackerId == id)
                            {
                                frew.fightInitiator = true;
                            }
                            else
                            {
                                frew.fightInitiator = false;
                            };
                            frew.wave = resultEntry.wave;
                            if (((((((((_local_13 + 1) < _local_87.length)) && (_local_87[(_local_13 + 1)]))) && ((_local_87[(_local_13 + 1)].outcome == resultEntry.outcome)))) && (!((_local_87[(_local_13 + 1)].wave == resultEntry.wave)))))
                            {
                                frew.isLastOfHisWave = true;
                            };
                            if (resultEntry.outcome == FightOutcomeEnum.RESULT_DEFENDER_GROUP)
                            {
                                _local_85 = frew;
                            }
                            else
                            {
                                if (resultEntry.outcome == FightOutcomeEnum.RESULT_VICTORY)
                                {
                                    _local_86.push(frew);
                                };
                                var _local_104 = _local_84++;
                                _local_83[_local_104] = frew;
                            };
                            if (frew.id == PlayedCharacterManager.getInstance().id)
                            {
                                switch (resultEntry.outcome)
                                {
                                    case FightOutcomeEnum.RESULT_VICTORY:
                                        KernelEventsManager.getInstance().processCallback(TriggerHookList.FightResultVictory);
                                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_FIGHT_WON);
                                        break;
                                    case FightOutcomeEnum.RESULT_LOST:
                                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_FIGHT_LOST);
                                        break;
                                };
                                if (frew.rewards.objects.length >= SpeakingItemManager.GREAT_DROP_LIMIT)
                                {
                                    SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_GREAT_DROP);
                                };
                            };
                            _local_13++;
                        };
                        if (_local_85)
                        {
                            currentWinner = 0;
                            for each (loot in _local_85.rewards.objects)
                            {
                                _local_86[currentWinner].rewards.objects.push(loot);
                                currentWinner++;
                                currentWinner = (currentWinner % _local_86.length);
                            };
                            kamas = _local_85.rewards.kamas;
                            kamasPerWinner = (kamas / _local_86.length);
                            if ((kamas % _local_86.length) != 0)
                            {
                                kamasPerWinner++;
                            };
                            for each (winner in _local_86)
                            {
                                if (kamas < kamasPerWinner)
                                {
                                    winner.rewards.kamas = kamas;
                                }
                                else
                                {
                                    winner.rewards.kamas = kamasPerWinner;
                                };
                                kamas = (kamas - winner.rewards.kamas);
                            };
                        };
                        _local_89 = "";
                        _local_90 = "";
                        for each (_local_91 in _local_56.namedPartyTeamsOutcomes)
                        {
                            if (((_local_91.team.partyName) && (!((_local_91.team.partyName == "")))))
                            {
                                if (_local_91.outcome == FightOutcomeEnum.RESULT_VICTORY)
                                {
                                    _local_89 = _local_91.team.partyName;
                                }
                                else
                                {
                                    if (_local_91.outcome == FightOutcomeEnum.RESULT_LOST)
                                    {
                                        _local_90 = _local_91.team.partyName;
                                    };
                                };
                            };
                        };
                        _local_92 = new Object();
                        _local_92.results = _local_83;
                        _local_92.ageBonus = _local_56.ageBonus;
                        _local_92.sizeMalus = _local_56.lootShareLimitMalus;
                        _local_92.duration = _local_56.duration;
                        _local_92.challenges = this.challengesList;
                        _local_92.turns = this._battleFrame.turnsCount;
                        _local_92.fightType = this._fightType;
                        _local_92.winnersName = _local_89;
                        _local_92.losersName = _local_90;
                        KernelEventsManager.getInstance().processCallback(HookList.GameFightEnd, _local_92);
                    };
                    Kernel.getWorker().removeFrame(this);
                    return (true);
                case (msg is ChallengeTargetsListRequestAction):
                    _local_57 = (msg as ChallengeTargetsListRequestAction);
                    _local_58 = new ChallengeTargetsListRequestMessage();
                    _local_58.initChallengeTargetsListRequestMessage(_local_57.challengeId);
                    ConnectionsHandler.getConnection().send(_local_58);
                    return (true);
                case (msg is ChallengeTargetsListMessage):
                    _local_59 = (msg as ChallengeTargetsListMessage);
                    for each (cell in _local_59.targetCells)
                    {
                        if (cell != -1)
                        {
                            HyperlinkShowCellManager.showCell(cell);
                        };
                    };
                    return (true);
                case (msg is ChallengeInfoMessage):
                    _local_60 = (msg as ChallengeInfoMessage);
                    _local_61 = this.getChallengeById(_local_60.challengeId);
                    if (!(_local_61))
                    {
                        _local_61 = new ChallengeWrapper();
                        this.challengesList.push(_local_61);
                    };
                    _local_61.id = _local_60.challengeId;
                    _local_61.targetId = _local_60.targetId;
                    _local_61.xpBonus = _local_60.xpBonus;
                    _local_61.dropBonus = _local_60.dropBonus;
                    _local_61.result = 0;
                    KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeInfoUpdate, this.challengesList);
                    return (true);
                case (msg is ChallengeTargetUpdateMessage):
                    _local_62 = (msg as ChallengeTargetUpdateMessage);
                    _local_61 = this.getChallengeById(_local_62.challengeId);
                    if (_local_61 == null)
                    {
                        _log.warn((("Got a challenge result with no corresponding challenge (challenge id " + _local_62.challengeId) + "), skipping."));
                        return (false);
                    };
                    _local_61.targetId = _local_62.targetId;
                    KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeInfoUpdate, this.challengesList);
                    return (true);
                case (msg is ChallengeResultMessage):
                    _local_63 = (msg as ChallengeResultMessage);
                    _local_61 = this.getChallengeById(_local_63.challengeId);
                    if (!(_local_61))
                    {
                        _log.warn((("Got a challenge result with no corresponding challenge (challenge id " + _local_63.challengeId) + "), skipping."));
                        return (false);
                    };
                    _local_61.result = ((_local_63.success) ? 1 : 2);
                    KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeInfoUpdate, this.challengesList);
                    return (true);
                case (msg is MapObstacleUpdateMessage):
                    _local_64 = (msg as MapObstacleUpdateMessage);
                    for each (mo in _local_64.obstacles)
                    {
                        InteractiveCellManager.getInstance().updateCell(mo.obstacleCellId, (mo.state == MapObstacleStateEnum.OBSTACLE_OPENED));
                    };
                    return (true);
                case (msg is GameActionFightNoSpellCastMessage):
                    _local_65 = (msg as GameActionFightNoSpellCastMessage);
                    if (((!((_local_65.spellLevelId == 0))) || (!(PlayedCharacterManager.getInstance().currentWeapon))))
                    {
                        if (_local_65.spellLevelId == 0)
                        {
                            sl = Spell.getSpellById(0).getSpellLevel(1);
                        }
                        else
                        {
                            sl = SpellLevel.getLevelById(_local_65.spellLevelId);
                        };
                        _local_66 = sl.apCost;
                    }
                    else
                    {
                        _local_66 = PlayedCharacterManager.getInstance().currentWeapon.apCost;
                    };
                    CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent = (CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent + _local_66);
                    return (true);
                case (msg is ShowTacticModeAction):
                    if (PlayedCharacterApi.isInPreFight())
                    {
                        return (false);
                    };
                    if (((PlayedCharacterApi.isInFight()) || (PlayedCharacterManager.getInstance().isSpectator)))
                    {
                        this.tacticModeHandler(true);
                    };
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            if (TacticModeManager.getInstance().tacticModeActivated)
            {
                TacticModeManager.getInstance().hide(true);
            };
            if (this._entitiesFrame)
            {
                Kernel.getWorker().removeFrame(this._entitiesFrame);
            };
            if (this._preparationFrame)
            {
                Kernel.getWorker().removeFrame(this._preparationFrame);
            };
            if (this._battleFrame)
            {
                Kernel.getWorker().removeFrame(this._battleFrame);
            };
            if (this._pointCellFrame)
            {
                Kernel.getWorker().removeFrame(this._pointCellFrame);
            };
            SerialSequencer.clearByType(FightSequenceFrame.FIGHT_SEQUENCERS_CATEGORY);
            this._preparationFrame = null;
            this._battleFrame = null;
            this._pointCellFrame = null;
            this._lastEffectEntity = null;
            TooltipManager.hideAll();
            this._timerFighterInfo.reset();
            this._timerFighterInfo.removeEventListener(TimerEvent.TIMER, this.showFighterInfo);
            this._timerFighterInfo = null;
            this._timerMovementRange.reset();
            this._timerMovementRange.removeEventListener(TimerEvent.TIMER, this.showMovementRange);
            this._timerMovementRange = null;
            this._currentFighterInfo = null;
            if (MapDisplayManager.getInstance().getDataMapContainer())
            {
                MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(true);
            };
            Atouin.getInstance().displayGrid(false);
            OptionManager.getOptionManager("dofus").removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            Berilia.getInstance().removeEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE, this.onUiUnloaded);
            if (this._hideTooltipsTimer)
            {
                this._hideTooltipsTimer.removeEventListener(TimerEvent.TIMER, this.onShowPermanentTooltips);
                this._hideTooltipsTimer.stop();
            };
            if (this._hideTooltipTimer)
            {
                this._hideTooltipTimer.removeEventListener(TimerEvent.TIMER, this.onShowTooltip);
                this._hideTooltipTimer.stop();
            };
            var simf:SpellInventoryManagementFrame = (Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame);
            simf.deleteSpellsGlobalCoolDownsData();
            PlayedCharacterManager.getInstance().isSpectator = false;
            return (true);
        }

        public function outEntity(id:int):void
        {
            var entityId:int;
            this._timerFighterInfo.reset();
            this._timerMovementRange.reset();
            var entitiesIdsList:Vector.<int> = this._entitiesFrame.getEntitiesIdsList();
            fighterEntityTooltipId = id;
            var entity:IEntity = DofusEntities.getEntity(fighterEntityTooltipId);
            if (!(entity))
            {
                if (entitiesIdsList.indexOf(fighterEntityTooltipId) == -1)
                {
                    _log.warn(("Mouse over an unknown entity : " + id));
                    return;
                };
            };
            if (((this._lastEffectEntity) && (this._lastEffectEntity.object)))
            {
                Sprite(this._lastEffectEntity.object).filters = [];
            };
            this._lastEffectEntity = null;
            var ttName:String = ("tooltipOverEntity_" + id);
            if (((((!(this._showPermanentTooltips)) || (((this._showPermanentTooltips) && ((this.battleFrame.targetedEntities.indexOf(id) == -1)))))) && (TooltipManager.isVisible(ttName))))
            {
                TooltipManager.hide(ttName);
            };
            if (this._showPermanentTooltips)
            {
                for each (entityId in this.battleFrame.targetedEntities)
                {
                    this.displayEntityTooltip(entityId);
                };
            };
            if (entity != null)
            {
                Sprite(entity).filters = [];
            };
            this.hideMovementRange();
            var inviSel:Selection = SelectionManager.getInstance().getSelection(this.INVISIBLE_POSITION_SELECTION);
            if (inviSel)
            {
                inviSel.remove();
            };
            this.removeAsLinkEntityEffect();
            if (((this._currentFighterInfo) && ((this._currentFighterInfo.contextualId == id))))
            {
                KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate, null);
                if (((PlayedCharacterManager.getInstance().isSpectator) && ((OptionManager.getOptionManager("dofus")["spectatorAutoShowCurrentFighterInfo"] == true))))
                {
                    KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate, (FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._battleFrame.currentPlayerId) as GameFightFighterInformations));
                };
            };
        }

        public function removeSpellTargetsTooltips():void
        {
            var ttEntityId:*;
            PushUtil.reset();
            this._spellAlreadyTriggered = false;
            for (ttEntityId in this._spellTargetsTooltips)
            {
                TooltipPlacer.removeTooltipPositionByName(("tooltip_tooltipOverEntity_" + ttEntityId));
                delete this._spellTargetsTooltips[ttEntityId];
                TooltipManager.hide(("tooltipOverEntity_" + ttEntityId));
                delete this._spellDamages[ttEntityId];
                if (((this._showPermanentTooltips) && (!((this._battleFrame.targetedEntities.indexOf(ttEntityId) == -1)))))
                {
                    this.displayEntityTooltip(ttEntityId);
                };
            };
        }

        public function displayEntityTooltip(pEntityId:int, pSpell:Object=null, pSpellInfo:SpellDamageInfo=null, pForceRefresh:Boolean=false, pSpellImpactCell:int=-1):void
        {
            var params:Object;
            var entityDamagedOrHealedBySpell:Boolean;
            var ac:AnimatedCharacter;
            var sdi:SpellDamageInfo;
            var currentSpellDamage:SpellDamage;
            var effect:EffectDamage;
            var spellZone:IZone;
            var spellZoneCells:Vector.<uint>;
            var targetId:int;
            var directDamageSpell:SpellWrapper;
            var nbPushedEntities:uint;
            var pushedEntity:PushedEntity;
            var i:int;
            var entityPushed:Boolean;
            var pushedEntitySdi:SpellDamageInfo;
            var needRefresh:Boolean;
            var ts:TriggeredSpell;
            var triggeredSpellsByCasterOnTarget:Vector.<TriggeredSpell>;
            var triggeredSpells:Vector.<TriggeredSpell>;
            var damageSharingTargets:Vector.<int>;
            var damageWithoutResists:SpellDamage;
            var allTargets:Vector.<int>;
            var splashDamages:Vector.<SplashDamage>;
            var damageModifications:Boolean;
            var splashdmg:SplashDamage;
            var totalSpellDamage:SpellDamage;
            var nbSameSpell:int;
            var entitySpellDamage:Object;
            var sd:SpellDamage;
            var entity:IDisplayable = (DofusEntities.getEntity(pEntityId) as IDisplayable);
            var infos:GameFightFighterInformations = (this._entitiesFrame.getEntityInfos(pEntityId) as GameFightFighterInformations);
            if (((((!(entity)) || (!(infos)))) || (((!((this._battleFrame.targetedEntities.indexOf(pEntityId) == -1))) && (this._hideTooltips)))))
            {
                return;
            };
            if (((!((infos.disposition.cellId == currentCell))) && (!(((this._timelineOverEntity) && ((pEntityId == this.timelineOverEntityId)))))))
            {
                if (!(params))
                {
                    params = new Object();
                };
                params.showName = false;
            };
            var spellImpactCell:uint = ((!((pSpellImpactCell == -1))) ? pSpellImpactCell : currentCell);
            if (((pSpell) && (!(pSpellInfo))))
            {
                ac = (entity as AnimatedCharacter);
                entityDamagedOrHealedBySpell = ((pSpell) && (DamageUtil.isDamagedOrHealedBySpell(CurrentPlayedFighterManager.getInstance().currentFighterId, pEntityId, pSpell, spellImpactCell)));
                if (((((((ac) && (ac.parentSprite))) && ((ac.parentSprite.carriedEntity == ac)))) && (!(entityDamagedOrHealedBySpell))))
                {
                    TooltipPlacer.removeTooltipPositionByName(("tooltip_tooltipOverEntity_" + pEntityId));
                    return;
                };
            };
            var showDamages:Boolean = ((((pSpell) && ((OptionManager.getOptionManager("dofus")["showDamagesPreview"] == true)))) && (FightSpellCastFrame.isCurrentTargetTargetable()));
            if (showDamages)
            {
                if (((!(pForceRefresh)) && (this._spellTargetsTooltips[pEntityId])))
                {
                    return;
                };
                spellZone = SpellZoneManager.getInstance().getSpellZone(pSpell);
                spellZoneCells = spellZone.getCells(spellImpactCell);
                if (!(pSpellInfo))
                {
                    if (entityDamagedOrHealedBySpell)
                    {
                        if (DamageUtil.BOMB_SPELLS_IDS.indexOf(pSpell.id) != -1)
                        {
                            directDamageSpell = DamageUtil.getBombDirectDamageSpellWrapper((pSpell as SpellWrapper));
                            sdi = SpellDamageInfo.fromCurrentPlayer(directDamageSpell, pEntityId, spellImpactCell);
                            for each (targetId in sdi.originalTargetsIds)
                            {
                                this.displayEntityTooltip(targetId, directDamageSpell, sdi);
                            };
                            return;
                        };
                        sdi = SpellDamageInfo.fromCurrentPlayer(pSpell, pEntityId, spellImpactCell);
                        if ((pSpell is SpellWrapper))
                        {
                            sdi.pushedEntities = PushUtil.getPushedEntities((pSpell as SpellWrapper), this.entitiesFrame.getEntityInfos(pSpell.playerId).disposition.cellId, spellImpactCell);
                            nbPushedEntities = ((sdi.pushedEntities) ? sdi.pushedEntities.length : 0);
                            if (nbPushedEntities > 0)
                            {
                                i = 0;
                                while (i < nbPushedEntities)
                                {
                                    pushedEntity = sdi.pushedEntities[i];
                                    if (!(entityPushed))
                                    {
                                        entityPushed = (pEntityId == pushedEntity.id);
                                    };
                                    if (pushedEntity.id == pEntityId)
                                    {
                                        this.displayEntityTooltip(pushedEntity.id, pSpell, sdi, true);
                                    }
                                    else
                                    {
                                        pushedEntitySdi = SpellDamageInfo.fromCurrentPlayer(pSpell, pushedEntity.id, spellImpactCell);
                                        pushedEntitySdi.pushedEntities = sdi.pushedEntities;
                                        this.displayEntityTooltip(pushedEntity.id, pSpell, pushedEntitySdi, true);
                                    };
                                    i++;
                                };
                                if (entityPushed)
                                {
                                    return;
                                };
                            };
                        };
                    };
                }
                else
                {
                    sdi = pSpellInfo;
                };
                this._spellTargetsTooltips[pEntityId] = true;
                if (sdi)
                {
                    if (!(params))
                    {
                        params = new Object();
                    };
                    if (sdi.targetId != pEntityId)
                    {
                        sdi.targetId = pEntityId;
                    };
                    if (!(sdi.damageSharingTargets))
                    {
                        damageSharingTargets = sdi.getDamageSharingTargets();
                        if (((damageSharingTargets) && ((damageSharingTargets.length > 1))))
                        {
                            damageWithoutResists = DamageUtil.getSpellDamage(sdi, false, false);
                            sdi.damageSharingTargets = damageSharingTargets;
                            sdi.sharedDamage = damageWithoutResists;
                            this._spellAlreadyTriggered = true;
                            for each (targetId in damageSharingTargets)
                            {
                                needRefresh = ((!(this._spellDamages[targetId])) && (!((spellZoneCells.indexOf(this.entitiesFrame.getEntityInfos(targetId).disposition.cellId) == -1))));
                                this.displayEntityTooltip(targetId, pSpell, sdi, true);
                                if (needRefresh)
                                {
                                    this._spellTargetsTooltips[targetId] = false;
                                };
                            };
                            return;
                        };
                    };
                    triggeredSpellsByCasterOnTarget = sdi.triggeredSpellsByCasterOnTarget;
                    if (((!(this._spellAlreadyTriggered)) && (triggeredSpellsByCasterOnTarget)))
                    {
                        for each (ts in triggeredSpellsByCasterOnTarget)
                        {
                            if (ts.triggers != "I")
                            {
                                this._spellAlreadyTriggered = true;
                            };
                            for each (targetId in ts.targets)
                            {
                                needRefresh = ((!(this._spellDamages[targetId])) && (!((spellZoneCells.indexOf(this.entitiesFrame.getEntityInfos(targetId).disposition.cellId) == -1))));
                                this.displayEntityTooltip(targetId, ts.spell, null, true, this.entitiesFrame.getEntityInfos(ts.targetId).disposition.cellId);
                                if (needRefresh)
                                {
                                    this._spellTargetsTooltips[targetId] = false;
                                };
                            };
                        };
                    };
                    triggeredSpells = sdi.targetTriggeredSpells;
                    if (((!(this._spellAlreadyTriggered)) && (triggeredSpells)))
                    {
                        splashDamages = DamageUtil.getSplashDamages(triggeredSpells, sdi);
                        if (splashDamages)
                        {
                            if (!(sdi.splashDamages))
                            {
                                sdi.splashDamages = new Vector.<SplashDamage>(0);
                            };
                            for each (splashdmg in splashDamages)
                            {
                                sdi.splashDamages.push(splashdmg);
                                if (!(allTargets))
                                {
                                    allTargets = new Vector.<int>(0);
                                };
                                for each (targetId in splashdmg.targets)
                                {
                                    if (allTargets.indexOf(targetId) == -1)
                                    {
                                        allTargets.push(targetId);
                                    };
                                };
                            };
                        };
                        damageModifications = sdi.addTriggeredSpellsEffects(triggeredSpells);
                        if (((damageModifications) && (!(allTargets))))
                        {
                            allTargets = new Vector.<int>(0);
                        };
                        if (allTargets)
                        {
                            for each (ts in triggeredSpells)
                            {
                                if (ts.triggers != "I")
                                {
                                    this._spellAlreadyTriggered = true;
                                    break;
                                };
                            };
                            if (allTargets.indexOf(pEntityId) == -1)
                            {
                                allTargets.push(pEntityId);
                            };
                            for each (targetId in allTargets)
                            {
                                this.displayEntityTooltip(targetId, pSpell, sdi, true);
                            };
                            return;
                        };
                    };
                    currentSpellDamage = DamageUtil.getSpellDamage(sdi);
                };
                if (currentSpellDamage)
                {
                    if (!(this._spellDamages[pEntityId]))
                    {
                        this._spellDamages[pEntityId] = new Array();
                    };
                    for each (entitySpellDamage in this._spellDamages[pEntityId])
                    {
                        if (entitySpellDamage.spellId == pSpell.id)
                        {
                            nbSameSpell++;
                            if (!(sdi.damageSharingTargets))
                            {
                                break;
                            };
                        };
                    };
                    if ((((nbSameSpell == 0)) || (((sdi.damageSharingTargets) && ((nbSameSpell < sdi.originalTargetsIds.length))))))
                    {
                        this._spellDamages[pEntityId].push({
                            "spellId":pSpell.id,
                            "spellDamage":currentSpellDamage
                        });
                    };
                    if (this._spellDamages[pEntityId].length > 1)
                    {
                        totalSpellDamage = new SpellDamage();
                        for each (entitySpellDamage in this._spellDamages[pEntityId])
                        {
                            sd = entitySpellDamage.spellDamage;
                            for each (effect in sd.effectDamages)
                            {
                                totalSpellDamage.addEffectDamage(effect);
                            };
                            if (sd.invulnerableState)
                            {
                                totalSpellDamage.invulnerableState = true;
                            };
                            if (sd.unhealableState)
                            {
                                totalSpellDamage.unhealableState = true;
                            };
                            if (sd.hasCriticalDamage)
                            {
                                totalSpellDamage.hasCriticalDamage = true;
                            };
                            if (sd.hasCriticalShieldPointsRemoved)
                            {
                                totalSpellDamage.hasCriticalShieldPointsRemoved = true;
                            };
                            if (sd.hasCriticalLifePointsAdded)
                            {
                                totalSpellDamage.hasCriticalLifePointsAdded = true;
                            };
                            if (sd.isHealingSpell)
                            {
                                totalSpellDamage.isHealingSpell = true;
                            };
                            if (sd.hasHeal)
                            {
                                totalSpellDamage.hasHeal = true;
                            };
                        };
                        totalSpellDamage.updateDamage();
                    }
                    else
                    {
                        totalSpellDamage = currentSpellDamage;
                    };
                    params.spellDamage = totalSpellDamage;
                };
            };
            if ((infos is GameFightCharacterInformations))
            {
                TooltipManager.show(infos, entity.absoluteBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, ("tooltipOverEntity_" + infos.contextualId), LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, null, null, params, ("PlayerShortInfos" + infos.contextualId), false, StrataEnum.STRATA_WORLD);
            }
            else
            {
                if ((infos is GameFightCompanionInformations))
                {
                    TooltipManager.show(infos, entity.absoluteBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, ("tooltipOverEntity_" + infos.contextualId), LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, "companionFighter", null, params, ("EntityShortInfos" + infos.contextualId));
                }
                else
                {
                    TooltipManager.show(infos, entity.absoluteBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, ("tooltipOverEntity_" + infos.contextualId), LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, "monsterFighter", null, params, ("EntityShortInfos" + infos.contextualId), false, StrataEnum.STRATA_WORLD);
                };
            };
        }

        public function hideEntityTooltip(pEntityId:int, pDelay:uint):void
        {
            if (((!(((this._showPermanentTooltips) && (!((this._battleFrame.targetedEntities.indexOf(pEntityId) == -1)))))) && (TooltipManager.isVisible(("tooltipOverEntity_" + pEntityId)))))
            {
                TooltipManager.hide(("tooltipOverEntity_" + pEntityId));
                this._hideTooltipEntityId = pEntityId;
                if (!(this._hideTooltipTimer))
                {
                    this._hideTooltipTimer = new Timer(pDelay);
                };
                this._hideTooltipTimer.stop();
                this._hideTooltipTimer.delay = pDelay;
                this._hideTooltipTimer.removeEventListener(TimerEvent.TIMER, this.onShowTooltip);
                this._hideTooltipTimer.addEventListener(TimerEvent.TIMER, this.onShowTooltip);
                this._hideTooltipTimer.start();
            };
        }

        public function hidePermanentTooltips(pDelay:uint):void
        {
            var entityId:int;
            this._hideTooltips = true;
            if (this._battleFrame.targetedEntities.length > 0)
            {
                for each (entityId in this._battleFrame.targetedEntities)
                {
                    TooltipManager.hide(("tooltipOverEntity_" + entityId));
                };
                if (!(this._hideTooltipsTimer))
                {
                    this._hideTooltipsTimer = new Timer(pDelay);
                };
                this._hideTooltipsTimer.stop();
                this._hideTooltipsTimer.delay = pDelay;
                this._hideTooltipsTimer.removeEventListener(TimerEvent.TIMER, this.onShowPermanentTooltips);
                this._hideTooltipsTimer.addEventListener(TimerEvent.TIMER, this.onShowPermanentTooltips);
                this._hideTooltipsTimer.start();
            };
        }

        public function getFighterPreviousPosition(pFighterId:int):int
        {
            var positions:Vector.<uint>;
            var cellId:int = -1;
            if (this._fightersPositionsHistory[pFighterId])
            {
                positions = this._fightersPositionsHistory[pFighterId];
                cellId = (((positions.length > 0)) ? positions[(positions.length - 1)] : -1);
            };
            return (cellId);
        }

        public function saveFighterPosition(pFighterId:int, pCellId:uint):void
        {
            if (!(this._fightersPositionsHistory[pFighterId]))
            {
                this._fightersPositionsHistory[pFighterId] = new Vector.<uint>(0);
            };
            this._fightersPositionsHistory[pFighterId].push(pCellId);
        }

        private function getFighterInfos(fighterId:int):GameFightFighterInformations
        {
            return ((this.entitiesFrame.getEntityInfos(fighterId) as GameFightFighterInformations));
        }

        private function showFighterInfo(event:TimerEvent):void
        {
            this._timerFighterInfo.reset();
            KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate, this._currentFighterInfo);
        }

        private function showMovementRange(event:TimerEvent):void
        {
            this._timerMovementRange.reset();
            this._reachableRangeSelection = new Selection();
            this._reachableRangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
            this._reachableRangeSelection.color = new Color(52326);
            this._unreachableRangeSelection = new Selection();
            this._unreachableRangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
            this._unreachableRangeSelection.color = new Color(0x660000);
            var fightReachableCellsMaker:FightReachableCellsMaker = new FightReachableCellsMaker(this._currentFighterInfo);
            this._reachableRangeSelection.zone = new Custom(fightReachableCellsMaker.reachableCells);
            this._unreachableRangeSelection.zone = new Custom(fightReachableCellsMaker.unreachableCells);
            SelectionManager.getInstance().addSelection(this._reachableRangeSelection, "movementReachableRange", this._currentFighterInfo.disposition.cellId);
            SelectionManager.getInstance().addSelection(this._unreachableRangeSelection, "movementUnreachableRange", this._currentFighterInfo.disposition.cellId);
        }

        private function hideMovementRange():void
        {
            var s:Selection = SelectionManager.getInstance().getSelection("movementReachableRange");
            if (s)
            {
                s.remove();
                this._reachableRangeSelection = null;
            };
            s = SelectionManager.getInstance().getSelection("movementUnreachableRange");
            if (s)
            {
                s.remove();
                this._unreachableRangeSelection = null;
            };
        }

        private function addMarks(marks:Vector.<GameActionMark>):void
        {
            var mark:GameActionMark;
            var spell:Spell;
            var step:AddGlyphGfxStep;
            var cellZone:GameActionMarkedCell;
            for each (mark in marks)
            {
                spell = Spell.getSpellById(mark.markSpellId);
                if (mark.markType == GameActionMarkTypeEnum.WALL)
                {
                    if (spell.getParamByName("glyphGfxId"))
                    {
                        for each (cellZone in mark.cells)
                        {
                            step = new AddGlyphGfxStep(spell.getParamByName("glyphGfxId"), cellZone.cellId, mark.markId, mark.markType, mark.markTeamId);
                            step.start();
                        };
                    };
                }
                else
                {
                    if (((((spell.getParamByName("glyphGfxId")) && (!(MarkedCellsManager.getInstance().getGlyph(mark.markId))))) && (!((mark.markimpactCell == -1)))))
                    {
                        step = new AddGlyphGfxStep(spell.getParamByName("glyphGfxId"), mark.markimpactCell, mark.markId, mark.markType, mark.markTeamId);
                        step.start();
                    };
                };
                MarkedCellsManager.getInstance().addMark(mark.markId, mark.markType, spell, spell.getSpellLevel(mark.markSpellLevel), mark.cells, mark.markTeamId, mark.active);
            };
        }

        private function removeAsLinkEntityEffect():void
        {
            var entityId:int;
            var entity:DisplayObject;
            var index:int;
            for each (entityId in this._entitiesFrame.getEntitiesIdsList())
            {
                entity = (DofusEntities.getEntity(entityId) as DisplayObject);
                if (((((entity) && (entity.filters))) && (entity.filters.length)))
                {
                    index = 0;
                    while (index < entity.filters.length)
                    {
                        if ((entity.filters[index] is ColorMatrixFilter))
                        {
                            entity.filters = entity.filters.splice(index, index);
                            break;
                        };
                        index++;
                    };
                };
            };
        }

        private function highlightAsLinkedEntity(id:int, isMainEntity:Boolean):void
        {
            var filter:ColorMatrixFilter;
            var entity:IEntity = DofusEntities.getEntity(id);
            if (!(entity))
            {
                return;
            };
            var entitySprite:Sprite = (entity as Sprite);
            if (entitySprite)
            {
                filter = ((isMainEntity) ? this._linkedMainEffect : this._linkedEffect);
                if (entitySprite.filters.length)
                {
                    if (entitySprite.filters[0] != filter)
                    {
                        entitySprite.filters = [filter];
                    };
                }
                else
                {
                    entitySprite.filters = [filter];
                };
            };
        }

        private function overEntity(id:int, showRange:Boolean=true):void
        {
            var entityId:int;
            var showInfos:Boolean;
            var entityInfo:GameFightFighterInformations;
            var inviSelection:Selection;
            var pos:int;
            var lastMovPoint:int;
            var reachableCells:FightReachableCellsMaker;
            var effect:GlowFilter;
            var fightTurnFrame:FightTurnFrame;
            var myTurn:Boolean;
            var entitiesIdsList:Vector.<int> = this._entitiesFrame.getEntitiesIdsList();
            fighterEntityTooltipId = id;
            var entity:IEntity = DofusEntities.getEntity(fighterEntityTooltipId);
            if (!(entity))
            {
                if (entitiesIdsList.indexOf(fighterEntityTooltipId) == -1)
                {
                    _log.warn(("Mouse over an unknown entity : " + id));
                    return;
                };
                showRange = false;
            };
            var infos:GameFightFighterInformations = (this._entitiesFrame.getEntityInfos(id) as GameFightFighterInformations);
            if (!(infos))
            {
                _log.warn(("Mouse over an unknown entity : " + id));
                return;
            };
            var summonerId:int = infos.stats.summoner;
            if ((infos is GameFightCompanionInformations))
            {
                summonerId = (infos as GameFightCompanionInformations).masterId;
            };
            for each (entityId in entitiesIdsList)
            {
                if (entityId != id)
                {
                    entityInfo = (this._entitiesFrame.getEntityInfos(entityId) as GameFightFighterInformations);
                    if ((((((((entityInfo.stats.summoner == id)) || ((summonerId == entityId)))) || ((((entityInfo.stats.summoner == summonerId)) && (summonerId))))) || ((((entityInfo is GameFightCompanionInformations)) && (((entityInfo as GameFightCompanionInformations).masterId == id))))))
                    {
                        this.highlightAsLinkedEntity(entityId, (summonerId == entityId));
                    };
                };
            };
            this._currentFighterInfo = infos;
            showInfos = true;
            if (((PlayedCharacterManager.getInstance().isSpectator) && ((OptionManager.getOptionManager("dofus")["spectatorAutoShowCurrentFighterInfo"] == true))))
            {
                showInfos = !((this._battleFrame.currentPlayerId == id));
            };
            if (showInfos)
            {
                this._timerFighterInfo.reset();
                this._timerFighterInfo.start();
            };
            if (infos.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE)
            {
                _log.warn("Mouse over an invisible entity.");
                inviSelection = SelectionManager.getInstance().getSelection(this.INVISIBLE_POSITION_SELECTION);
                if (!(inviSelection))
                {
                    inviSelection = new Selection();
                    inviSelection.color = new Color(52326);
                    inviSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
                    SelectionManager.getInstance().addSelection(inviSelection, this.INVISIBLE_POSITION_SELECTION);
                };
                pos = FightEntitiesFrame.getCurrentInstance().getLastKnownEntityPosition(infos.contextualId);
                if (pos > -1)
                {
                    lastMovPoint = FightEntitiesFrame.getCurrentInstance().getLastKnownEntityMovementPoint(infos.contextualId);
                    reachableCells = new FightReachableCellsMaker(this._currentFighterInfo, pos, lastMovPoint);
                    inviSelection.zone = new Custom(reachableCells.reachableCells);
                    SelectionManager.getInstance().update(this.INVISIBLE_POSITION_SELECTION, pos);
                };
                return;
            };
            var fscf:FightSpellCastFrame = (Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame);
            var spell:Object;
            if (((fscf) && (((SelectionManager.getInstance().isInside(currentCell, "SpellCastTarget")) || (this._spellTargetsTooltips[id])))))
            {
                spell = fscf.currentSpell;
            };
            this.displayEntityTooltip(id, spell);
            var movementSelection:Selection = SelectionManager.getInstance().getSelection(FightTurnFrame.SELECTION_PATH);
            if (movementSelection)
            {
                movementSelection.remove();
            };
            if (showRange)
            {
                if (((Kernel.getWorker().contains(FightBattleFrame)) && (!(Kernel.getWorker().contains(FightSpellCastFrame)))))
                {
                    this._timerMovementRange.reset();
                    this._timerMovementRange.start();
                };
            };
            if (((((this._lastEffectEntity) && ((this._lastEffectEntity.object is Sprite)))) && (!((this._lastEffectEntity.object == entity)))))
            {
                Sprite(this._lastEffectEntity.object).filters = [];
            };
            var entitySprite:Sprite = (entity as Sprite);
            if (entitySprite)
            {
                fightTurnFrame = (Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame);
                myTurn = ((fightTurnFrame) ? fightTurnFrame.myTurn : true);
                if (((((!(fscf)) || (FightSpellCastFrame.isCurrentTargetTargetable()))) && (myTurn)))
                {
                    effect = this._overEffectOk;
                }
                else
                {
                    effect = this._overEffectKo;
                };
                if (entitySprite.filters.length)
                {
                    if (entitySprite.filters[0] != effect)
                    {
                        entitySprite.filters = [effect];
                    };
                }
                else
                {
                    entitySprite.filters = [effect];
                };
                this._lastEffectEntity = new WeakReference(entity);
            };
        }

        private function tacticModeHandler(forceOpen:Boolean=false):void
        {
            if (((forceOpen) && (!(TacticModeManager.getInstance().tacticModeActivated))))
            {
                TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap);
            }
            else
            {
                if (TacticModeManager.getInstance().tacticModeActivated)
                {
                    TacticModeManager.getInstance().hide();
                };
            };
        }

        private function onPropertyChanged(pEvent:PropertyChangeEvent):void
        {
            var _local_2:int;
            var showInfos:Boolean;
            switch (pEvent.propertyName)
            {
                case "showPermanentTargetsTooltips":
                    this._showPermanentTooltips = (pEvent.propertyValue as Boolean);
                    for each (_local_2 in this._battleFrame.targetedEntities)
                    {
                        if (!(this._showPermanentTooltips))
                        {
                            TooltipManager.hide(("tooltipOverEntity_" + _local_2));
                        }
                        else
                        {
                            this.displayEntityTooltip(_local_2);
                        };
                    };
                    return;
                case "spectatorAutoShowCurrentFighterInfo":
                    if (PlayedCharacterManager.getInstance().isSpectator)
                    {
                        showInfos = (pEvent.propertyValue as Boolean);
                        if (!(showInfos))
                        {
                            KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate, null);
                        }
                        else
                        {
                            KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate, (FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._battleFrame.currentPlayerId) as GameFightFighterInformations));
                        };
                    };
                    return;
            };
        }

        private function onShowPermanentTooltips(pEvent:TimerEvent):void
        {
            var entityId:int;
            this._hideTooltips = false;
            this._hideTooltipsTimer.removeEventListener(TimerEvent.TIMER, this.onShowPermanentTooltips);
            this._hideTooltipsTimer.stop();
            for each (entityId in this._battleFrame.targetedEntities)
            {
                this.displayEntityTooltip(entityId);
            };
        }

        private function onShowTooltip(pEvent:TimerEvent):void
        {
            this._hideTooltipTimer.removeEventListener(TimerEvent.TIMER, this.onShowTooltip);
            this._hideTooltipTimer.stop();
            var entityInfo:GameContextActorInformations = this._entitiesFrame.getEntityInfos(this._hideTooltipEntityId);
            if (((entityInfo) && ((((entityInfo.disposition.cellId == currentCell)) || (((this.timelineOverEntity) && ((this._hideTooltipEntityId == this.timelineOverEntityId))))))))
            {
                this.displayEntityTooltip(this._hideTooltipEntityId);
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.frames

