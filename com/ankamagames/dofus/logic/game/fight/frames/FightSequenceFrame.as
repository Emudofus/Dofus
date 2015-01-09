package com.ankamagames.dofus.logic.game.fight.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.dofus.logic.game.common.misc.ISpellCastProvider;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.sequencer.ISequencable;
    import com.ankamagames.jerakine.sequencer.SerialSequencer;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.jerakine.sequencer.ParallelStartSequenceStep;
    import com.ankamagames.jerakine.sequencer.ISequencer;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSpellCastMessage;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.network.messages.game.context.GameMapMovementMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightPointsVariationMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifeAndShieldPointsLostMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifePointsGainMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifePointsLostMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTeleportOnSameMapMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightExchangePositionsMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSlideMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSummonMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightMarkCellsMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightUnmarkCellsMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightChangeLookMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightInvisibilityMessage;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.logic.game.fight.messages.GameActionFightLeaveMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDeathMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightVanishMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDispellEffectMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDispellSpellMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDispellMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDodgePointLossMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSpellCooldownVariationMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSpellImmunityMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightInvisibleObstacleMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightKillMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightReduceDamagesMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightReflectDamagesMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightReflectSpellMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightStealKamaMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTackledMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTriggerGlyphTrapMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDispellableEffectMessage;
    import com.ankamagames.dofus.network.types.game.actions.fight.AbstractFightDispellableEffect;
    import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightModifyEffectsDurationMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCarryCharacterMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightThrowCharacterMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDropCharacterMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightInvisibleDetectedMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnListMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCloseCombatMessage;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightSpellCooldown;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.atouin.types.GraphicCell;
    import flash.geom.Point;
    import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterRandomStaticPoseMessage;
    import flash.display.Sprite;
    import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterMessage;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
    import com.ankamagames.dofus.logic.game.fight.types.StateBuff;
    import com.ankamagames.dofus.network.enums.FightSpellCastCriticalEnum;
    import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.TriggerHookList;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCompanionInformations;
    import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
    import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import com.ankamagames.dofus.logic.game.common.managers.MapMovementAdapter;
    import com.ankamagames.dofus.logic.game.fight.miscs.TackleUtil;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTriggerEffectMessage;
    import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceEndMessage;
    import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceStartMessage;
    import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
    import com.ankamagames.dofus.logic.game.fight.steps.FightLeavingStateStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightEnteringStateStep;
    import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostEffect;
    import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.script.BinaryScript;
    import com.ankamagames.dofus.scripts.SpellFxRunner;
    import com.ankamagames.dofus.scripts.DofusEmbedScript;
    import flash.utils.getTimer;
    import com.ankamagames.jerakine.script.ScriptExec;
    import com.ankamagames.jerakine.types.Callback;
    import com.ankamagames.tiphon.sequence.WaitAnimationEventStep;
    import com.ankamagames.tiphon.sequence.PlayAnimationStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightDeathStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightActionPointsVariationStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightShieldPointsVariationStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightLifeVariationStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightMarkTriggeredStep;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.dofus.types.enums.AnimationEnum;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
    import com.ankamagames.dofus.types.sequences.AddGfxInLineStep;
    import com.ankamagames.atouin.types.sequences.ParableGfxMovementStep;
    import com.ankamagames.atouin.types.sequences.AddWorldEntityStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightLossAnimStep;
    import com.ankamagames.jerakine.types.events.SequencerEvent;
    import com.ankamagames.jerakine.sequencer.CallbackStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightEntityMovementStep;
    import com.ankamagames.jerakine.types.positions.MovementPath;
    import com.ankamagames.dofus.logic.game.fight.steps.FightTeleportStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightExchangePositionsStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightEntitySlideStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightSummonStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightVisibilityStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightMarkCellsStep;
    import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMarkedCell;
    import com.ankamagames.dofus.logic.game.fight.steps.FightUnmarkCellsStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightChangeLookStep;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.logic.game.fight.steps.FightChangeVisibilityStep;
    import com.ankamagames.dofus.logic.game.fight.steps.IFightStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightMovementPointsVariationStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightTemporaryBoostStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightActionPointsLossDodgeStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightMovementPointsLossDodgeStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightVanishStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightDispellStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightDispellEffectStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightDispellSpellStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightSpellCooldownVariationStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightSpellImmunityStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightInvisibleObstacleStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightKillStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightReducedDamagesStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightReflectedDamagesStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightReflectedSpellStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightSpellCastStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightCloseCombatStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightStealingKamasStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightTackledStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightDisplayBuffStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightModifyEffectsDurationStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightCarryCharacterStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightThrowCharacterStep;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.logic.game.fight.steps.FightInvisibleTemporarilyDetectedStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightTurnListStep;
    import __AS3__.vec.*;

    public class FightSequenceFrame implements Frame, ISpellCastProvider 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightSequenceFrame));
        private static var _lastCastingSpell:CastingSpell;
        private static var _currentInstanceId:uint;
        public static const FIGHT_SEQUENCERS_CATEGORY:String = "FightSequencer";

        private var _fxScriptId:uint;
        private var _scriptStarted:uint;
        private var _castingSpell:CastingSpell;
        private var _stepsBuffer:Vector.<ISequencable>;
        public var mustAck:Boolean;
        public var ackIdent:int;
        private var _sequenceEndCallback:Function;
        private var _subSequenceWaitingCount:uint = 0;
        private var _scriptInit:Boolean;
        private var _sequencer:SerialSequencer;
        private var _parent:FightSequenceFrame;
        private var _fightBattleFrame:FightBattleFrame;
        private var _fightEntitiesFrame:FightEntitiesFrame;
        private var _instanceId:uint;

        public function FightSequenceFrame(pFightBattleFrame:FightBattleFrame, parent:FightSequenceFrame=null)
        {
            this._instanceId = _currentInstanceId++;
            this._fightBattleFrame = pFightBattleFrame;
            this._parent = parent;
            this.clearBuffer();
        }

        public static function get lastCastingSpell():CastingSpell
        {
            return (_lastCastingSpell);
        }

        public static function get currentInstanceId():uint
        {
            return (_currentInstanceId);
        }

        private static function deleteTooltip(fighterId:int):void
        {
            var fightContextFrame:FightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            if ((((FightContextFrame.fighterEntityTooltipId == fighterId)) && (!((FightContextFrame.fighterEntityTooltipId == fightContextFrame.timelineOverEntityId)))))
            {
                if (fightContextFrame)
                {
                    fightContextFrame.outEntity(fighterId);
                };
            };
        }


        public function get priority():int
        {
            return (Priority.HIGHEST);
        }

        public function get castingSpell():CastingSpell
        {
            return (this._castingSpell);
        }

        public function get stepsBuffer():Vector.<ISequencable>
        {
            return (this._stepsBuffer);
        }

        public function get parent():FightSequenceFrame
        {
            return (this._parent);
        }

        public function get isWaiting():Boolean
        {
            return (((!((this._subSequenceWaitingCount == 0))) || (!(this._scriptInit))));
        }

        public function get instanceId():uint
        {
            return (this._instanceId);
        }

        public function pushed():Boolean
        {
            this._scriptInit = false;
            return (true);
        }

        public function pulled():Boolean
        {
            this._stepsBuffer = null;
            this._castingSpell = null;
            _lastCastingSpell = null;
            this._sequenceEndCallback = null;
            this._parent = null;
            this._fightBattleFrame = null;
            this._fightEntitiesFrame = null;
            this._sequencer.clear();
            return (true);
        }

        public function get fightEntitiesFrame():FightEntitiesFrame
        {
            if (!(this._fightEntitiesFrame))
            {
                this._fightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            };
            return (this._fightEntitiesFrame);
        }

        public function addSubSequence(sequence:ISequencer):void
        {
            this._subSequenceWaitingCount++;
            this._stepsBuffer.push(new ParallelStartSequenceStep([sequence], false));
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:GameActionFightSpellCastMessage;
            var _local_3:Boolean;
            var _local_4:uint;
            var _local_5:int;
            var _local_6:Boolean;
            var _local_7:Dictionary;
            var _local_8:GameFightFighterInformations;
            var _local_9:PlayedCharacterManager;
            var _local_10:Boolean;
            var _local_11:GameFightFighterInformations;
            var _local_12:GameMapMovementMessage;
            var _local_13:GameActionFightPointsVariationMessage;
            var _local_14:GameActionFightLifeAndShieldPointsLostMessage;
            var _local_15:GameActionFightLifePointsGainMessage;
            var _local_16:GameActionFightLifePointsLostMessage;
            var _local_17:GameActionFightTeleportOnSameMapMessage;
            var _local_18:GameActionFightExchangePositionsMessage;
            var _local_19:GameActionFightSlideMessage;
            var _local_20:GameActionFightSummonMessage;
            var _local_21:GameActionFightMarkCellsMessage;
            var _local_22:GameActionFightUnmarkCellsMessage;
            var _local_23:GameActionFightChangeLookMessage;
            var _local_24:GameActionFightInvisibilityMessage;
            var _local_25:GameContextActorInformations;
            var _local_26:GameActionFightLeaveMessage;
            var _local_27:Dictionary;
            var _local_28:GameContextActorInformations;
            var _local_29:GameActionFightDeathMessage;
            var _local_30:Dictionary;
            var _local_31:GameFightFighterInformations;
            var _local_32:int;
            var _local_33:GameFightFighterInformations;
            var _local_34:GameFightFighterInformations;
            var _local_35:GameFightFighterInformations;
            var _local_36:GameContextActorInformations;
            var _local_37:FightTurnFrame;
            var _local_38:Boolean;
            var _local_39:FightContextFrame;
            var _local_40:GameActionFightVanishMessage;
            var _local_41:GameContextActorInformations;
            var _local_42:FightContextFrame;
            var _local_43:GameActionFightDispellEffectMessage;
            var _local_44:GameActionFightDispellSpellMessage;
            var _local_45:GameActionFightDispellMessage;
            var _local_46:GameActionFightDodgePointLossMessage;
            var _local_47:GameActionFightSpellCooldownVariationMessage;
            var _local_48:GameActionFightSpellImmunityMessage;
            var _local_49:GameActionFightInvisibleObstacleMessage;
            var _local_50:GameActionFightKillMessage;
            var _local_51:GameActionFightReduceDamagesMessage;
            var _local_52:GameActionFightReflectDamagesMessage;
            var _local_53:GameActionFightReflectSpellMessage;
            var _local_54:GameActionFightStealKamaMessage;
            var _local_55:GameActionFightTackledMessage;
            var _local_56:GameActionFightTriggerGlyphTrapMessage;
            var _local_57:int;
            var _local_58:GameActionFightDispellableEffectMessage;
            var _local_59:CastingSpell;
            var _local_60:AbstractFightDispellableEffect;
            var _local_61:BasicBuff;
            var _local_62:GameActionFightModifyEffectsDurationMessage;
            var _local_63:GameActionFightCarryCharacterMessage;
            var _local_64:GameActionFightThrowCharacterMessage;
            var _local_65:uint;
            var _local_66:GameActionFightDropCharacterMessage;
            var _local_67:uint;
            var _local_68:GameActionFightInvisibleDetectedMessage;
            var _local_69:GameFightTurnListMessage;
            var _local_70:GameActionFightCloseCombatMessage;
            var spellTargetEntities:Array;
            var isSpellKnown:Boolean;
            var playerSpellLevel:SpellLevel;
            var spellKnown:SpellWrapper;
            var spell:Spell;
            var castSpellLevel:SpellLevel;
            var fightEntities:Dictionary;
            var fighterInfos:GameFightFighterInformations;
            var simf:SpellInventoryManagementFrame;
            var gcdValue:int;
            var gfsc:GameFightSpellCooldown;
            var shape:uint;
            var ei:EffectInstance;
            var ts:TiphonSprite;
            var targetedCell:GraphicCell;
            var cellPos:Point;
            var gfsfrsmsg:GameFightShowFighterRandomStaticPoseMessage;
            var illusionCreature:Sprite;
            var _local_89:GameFightShowFighterMessage;
            var _local_90:Sprite;
            var _local_91:int;
            var isBomb:Boolean;
            var isCreature:Boolean;
            var _local_94:GameContextActorInformations;
            var _local_95:GameFightMonsterInformations;
            var monsterS:Monster;
            var _local_97:GameFightCharacterInformations;
            var gcaiL:GameContextActorInformations;
            var summonerIdL:int;
            var summonedEntityInfosL:GameFightMonsterInformations;
            var monster:Monster;
            var gcai:GameContextActorInformations;
            var summonedEntityInfos:GameFightMonsterInformations;
            var summonedFighterEntityInfos:GameFightFighterInformations;
            var sb:StateBuff;
            var step:Object;
            var actionId:int;
            switch (true)
            {
                case (msg is GameActionFightCloseCombatMessage):
                case (msg is GameActionFightSpellCastMessage):
                    if ((msg is GameActionFightSpellCastMessage))
                    {
                        _local_2 = (msg as GameActionFightSpellCastMessage);
                    }
                    else
                    {
                        _local_70 = (msg as GameActionFightCloseCombatMessage);
                        _local_3 = true;
                        _local_4 = _local_70.weaponGenericId;
                        _local_2 = new GameActionFightSpellCastMessage();
                        _local_2.initGameActionFightSpellCastMessage(_local_70.actionId, _local_70.sourceId, _local_70.targetId, _local_70.destinationCellId, _local_70.critical, _local_70.silentCast, 0, 1);
                    };
                    _local_5 = this.fightEntitiesFrame.getEntityInfos(_local_2.sourceId).disposition.cellId;
                    if (this._castingSpell)
                    {
                        if (((_local_3) && (!((_local_4 == 0)))))
                        {
                            this.pushCloseCombatStep(_local_2.sourceId, _local_4, _local_2.critical);
                        }
                        else
                        {
                            this.pushSpellCastStep(_local_2.sourceId, _local_2.destinationCellId, _local_5, _local_2.spellId, _local_2.spellLevel, _local_2.critical);
                        };
                        _log.error((("Il ne peut y avoir qu'un seul cast de sort par séquence (" + msg) + ")"));
                        break;
                    };
                    this._castingSpell = new CastingSpell();
                    this._castingSpell.casterId = _local_2.sourceId;
                    this._castingSpell.spell = Spell.getSpellById(_local_2.spellId);
                    this._castingSpell.spellRank = this._castingSpell.spell.getSpellLevel(_local_2.spellLevel);
                    this._castingSpell.isCriticalFail = (_local_2.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL);
                    this._castingSpell.isCriticalHit = (_local_2.critical == FightSpellCastCriticalEnum.CRITICAL_HIT);
                    this._castingSpell.silentCast = _local_2.silentCast;
                    if (!(this._fightBattleFrame.currentPlayerId))
                    {
                        BuffManager.getInstance().spellBuffsToIgnore.push(this._castingSpell);
                    };
                    if (_local_2.destinationCellId != -1)
                    {
                        this._castingSpell.targetedCell = MapPoint.fromCellId(_local_2.destinationCellId);
                    };
                    if (this._castingSpell.isCriticalFail)
                    {
                        this._fxScriptId = 0;
                    }
                    else
                    {
                        this._fxScriptId = this._castingSpell.spell.getScriptId(this._castingSpell.isCriticalHit);
                    };
                    if ((msg is GameActionFightCloseCombatMessage))
                    {
                        this._fxScriptId = 7;
                        this._castingSpell.weaponId = GameActionFightCloseCombatMessage(msg).weaponGenericId;
                    };
                    if ((((_local_2.sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId)) && (!((_local_2.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL)))))
                    {
                        spellTargetEntities = new Array();
                        spellTargetEntities.push(_local_2.targetId);
                        CurrentPlayedFighterManager.getInstance().getSpellCastManager().castSpell(_local_2.spellId, _local_2.spellLevel, spellTargetEntities);
                    };
                    _local_6 = (_local_2.critical == FightSpellCastCriticalEnum.CRITICAL_HIT);
                    _local_7 = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
                    _local_8 = _local_7[_local_2.sourceId];
                    if (((_local_3) && (!((_local_4 == 0)))))
                    {
                        this.pushCloseCombatStep(_local_2.sourceId, _local_4, _local_2.critical);
                    }
                    else
                    {
                        this.pushSpellCastStep(_local_2.sourceId, _local_2.destinationCellId, _local_5, _local_2.spellId, _local_2.spellLevel, _local_2.critical);
                    };
                    if (_local_2.sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId)
                    {
                        KernelEventsManager.getInstance().processCallback(TriggerHookList.FightSpellCast);
                    };
                    _local_9 = PlayedCharacterManager.getInstance();
                    _local_10 = false;
                    if (((((_local_7[_local_9.id]) && (_local_8))) && (((_local_7[_local_9.id] as GameFightFighterInformations).teamId == _local_8.teamId))))
                    {
                        _local_10 = true;
                    };
                    if (((((!((_local_2.sourceId == _local_9.id))) && (_local_10))) && (!(this._castingSpell.isCriticalFail))))
                    {
                        isSpellKnown = false;
                        for each (spellKnown in _local_9.spellsInventory)
                        {
                            if (spellKnown.id == _local_2.spellId)
                            {
                                isSpellKnown = true;
                                playerSpellLevel = spellKnown.spellLevelInfos;
                                break;
                            };
                        };
                        spell = Spell.getSpellById(_local_2.spellId);
                        castSpellLevel = spell.getSpellLevel(_local_2.spellLevel);
                        if (castSpellLevel.globalCooldown)
                        {
                            if (isSpellKnown)
                            {
                                if (castSpellLevel.globalCooldown == -1)
                                {
                                    gcdValue = playerSpellLevel.minCastInterval;
                                }
                                else
                                {
                                    gcdValue = castSpellLevel.globalCooldown;
                                };
                                this.pushSpellCooldownVariationStep(_local_9.id, 0, _local_2.spellId, gcdValue);
                            };
                            fightEntities = this.fightEntitiesFrame.getEntitiesDictionnary();
                            simf = (Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame);
                            for each (fighterInfos in fightEntities)
                            {
                                if ((((((fighterInfos is GameFightCompanionInformations)) && (!((_local_2.sourceId == fighterInfos.contextualId))))) && (((fighterInfos as GameFightCompanionInformations).masterId == _local_9.id))))
                                {
                                    gfsc = new GameFightSpellCooldown();
                                    gfsc.initGameFightSpellCooldown(_local_2.spellId, castSpellLevel.globalCooldown);
                                    simf.addSpellGlobalCoolDownInfo(fighterInfos.contextualId, gfsc);
                                };
                            };
                        };
                    };
                    _local_32 = PlayedCharacterManager.getInstance().id;
                    _local_33 = (this.fightEntitiesFrame.getEntityInfos(_local_2.sourceId) as GameFightFighterInformations);
                    _local_35 = (this.fightEntitiesFrame.getEntityInfos(_local_32) as GameFightFighterInformations);
                    if (_local_6)
                    {
                        if (_local_2.sourceId == _local_32)
                        {
                            SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_OWNER);
                        }
                        else
                        {
                            if (((_local_35) && ((_local_33.teamId == _local_35.teamId))))
                            {
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_ALLIED);
                            }
                            else
                            {
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_ENEMY);
                            };
                        };
                    }
                    else
                    {
                        if (_local_2.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL)
                        {
                            if (_local_2.sourceId == _local_32)
                            {
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_OWNER);
                            }
                            else
                            {
                                if (((_local_35) && ((_local_33.teamId == _local_35.teamId))))
                                {
                                    SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_ALLIED);
                                }
                                else
                                {
                                    SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_ENEMY);
                                };
                            };
                        };
                    };
                    _local_11 = (this.fightEntitiesFrame.getEntityInfos(_local_2.targetId) as GameFightFighterInformations);
                    if (((_local_11) && ((_local_11.disposition.cellId == -1))))
                    {
                        for each (ei in this._castingSpell.spellRank.effects)
                        {
                            if (ei.hasOwnProperty("zoneShape"))
                            {
                                shape = ei.zoneShape;
                                break;
                            };
                        };
                        if (shape == SpellShapeEnum.P)
                        {
                            ts = (DofusEntities.getEntity(_local_2.targetId) as TiphonSprite);
                            if (((((ts) && (this._castingSpell))) && (this._castingSpell.targetedCell)))
                            {
                                targetedCell = InteractiveCellManager.getInstance().getCell(this._castingSpell.targetedCell.cellId);
                                cellPos = targetedCell.parent.localToGlobal(new Point((targetedCell.x + (targetedCell.width / 2)), (targetedCell.y + (targetedCell.height / 2))));
                                ts.x = cellPos.x;
                                ts.y = cellPos.y;
                            };
                        };
                    };
                    return (true);
                case (msg is GameMapMovementMessage):
                    _local_12 = (msg as GameMapMovementMessage);
                    if (_local_12.actorId == CurrentPlayedFighterManager.getInstance().currentFighterId)
                    {
                        KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerFightMove);
                    };
                    this.pushMovementStep(_local_12.actorId, MapMovementAdapter.getClientMovement(_local_12.keyMovements));
                    return (true);
                case (msg is GameActionFightPointsVariationMessage):
                    _local_13 = (msg as GameActionFightPointsVariationMessage);
                    this.pushPointsVariationStep(_local_13.targetId, _local_13.actionId, _local_13.delta);
                    return (true);
                case (msg is GameActionFightLifeAndShieldPointsLostMessage):
                    _local_14 = (msg as GameActionFightLifeAndShieldPointsLostMessage);
                    this.pushShieldPointsVariationStep(_local_14.targetId, -(_local_14.shieldLoss), _local_14.actionId);
                    this.pushLifePointsVariationStep(_local_14.targetId, -(_local_14.loss), -(_local_14.permanentDamages), _local_14.actionId);
                    return (true);
                case (msg is GameActionFightLifePointsGainMessage):
                    _local_15 = (msg as GameActionFightLifePointsGainMessage);
                    this.pushLifePointsVariationStep(_local_15.targetId, _local_15.delta, 0, _local_15.actionId);
                    return (true);
                case (msg is GameActionFightLifePointsLostMessage):
                    _local_16 = (msg as GameActionFightLifePointsLostMessage);
                    this.pushLifePointsVariationStep(_local_16.targetId, -(_local_16.loss), -(_local_16.permanentDamages), _local_16.actionId);
                    return (true);
                case (msg is GameActionFightTeleportOnSameMapMessage):
                    _local_17 = (msg as GameActionFightTeleportOnSameMapMessage);
                    this.pushTeleportStep(_local_17.targetId, _local_17.cellId);
                    return (true);
                case (msg is GameActionFightExchangePositionsMessage):
                    _local_18 = (msg as GameActionFightExchangePositionsMessage);
                    this.pushExchangePositionsStep(_local_18.sourceId, _local_18.casterCellId, _local_18.targetId, _local_18.targetCellId);
                    return (true);
                case (msg is GameActionFightSlideMessage):
                    _local_19 = (msg as GameActionFightSlideMessage);
                    this.pushSlideStep(_local_19.targetId, _local_19.startCellId, _local_19.endCellId);
                    return (true);
                case (msg is GameActionFightSummonMessage):
                    _local_20 = (msg as GameActionFightSummonMessage);
                    if ((((_local_20.actionId == 0x0400)) || ((_local_20.actionId == 1097))))
                    {
                        gfsfrsmsg = new GameFightShowFighterRandomStaticPoseMessage();
                        gfsfrsmsg.initGameFightShowFighterRandomStaticPoseMessage(_local_20.summon);
                        Kernel.getWorker().getFrame(FightEntitiesFrame).process(gfsfrsmsg);
                        illusionCreature = (DofusEntities.getEntity(_local_20.summon.contextualId) as Sprite);
                        if (illusionCreature)
                        {
                            illusionCreature.visible = false;
                        };
                        this.pushVisibilityStep(_local_20.summon.contextualId, true);
                    }
                    else
                    {
                        _local_89 = new GameFightShowFighterMessage();
                        _local_89.initGameFightShowFighterMessage(_local_20.summon);
                        Kernel.getWorker().getFrame(FightEntitiesFrame).process(_local_89);
                        _local_90 = (DofusEntities.getEntity(_local_20.summon.contextualId) as Sprite);
                        if (_local_90)
                        {
                            _local_90.visible = false;
                        };
                        this.pushSummonStep(_local_20.sourceId, _local_20.summon);
                        if ((((_local_20.sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId)) && (!((_local_20.actionId == 185)))))
                        {
                            isBomb = false;
                            isCreature = false;
                            if (_local_20.actionId == 1008)
                            {
                                isBomb = true;
                            }
                            else
                            {
                                _local_94 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_local_20.summon.contextualId);
                                isBomb = false;
                                _local_95 = (_local_94 as GameFightMonsterInformations);
                                if (_local_95)
                                {
                                    monsterS = Monster.getMonsterById(_local_95.creatureGenericId);
                                    if (((monsterS) && (monsterS.useBombSlot)))
                                    {
                                        isBomb = true;
                                    };
                                    if (((monsterS) && (monsterS.useSummonSlot)))
                                    {
                                        isCreature = true;
                                    };
                                }
                                else
                                {
                                    _local_97 = (_local_94 as GameFightCharacterInformations);
                                };
                            };
                            if (((isCreature) || (_local_97)))
                            {
                                CurrentPlayedFighterManager.getInstance().addSummonedCreature();
                            }
                            else
                            {
                                if (isBomb)
                                {
                                    CurrentPlayedFighterManager.getInstance().addSummonedBomb();
                                };
                            };
                        };
                        _local_91 = this._fightBattleFrame.getNextPlayableCharacterId();
                        if (((((!((this._fightBattleFrame.currentPlayerId == CurrentPlayedFighterManager.getInstance().currentFighterId))) && (!((_local_91 == CurrentPlayedFighterManager.getInstance().currentFighterId))))) && ((_local_91 == _local_20.summon.contextualId))))
                        {
                            this._fightBattleFrame.prepareNextPlayableCharacter();
                        };
                    };
                    return (true);
                case (msg is GameActionFightMarkCellsMessage):
                    _local_21 = (msg as GameActionFightMarkCellsMessage);
                    if (this._castingSpell)
                    {
                        this._castingSpell.markId = _local_21.mark.markId;
                        this._castingSpell.markType = _local_21.mark.markType;
                        this.pushMarkCellsStep(_local_21.mark.markId, _local_21.mark.markType, _local_21.mark.cells, _local_21.mark.markSpellId);
                    };
                    return (true);
                case (msg is GameActionFightUnmarkCellsMessage):
                    _local_22 = (msg as GameActionFightUnmarkCellsMessage);
                    this.pushUnmarkCellsStep(_local_22.markId);
                    return (true);
                case (msg is GameActionFightChangeLookMessage):
                    _local_23 = (msg as GameActionFightChangeLookMessage);
                    this.pushChangeLookStep(_local_23.targetId, _local_23.entityLook);
                    return (true);
                case (msg is GameActionFightInvisibilityMessage):
                    _local_24 = (msg as GameActionFightInvisibilityMessage);
                    _local_25 = this.fightEntitiesFrame.getEntityInfos(_local_24.targetId);
                    FightEntitiesFrame.getCurrentInstance().setLastKnownEntityPosition(_local_24.targetId, _local_25.disposition.cellId);
                    FightEntitiesFrame.getCurrentInstance().setLastKnownEntityMovementPoint(_local_24.targetId, 0, true);
                    this.pushChangeVisibilityStep(_local_24.targetId, _local_24.state);
                    return (true);
                case (msg is GameActionFightLeaveMessage):
                    _local_26 = (msg as GameActionFightLeaveMessage);
                    _local_27 = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
                    for each (gcaiL in _local_27)
                    {
                        if ((gcaiL is GameFightFighterInformations))
                        {
                            summonerIdL = (gcaiL as GameFightFighterInformations).stats.summoner;
                            if (summonerIdL == _local_26.targetId)
                            {
                                this.pushDeathStep(gcaiL.contextualId);
                            };
                        };
                    };
                    this.pushDeathStep(_local_26.targetId, false);
                    _local_28 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_local_26.targetId);
                    if ((_local_28 is GameFightMonsterInformations))
                    {
                        summonedEntityInfosL = (_local_28 as GameFightMonsterInformations);
                        if (CurrentPlayedFighterManager.getInstance().checkPlayableEntity(summonedEntityInfosL.stats.summoner))
                        {
                            monster = Monster.getMonsterById(summonedEntityInfosL.creatureGenericId);
                            if (monster.useSummonSlot)
                            {
                                CurrentPlayedFighterManager.getInstance().removeSummonedCreature(summonedEntityInfosL.stats.summoner);
                            };
                            if (monster.useBombSlot)
                            {
                                CurrentPlayedFighterManager.getInstance().removeSummonedBomb(summonedEntityInfosL.stats.summoner);
                            };
                        };
                    };
                    return (true);
                case (msg is GameActionFightDeathMessage):
                    _local_29 = (msg as GameActionFightDeathMessage);
                    _local_30 = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
                    for each (gcai in _local_30)
                    {
                        if ((gcai is GameFightFighterInformations))
                        {
                            _local_31 = (gcai as GameFightFighterInformations);
                            if (((_local_31.alive) && ((_local_31.stats.summoner == _local_29.targetId))))
                            {
                                this.pushDeathStep(gcai.contextualId);
                            };
                        };
                    };
                    _local_32 = PlayedCharacterManager.getInstance().id;
                    _local_33 = (this.fightEntitiesFrame.getEntityInfos(_local_29.sourceId) as GameFightFighterInformations);
                    _local_34 = (this.fightEntitiesFrame.getEntityInfos(_local_29.targetId) as GameFightFighterInformations);
                    _local_35 = (this.fightEntitiesFrame.getEntityInfos(_local_32) as GameFightFighterInformations);
                    if (((!((_local_29.targetId == this._fightBattleFrame.currentPlayerId))) && ((((this._fightBattleFrame.slaveId == _local_29.targetId)) || ((this._fightBattleFrame.masterId == _local_29.targetId))))))
                    {
                        this._fightBattleFrame.prepareNextPlayableCharacter(_local_29.targetId);
                    };
                    if (_local_29.targetId == _local_32)
                    {
                        if (_local_29.sourceId == _local_29.targetId)
                        {
                            SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_HIMSELF);
                        }
                        else
                        {
                            if (_local_33.teamId != _local_35.teamId)
                            {
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_BY_ENEMY);
                            }
                            else
                            {
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_BY_ENEMY);
                            };
                        };
                    }
                    else
                    {
                        if (_local_29.sourceId == _local_32)
                        {
                            if (_local_34.teamId != _local_35.teamId)
                            {
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILL_ENEMY);
                            }
                            else
                            {
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILL_ALLY);
                            };
                        };
                    };
                    this.pushDeathStep(_local_29.targetId);
                    _local_36 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_local_29.targetId);
                    _local_37 = (Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame);
                    _local_38 = ((((((_local_37) && (_local_37.myTurn))) && (!((_local_29.targetId == _local_32))))) && (TackleUtil.isTackling(_local_35, _local_34, _local_37.lastPath)));
                    if ((_local_36 is GameFightMonsterInformations))
                    {
                        summonedEntityInfos = (_local_36 as GameFightMonsterInformations);
                        summonedEntityInfos.alive = false;
                        if (CurrentPlayedFighterManager.getInstance().checkPlayableEntity(summonedEntityInfos.stats.summoner))
                        {
                            monster = Monster.getMonsterById(summonedEntityInfos.creatureGenericId);
                            if (monster.useSummonSlot)
                            {
                                CurrentPlayedFighterManager.getInstance().removeSummonedCreature(summonedEntityInfos.stats.summoner);
                            };
                            if (monster.useBombSlot)
                            {
                                CurrentPlayedFighterManager.getInstance().removeSummonedBomb(summonedEntityInfos.stats.summoner);
                            };
                            SpellWrapper.refreshAllPlayerSpellHolder(summonedEntityInfos.stats.summoner);
                        };
                    }
                    else
                    {
                        if ((_local_36 is GameFightFighterInformations))
                        {
                            (_local_36 as GameFightFighterInformations).alive = false;
                            if ((_local_36 as GameFightFighterInformations).stats.summoner != 0)
                            {
                                summonedFighterEntityInfos = (_local_36 as GameFightFighterInformations);
                                if (CurrentPlayedFighterManager.getInstance().checkPlayableEntity(summonedFighterEntityInfos.stats.summoner))
                                {
                                    CurrentPlayedFighterManager.getInstance().removeSummonedCreature(summonedFighterEntityInfos.stats.summoner);
                                    SpellWrapper.refreshAllPlayerSpellHolder(summonedFighterEntityInfos.stats.summoner);
                                };
                            };
                        };
                    };
                    _local_39 = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                    if (_local_39)
                    {
                        _local_39.outEntity(_local_29.targetId);
                    };
                    FightEntitiesFrame.getCurrentInstance().updateRemovedEntity(_local_29.targetId);
                    if (_local_38)
                    {
                        _local_37.updatePath();
                    };
                    return (true);
                case (msg is GameActionFightVanishMessage):
                    _local_40 = (msg as GameActionFightVanishMessage);
                    this.pushVanishStep(_local_40.targetId, _local_40.sourceId);
                    _local_41 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_local_40.targetId);
                    if ((_local_41 is GameFightFighterInformations))
                    {
                        (_local_41 as GameFightFighterInformations).alive = false;
                    };
                    _local_42 = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                    if (_local_42)
                    {
                        _local_42.outEntity(_local_40.targetId);
                    };
                    FightEntitiesFrame.getCurrentInstance().updateRemovedEntity(_local_40.targetId);
                    return (true);
                case (msg is GameActionFightTriggerEffectMessage):
                    return (true);
                case (msg is GameActionFightDispellEffectMessage):
                    _local_43 = (msg as GameActionFightDispellEffectMessage);
                    this.pushDispellEffectStep(_local_43.targetId, _local_43.boostUID);
                    return (true);
                case (msg is GameActionFightDispellSpellMessage):
                    _local_44 = (msg as GameActionFightDispellSpellMessage);
                    this.pushDispellSpellStep(_local_44.targetId, _local_44.spellId);
                    return (true);
                case (msg is GameActionFightDispellMessage):
                    _local_45 = (msg as GameActionFightDispellMessage);
                    this.pushDispellStep(_local_45.targetId);
                    return (true);
                case (msg is GameActionFightDodgePointLossMessage):
                    _local_46 = (msg as GameActionFightDodgePointLossMessage);
                    this.pushPointsLossDodgeStep(_local_46.targetId, _local_46.actionId, _local_46.amount);
                    return (true);
                case (msg is GameActionFightSpellCooldownVariationMessage):
                    _local_47 = (msg as GameActionFightSpellCooldownVariationMessage);
                    this.pushSpellCooldownVariationStep(_local_47.targetId, _local_47.actionId, _local_47.spellId, _local_47.value);
                    return (true);
                case (msg is GameActionFightSpellImmunityMessage):
                    _local_48 = (msg as GameActionFightSpellImmunityMessage);
                    this.pushSpellImmunityStep(_local_48.targetId);
                    return (true);
                case (msg is GameActionFightInvisibleObstacleMessage):
                    _local_49 = (msg as GameActionFightInvisibleObstacleMessage);
                    this.pushInvisibleObstacleStep(_local_49.sourceId, _local_49.sourceSpellId);
                    return (true);
                case (msg is GameActionFightKillMessage):
                    _local_50 = (msg as GameActionFightKillMessage);
                    this.pushKillStep(_local_50.targetId, _local_50.sourceId);
                    return (true);
                case (msg is GameActionFightReduceDamagesMessage):
                    _local_51 = (msg as GameActionFightReduceDamagesMessage);
                    this.pushReducedDamagesStep(_local_51.targetId, _local_51.amount);
                    return (true);
                case (msg is GameActionFightReflectDamagesMessage):
                    _local_52 = (msg as GameActionFightReflectDamagesMessage);
                    this.pushReflectedDamagesStep(_local_52.sourceId);
                    return (true);
                case (msg is GameActionFightReflectSpellMessage):
                    _local_53 = (msg as GameActionFightReflectSpellMessage);
                    this.pushReflectedSpellStep(_local_53.targetId);
                    return (true);
                case (msg is GameActionFightStealKamaMessage):
                    _local_54 = (msg as GameActionFightStealKamaMessage);
                    this.pushStealKamasStep(_local_54.sourceId, _local_54.targetId, _local_54.amount);
                    return (true);
                case (msg is GameActionFightTackledMessage):
                    _local_55 = (msg as GameActionFightTackledMessage);
                    this.pushTackledStep(_local_55.sourceId);
                    return (true);
                case (msg is GameActionFightTriggerGlyphTrapMessage):
                    if (this._castingSpell)
                    {
                        this._fightBattleFrame.process(new SequenceEndMessage());
                        this._fightBattleFrame.process(new SequenceStartMessage());
                        this._fightBattleFrame.currentSequenceFrame.process(msg);
                        return (true);
                    };
                    _local_56 = (msg as GameActionFightTriggerGlyphTrapMessage);
                    this.pushMarkTriggeredStep(_local_56.triggeringCharacterId, _local_56.sourceId, _local_56.markId);
                    this._fxScriptId = 1;
                    this._castingSpell = new CastingSpell();
                    this._castingSpell.casterId = _local_56.sourceId;
                    _local_57 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_local_56.triggeringCharacterId).disposition.cellId;
                    if (_local_57 != -1)
                    {
                        this._castingSpell.targetedCell = MapPoint.fromCellId(_local_57);
                        this._castingSpell.spell = Spell.getSpellById(1750);
                        this._castingSpell.spellRank = this._castingSpell.spell.getSpellLevel(1);
                    };
                    return (true);
                case (msg is GameActionFightDispellableEffectMessage):
                    _local_58 = (msg as GameActionFightDispellableEffectMessage);
                    if (_local_58.actionId == ActionIdConverter.ACTION_CHARACTER_UPDATE_BOOST)
                    {
                        _local_59 = new CastingSpell(false);
                    }
                    else
                    {
                        _local_59 = new CastingSpell((this._castingSpell == null));
                    };
                    if (this._castingSpell)
                    {
                        _local_59.castingSpellId = this._castingSpell.castingSpellId;
                        if (this._castingSpell.spell.id == _local_58.effect.spellId)
                        {
                            _local_59.spellRank = this._castingSpell.spellRank;
                        };
                    };
                    _local_59.spell = Spell.getSpellById(_local_58.effect.spellId);
                    _local_59.casterId = _local_58.sourceId;
                    _local_60 = _local_58.effect;
                    _local_61 = BuffManager.makeBuffFromEffect(_local_60, _local_59, _local_58.actionId);
                    if ((_local_61 is StateBuff))
                    {
                        sb = (_local_61 as StateBuff);
                        if (sb.actionId == 952)
                        {
                            step = new FightLeavingStateStep(sb.targetId, sb.stateId);
                        }
                        else
                        {
                            step = new FightEnteringStateStep(sb.targetId, sb.stateId, sb.effects.durationString);
                        };
                        if (_local_59 != null)
                        {
                            step.castingSpellId = _local_59.castingSpellId;
                        };
                        this._stepsBuffer.push(step);
                    };
                    if ((_local_60 is FightTemporaryBoostEffect))
                    {
                        actionId = _local_58.actionId;
                        if (((((((((((!((actionId == ActionIdConverter.ACTION_CHARACTER_MAKE_INVISIBLE))) && (!((actionId == ActionIdConverter.ACTION_CHARACTER_UPDATE_BOOST))))) && (!((actionId == ActionIdConverter.ACTION_CHARACTER_CHANGE_LOOK))))) && (!((actionId == ActionIdConverter.ACTION_CHARACTER_CHANGE_COLOR))))) && (!((actionId == ActionIdConverter.ACTION_CHARACTER_ADD_APPEARANCE))))) && (!((actionId == ActionIdConverter.ACTION_FIGHT_SET_STATE)))))
                        {
                            this.pushTemporaryBoostStep(_local_58.effect.targetId, _local_61.effects.description, _local_61.effects.duration, _local_61.effects.durationString);
                        };
                    };
                    this.pushDisplayBuffStep(_local_61);
                    return (true);
                case (msg is GameActionFightModifyEffectsDurationMessage):
                    _local_62 = (msg as GameActionFightModifyEffectsDurationMessage);
                    this.pushModifyEffectsDurationStep(_local_62.sourceId, _local_62.targetId, _local_62.delta);
                    return (false);
                case (msg is GameActionFightCarryCharacterMessage):
                    _local_63 = (msg as GameActionFightCarryCharacterMessage);
                    if (_local_63.cellId != -1)
                    {
                        this.pushCarryCharacterStep(_local_63.sourceId, _local_63.targetId, _local_63.cellId);
                    };
                    return (false);
                case (msg is GameActionFightThrowCharacterMessage):
                    _local_64 = (msg as GameActionFightThrowCharacterMessage);
                    _local_65 = ((this._castingSpell) ? this._castingSpell.targetedCell.cellId : _local_64.cellId);
                    this.pushThrowCharacterStep(_local_64.sourceId, _local_64.targetId, _local_65);
                    return (false);
                case (msg is GameActionFightDropCharacterMessage):
                    _local_66 = (msg as GameActionFightDropCharacterMessage);
                    _local_67 = _local_66.cellId;
                    if ((((_local_67 == -1)) && (this._castingSpell)))
                    {
                        _local_67 = this._castingSpell.targetedCell.cellId;
                    };
                    this.pushThrowCharacterStep(_local_66.sourceId, _local_66.targetId, _local_67);
                    return (false);
                case (msg is GameActionFightInvisibleDetectedMessage):
                    _local_68 = (msg as GameActionFightInvisibleDetectedMessage);
                    this.pushFightInvisibleTemporarilyDetectedStep(_local_68.sourceId, _local_68.cellId);
                    FightEntitiesFrame.getCurrentInstance().setLastKnownEntityPosition(_local_68.targetId, _local_68.cellId);
                    FightEntitiesFrame.getCurrentInstance().setLastKnownEntityMovementPoint(_local_68.targetId, 0);
                    return (true);
                case (msg is GameFightTurnListMessage):
                    _local_69 = (msg as GameFightTurnListMessage);
                    this.pushTurnListStep(_local_69.ids, _local_69.deadsIds);
                    return (true);
                case (msg is AbstractGameActionMessage):
                    _log.error((("Unsupported game action " + msg) + " ! This action was discarded."));
                    return (true);
            };
            return (false);
        }

        public function execute(callback:Function=null):void
        {
            var script:BinaryScript;
            var scriptRunner:SpellFxRunner;
            this._sequencer = new SerialSequencer(FIGHT_SEQUENCERS_CATEGORY);
            if (this._parent)
            {
                _log.info("Process sub sequence");
                this._parent.addSubSequence(this._sequencer);
            }
            else
            {
                _log.info("Execute sequence");
            };
            if (this._fxScriptId > 0)
            {
                script = DofusEmbedScript.getScript(this._fxScriptId);
                scriptRunner = new SpellFxRunner(this);
                this._scriptStarted = getTimer();
                ScriptExec.exec(script, scriptRunner, true, new Callback(this.executeBuffer, callback, true, true), new Callback(this.executeBuffer, callback, true, false));
            }
            else
            {
                this.executeBuffer(callback, false);
            };
        }

        private function executeBuffer(callback:Function, hadScript:Boolean, scriptSuccess:Boolean=false):void
        {
            var step:ISequencable;
            var allowHitAnim:Boolean;
            var allowSpellEffects:Boolean;
            var startStep:Array;
            var endStep:Array;
            var removed:Boolean;
            var entityAttaqueAnimWait:Dictionary;
            var lifeLoseSum:Dictionary;
            var lifeLoseLastStep:Dictionary;
            var shieldLoseSum:Dictionary;
            var shieldLoseLastStep:Dictionary;
            var i:int;
            var b:*;
            var index:*;
            var waitStep:WaitAnimationEventStep;
            var scriptTook:uint;
            var _local_25:PlayAnimationStep;
            var _local_26:FightDeathStep;
            var _local_27:int;
            var _local_28:FightActionPointsVariationStep;
            var _local_29:FightShieldPointsVariationStep;
            var _local_30:FightLifeVariationStep;
            var idx:int;
            var idx2:int;
            var loseLifeTarget:*;
            var j:uint;
            if (hadScript)
            {
                scriptTook = (getTimer() - this._scriptStarted);
                if (!(scriptSuccess))
                {
                    _log.warn((("Script failed during a fight sequence, but still took " + scriptTook) + "ms."));
                }
                else
                {
                    _log.info((("Script successfuly executed in " + scriptTook) + "ms."));
                };
            };
            var cleanedBuffer:Array = [];
            var deathStepRef:Dictionary = new Dictionary(true);
            var hitStep:Dictionary = new Dictionary(true);
            var loseLifeStep:Dictionary = new Dictionary(true);
            var waitHitEnd:Boolean;
            for each (step in this._stepsBuffer)
            {
                switch (true)
                {
                    case (step is FightMarkTriggeredStep):
                        waitHitEnd = true;
                        break;
                };
            };
            allowHitAnim = OptionManager.getOptionManager("dofus")["allowHitAnim"];
            allowSpellEffects = OptionManager.getOptionManager("dofus")["allowSpellEffects"];
            startStep = [];
            endStep = [];
            entityAttaqueAnimWait = new Dictionary();
            lifeLoseSum = new Dictionary(true);
            lifeLoseLastStep = new Dictionary(true);
            shieldLoseSum = new Dictionary(true);
            shieldLoseLastStep = new Dictionary(true);
            i = this._stepsBuffer.length;
            while (--i >= 0)
            {
                if (((removed) && (step)))
                {
                    step.clear();
                };
                removed = true;
                step = this._stepsBuffer[i];
                switch (true)
                {
                    case (step is PlayAnimationStep):
                        _local_25 = (step as PlayAnimationStep);
                        if (_local_25.animation.indexOf(AnimationEnum.ANIM_HIT) != -1)
                        {
                            if (!(allowHitAnim)) continue;
                            _local_25.waitEvent = waitHitEnd;
                            if (_local_25.target == null)
                            {
                                continue;
                            };
                            if (deathStepRef[EntitiesManager.getInstance().getEntityID((_local_25.target as IEntity))])
                            {
                                continue;
                            };
                            if (hitStep[_local_25.target])
                            {
                                continue;
                            };
                            if (((((!((_local_25.animation == AnimationEnum.ANIM_HIT))) && (!((_local_25.animation == AnimationEnum.ANIM_HIT_CARRYING))))) && (!(_local_25.target.hasAnimation(_local_25.animation, 1)))))
                            {
                                _local_25.animation = AnimationEnum.ANIM_HIT;
                            };
                            hitStep[_local_25.target] = true;
                        };
                        if (this._castingSpell.casterId < 0)
                        {
                            if (entityAttaqueAnimWait[_local_25.target])
                            {
                                cleanedBuffer.unshift(entityAttaqueAnimWait[_local_25.target]);
                                delete entityAttaqueAnimWait[_local_25.target];
                            };
                            if (_local_25.animation.indexOf(AnimationEnum.ANIM_ATTAQUE_BASE) != -1)
                            {
                                entityAttaqueAnimWait[_local_25.target] = new WaitAnimationEventStep(_local_25);
                            };
                        };
                        break;
                    case (step is FightDeathStep):
                        _local_26 = (step as FightDeathStep);
                        deathStepRef[_local_26.entityId] = true;
                        _local_27 = this._fightBattleFrame.targetedEntities.indexOf(_local_26.entityId);
                        if (_local_27 != -1)
                        {
                            this._fightBattleFrame.targetedEntities.splice(_local_27, 1);
                            TooltipManager.hide(("tooltipOverEntity_" + _local_26.entityId));
                        };
                        break;
                    case (step is FightActionPointsVariationStep):
                        _local_28 = (step as FightActionPointsVariationStep);
                        if (_local_28.voluntarlyUsed)
                        {
                            startStep.push(_local_28);
                            removed = false;
                            continue;
                        };
                        break;
                    case (step is FightShieldPointsVariationStep):
                        _local_29 = (step as FightShieldPointsVariationStep);
                        if (_local_30.target == null)
                        {
                            break;
                        };
                        if (shieldLoseSum[_local_29.target] == null)
                        {
                            shieldLoseSum[_local_29.target] = 0;
                        };
                        shieldLoseSum[_local_29.target] = (shieldLoseSum[_local_29.target] + _local_29.value);
                        shieldLoseLastStep[_local_29.target] = _local_29;
                        this.showTargetTooltip(_local_29.target.id);
                        break;
                    case (step is FightLifeVariationStep):
                        _local_30 = (step as FightLifeVariationStep);
                        if (_local_30.target == null)
                        {
                            break;
                        };
                        if (_local_30.delta < 0)
                        {
                            loseLifeStep[_local_30.target] = _local_30;
                        };
                        if (lifeLoseSum[_local_30.target] == null)
                        {
                            lifeLoseSum[_local_30.target] = 0;
                        };
                        lifeLoseSum[_local_30.target] = (lifeLoseSum[_local_30.target] + _local_30.delta);
                        lifeLoseLastStep[_local_30.target] = _local_30;
                        this.showTargetTooltip(_local_30.target.id);
                        break;
                    case (step is AddGfxEntityStep):
                    case (step is AddGfxInLineStep):
                    case (step is ParableGfxMovementStep):
                    case (step is AddWorldEntityStep):
                        if (!(allowSpellEffects)) continue;
                        break;
                };
                removed = false;
                cleanedBuffer.unshift(step);
            };
            for each (b in cleanedBuffer)
            {
                if ((((((b is FightLifeVariationStep)) && ((lifeLoseSum[b.target] == 0)))) && (!((shieldLoseSum[b.target] == null)))))
                {
                    b.skipTextEvent = true;
                };
            };
            for (index in lifeLoseSum)
            {
                if (((!((index == "null"))) && (!((lifeLoseSum[index] == 0)))))
                {
                    idx = cleanedBuffer.indexOf(lifeLoseLastStep[index]);
                    cleanedBuffer.splice(idx, 0, new FightLossAnimStep(index, lifeLoseSum[index], FightLifeVariationStep.COLOR));
                };
                lifeLoseLastStep[index] = -1;
                lifeLoseSum[index] = 0;
            };
            for (index in shieldLoseSum)
            {
                if (((!((index == "null"))) && (!((shieldLoseSum[index] == 0)))))
                {
                    idx2 = cleanedBuffer.indexOf(shieldLoseLastStep[index]);
                    cleanedBuffer.splice(idx2, 0, new FightLossAnimStep(index, shieldLoseSum[index], FightShieldPointsVariationStep.COLOR));
                };
                shieldLoseLastStep[index] = -1;
                shieldLoseSum[index] = 0;
            };
            for each (waitStep in entityAttaqueAnimWait)
            {
                endStep.push(waitStep);
            };
            if (allowHitAnim)
            {
                for (loseLifeTarget in loseLifeStep)
                {
                    if (!(hitStep[loseLifeTarget]))
                    {
                        j = 0;
                        while (j < cleanedBuffer.length)
                        {
                            if (cleanedBuffer[j] == loseLifeStep[loseLifeTarget])
                            {
                                cleanedBuffer.splice(j, 0, new PlayAnimationStep((loseLifeTarget as TiphonSprite), AnimationEnum.ANIM_HIT, true, false));
                                break;
                            };
                            j++;
                        };
                    };
                };
            };
            cleanedBuffer = startStep.concat(cleanedBuffer).concat(endStep);
            for each (step in cleanedBuffer)
            {
                this._sequencer.addStep(step);
            };
            this.clearBuffer();
            if (((!((callback == null))) && (!(this._parent))))
            {
                this._sequenceEndCallback = callback;
                this._sequencer.addEventListener(SequencerEvent.SEQUENCE_END, this.onSequenceEnd);
            };
            _lastCastingSpell = this._castingSpell;
            this._scriptInit = true;
            if (!(this._parent))
            {
                if (!(this._subSequenceWaitingCount))
                {
                    this._sequencer.start();
                }
                else
                {
                    _log.warn((("Waiting sub sequence init end (" + this._subSequenceWaitingCount) + " seq)"));
                };
            }
            else
            {
                if (callback != null)
                {
                    (callback());
                };
                this._parent.subSequenceInitDone();
            };
        }

        private function onSequenceEnd(e:SequencerEvent):void
        {
            this._sequencer.removeEventListener(SequencerEvent.SEQUENCE_END, this.onSequenceEnd);
            this._sequenceEndCallback();
        }

        private function subSequenceInitDone():void
        {
            this._subSequenceWaitingCount--;
            if (((((!(this.isWaiting)) && (this._sequencer))) && (!(this._sequencer.running))))
            {
                _log.warn("Sub sequence init end -- Run main sequence");
                this._sequencer.start();
            };
        }

        private function pushMovementStep(fighterId:int, path:MovementPath):void
        {
            this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip, fighterId)));
            var step:FightEntityMovementStep = new FightEntityMovementStep(fighterId, path);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushTeleportStep(fighterId:int, destinationCell:int):void
        {
            var step:FightTeleportStep;
            this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip, fighterId)));
            if (destinationCell != -1)
            {
                step = new FightTeleportStep(fighterId, MapPoint.fromCellId(destinationCell));
                if (this.castingSpell != null)
                {
                    step.castingSpellId = this.castingSpell.castingSpellId;
                };
                this._stepsBuffer.push(step);
            };
        }

        private function pushExchangePositionsStep(fighterOneId:int, fighterOneNewCell:int, fighterTwoId:int, fighterTwoNewCell:int):void
        {
            this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip, fighterOneId)));
            this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip, fighterTwoId)));
            var step:FightExchangePositionsStep = new FightExchangePositionsStep(fighterOneId, fighterOneNewCell, fighterTwoId, fighterTwoNewCell);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushSlideStep(fighterId:int, startCell:int, endCell:int):void
        {
            if ((((startCell < 0)) || ((endCell < 0))))
            {
                return;
            };
            this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip, fighterId)));
            var step:FightEntitySlideStep = new FightEntitySlideStep(fighterId, MapPoint.fromCellId(startCell), MapPoint.fromCellId(endCell));
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushSummonStep(summonerId:int, summonInfos:GameFightFighterInformations):void
        {
            var step:FightSummonStep = new FightSummonStep(summonerId, summonInfos);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushVisibilityStep(fighterId:int, visibility:Boolean):void
        {
            var step:FightVisibilityStep = new FightVisibilityStep(fighterId, visibility);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushMarkCellsStep(markId:int, markType:int, cells:Vector.<GameActionMarkedCell>, markSpellId:int):void
        {
            var step:FightMarkCellsStep = new FightMarkCellsStep(markId, markType, this._castingSpell.spellRank, cells, markSpellId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushUnmarkCellsStep(markId:int):void
        {
            var step:FightUnmarkCellsStep = new FightUnmarkCellsStep(markId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushChangeLookStep(fighterId:int, newLook:EntityLook):void
        {
            var step:FightChangeLookStep = new FightChangeLookStep(fighterId, EntityLookAdapter.fromNetwork(newLook));
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushChangeVisibilityStep(fighterId:int, visibilityState:int):void
        {
            var step:FightChangeVisibilityStep = new FightChangeVisibilityStep(fighterId, visibilityState);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushPointsVariationStep(fighterId:int, actionId:uint, delta:int):void
        {
            var step:IFightStep;
            switch (actionId)
            {
                case ActionIdConverter.ACTION_CHARACTER_ACTION_POINTS_USE:
                    step = new FightActionPointsVariationStep(fighterId, delta, true);
                    break;
                case ActionIdConverter.ACTION_CHARACTER_ACTION_POINTS_LOST:
                case ActionIdConverter.ACTION_CHARACTER_ACTION_POINTS_WIN:
                    step = new FightActionPointsVariationStep(fighterId, delta, false);
                    break;
                case ActionIdConverter.ACTION_CHARACTER_MOVEMENT_POINTS_USE:
                    step = new FightMovementPointsVariationStep(fighterId, delta, true);
                    break;
                case ActionIdConverter.ACTION_CHARACTER_MOVEMENT_POINTS_LOST:
                case ActionIdConverter.ACTION_CHARACTER_MOVEMENT_POINTS_WIN:
                    step = new FightMovementPointsVariationStep(fighterId, delta, false);
                    break;
                default:
                    _log.warn((("Points variation with unsupported action (" + actionId) + "), skipping."));
                    return;
            };
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushShieldPointsVariationStep(fighterId:int, delta:int, actionId:int):void
        {
            var step:FightShieldPointsVariationStep = new FightShieldPointsVariationStep(fighterId, delta, actionId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushTemporaryBoostStep(fighterId:int, statName:String, duration:int, durationText:String):void
        {
            var step:FightTemporaryBoostStep = new FightTemporaryBoostStep(fighterId, statName, duration, durationText);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushPointsLossDodgeStep(fighterId:int, actionId:uint, amount:int):void
        {
            var step:IFightStep;
            switch (actionId)
            {
                case ActionIdConverter.ACTION_FIGHT_SPELL_DODGED_PA:
                    step = new FightActionPointsLossDodgeStep(fighterId, amount);
                    break;
                case ActionIdConverter.ACTION_FIGHT_SPELL_DODGED_PM:
                    step = new FightMovementPointsLossDodgeStep(fighterId, amount);
                    break;
                default:
                    _log.warn((("Points dodge with unsupported action (" + actionId) + "), skipping."));
                    return;
            };
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushLifePointsVariationStep(fighterId:int, delta:int, permanentDamages:int, action:int):void
        {
            var step:FightLifeVariationStep = new FightLifeVariationStep(fighterId, delta, permanentDamages, action);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushDeathStep(fighterId:int, naturalDeath:Boolean=true):void
        {
            var step:FightDeathStep = new FightDeathStep(fighterId, naturalDeath);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushVanishStep(fighterId:int, sourceId:int):void
        {
            var step:FightVanishStep = new FightVanishStep(fighterId, sourceId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushDispellStep(fighterId:int):void
        {
            var step:FightDispellStep = new FightDispellStep(fighterId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushDispellEffectStep(fighterId:int, boostUID:int):void
        {
            var step:FightDispellEffectStep = new FightDispellEffectStep(fighterId, boostUID);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushDispellSpellStep(fighterId:int, spellId:int):void
        {
            var step:FightDispellSpellStep = new FightDispellSpellStep(fighterId, spellId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushSpellCooldownVariationStep(targetId:int, actionId:int, spellId:int, delta:int):void
        {
            var step:FightSpellCooldownVariationStep = new FightSpellCooldownVariationStep(targetId, actionId, spellId, delta);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushSpellImmunityStep(targetId:int):void
        {
            var step:FightSpellImmunityStep = new FightSpellImmunityStep(targetId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushInvisibleObstacleStep(fighterId:int, spellLevelId:int):void
        {
            var step:FightInvisibleObstacleStep = new FightInvisibleObstacleStep(fighterId, spellLevelId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushKillStep(fighterId:int, killerId:int):void
        {
            var step:FightKillStep = new FightKillStep(fighterId, killerId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushReducedDamagesStep(fighterId:int, amount:int):void
        {
            var step:FightReducedDamagesStep = new FightReducedDamagesStep(fighterId, amount);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushReflectedDamagesStep(fighterId:int):void
        {
            var step:FightReflectedDamagesStep = new FightReflectedDamagesStep(fighterId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushReflectedSpellStep(fighterId:int):void
        {
            var step:FightReflectedSpellStep = new FightReflectedSpellStep(fighterId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushSpellCastStep(fighterId:int, cellId:int, sourceCellId:int, spellId:int, spellRank:uint, critical:uint):void
        {
            var step:FightSpellCastStep = new FightSpellCastStep(fighterId, cellId, sourceCellId, spellId, spellRank, critical);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushCloseCombatStep(fighterId:int, closeCombatWeaponId:uint, critical:uint):void
        {
            var step:FightCloseCombatStep = new FightCloseCombatStep(fighterId, closeCombatWeaponId, critical);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushStealKamasStep(robberId:int, victimId:int, amount:uint):void
        {
            var step:FightStealingKamasStep = new FightStealingKamasStep(robberId, victimId, amount);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushTackledStep(fighterId:int):void
        {
            var step:FightTackledStep = new FightTackledStep(fighterId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushMarkTriggeredStep(fighterId:int, casterId:int, markId:int):void
        {
            var step:FightMarkTriggeredStep = new FightMarkTriggeredStep(fighterId, casterId, markId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushDisplayBuffStep(buff:BasicBuff):void
        {
            var step:FightDisplayBuffStep = new FightDisplayBuffStep(buff);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushModifyEffectsDurationStep(sourceId:int, targetId:int, delta:int):void
        {
            var step:FightModifyEffectsDurationStep = new FightModifyEffectsDurationStep(sourceId, targetId, delta);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushCarryCharacterStep(fighterId:int, carriedId:int, cellId:int):void
        {
            var step:FightCarryCharacterStep = new FightCarryCharacterStep(fighterId, carriedId, cellId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
            this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip, carriedId)));
        }

        private function pushThrowCharacterStep(fighterId:int, carriedId:int, cellId:int):void
        {
            var step:FightThrowCharacterStep = new FightThrowCharacterStep(fighterId, carriedId, cellId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushFightInvisibleTemporarilyDetectedStep(targetId:int, cellId:uint):void
        {
            var targetSprite:AnimatedCharacter = (DofusEntities.getEntity(targetId) as AnimatedCharacter);
            var step:FightInvisibleTemporarilyDetectedStep = new FightInvisibleTemporarilyDetectedStep(targetSprite, cellId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushTurnListStep(turnsList:Vector.<int>, deadTurnsList:Vector.<int>):void
        {
            var step:FightTurnListStep = new FightTurnListStep(turnsList, deadTurnsList);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function clearBuffer():void
        {
            this._stepsBuffer = new Vector.<ISequencable>(0, false);
        }

        private function showTargetTooltip(pEntityId:int):void
        {
            var fcf:FightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            var entityInfos:GameFightFighterInformations = (this.fightEntitiesFrame.getEntityInfos(pEntityId) as GameFightFighterInformations);
            if (((((((((entityInfos.alive) && (this._castingSpell))) && ((((this._castingSpell.casterId == PlayedCharacterManager.getInstance().id)) || (fcf.battleFrame.playingSlaveEntity))))) && (!((pEntityId == this.castingSpell.casterId))))) && ((this._fightBattleFrame.targetedEntities.indexOf(pEntityId) == -1))))
            {
                this._fightBattleFrame.targetedEntities.push(pEntityId);
                if (OptionManager.getOptionManager("dofus")["showPermanentTargetsTooltips"] == true)
                {
                    fcf.displayEntityTooltip(pEntityId);
                };
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.frames

