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
    import com.ankamagames.jerakine.types.positions.MovementPath;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightPointsVariationMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifeAndShieldPointsLostMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifePointsGainMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifePointsLostMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTeleportOnSameMapMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightExchangePositionsMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSlideMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSummonMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightMarkCellsMessage;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
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
    import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightActivateGlyphTrapMessage;
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
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightSpellCooldown;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.atouin.types.GraphicCell;
    import flash.geom.Point;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
    import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterRandomStaticPoseMessage;
    import flash.display.Sprite;
    import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterMessage;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
    import com.ankamagames.dofus.logic.game.fight.types.StateBuff;
    import com.ankamagames.dofus.network.enums.FightSpellCastCriticalEnum;
    import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
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
    import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
    import com.ankamagames.dofus.logic.game.fight.miscs.TackleUtil;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTriggerEffectMessage;
    import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceEndMessage;
    import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceStartMessage;
    import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
    import com.ankamagames.dofus.logic.game.fight.steps.FightLeavingStateStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightEnteringStateStep;
    import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostEffect;
    import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
    import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
    import com.ankamagames.jerakine.messages.Message;
    import flash.utils.getTimer;
    import com.ankamagames.dofus.scripts.SpellScriptManager;
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
    import com.ankamagames.dofus.logic.game.fight.steps.FightMarkActivateStep;
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
        private var _teleportThroughPortal:Boolean;
        private var _teleportPortalId:int;

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
            var fightContextFrame:FightContextFrame;
            var _local_3:GameActionFightSpellCastMessage;
            var _local_4:Boolean;
            var _local_5:uint;
            var _local_6:int;
            var _local_7:Boolean;
            var _local_8:Dictionary;
            var _local_9:GameFightFighterInformations;
            var _local_10:PlayedCharacterManager;
            var _local_11:Boolean;
            var _local_12:GameFightFighterInformations;
            var _local_13:GameMapMovementMessage;
            var _local_14:MovementPath;
            var _local_15:Vector.<uint>;
            var _local_16:GameActionFightPointsVariationMessage;
            var _local_17:GameActionFightLifeAndShieldPointsLostMessage;
            var _local_18:GameActionFightLifePointsGainMessage;
            var _local_19:GameActionFightLifePointsLostMessage;
            var _local_20:GameActionFightTeleportOnSameMapMessage;
            var _local_21:Boolean;
            var _local_22:GameActionFightExchangePositionsMessage;
            var _local_23:GameActionFightSlideMessage;
            var _local_24:GameActionFightSummonMessage;
            var _local_25:GameActionFightMarkCellsMessage;
            var _local_26:uint;
            var _local_27:SpellLevel;
            var _local_28:GameActionFightUnmarkCellsMessage;
            var _local_29:GameActionFightChangeLookMessage;
            var _local_30:GameActionFightInvisibilityMessage;
            var _local_31:GameContextActorInformations;
            var _local_32:GameActionFightLeaveMessage;
            var _local_33:Dictionary;
            var _local_34:GameContextActorInformations;
            var _local_35:GameActionFightDeathMessage;
            var _local_36:Dictionary;
            var _local_37:GameFightFighterInformations;
            var _local_38:int;
            var _local_39:GameFightFighterInformations;
            var _local_40:GameFightFighterInformations;
            var _local_41:GameFightFighterInformations;
            var _local_42:GameContextActorInformations;
            var _local_43:FightTurnFrame;
            var _local_44:Boolean;
            var _local_45:GameActionFightVanishMessage;
            var _local_46:GameContextActorInformations;
            var _local_47:GameActionFightDispellEffectMessage;
            var _local_48:GameActionFightDispellSpellMessage;
            var _local_49:GameActionFightDispellMessage;
            var _local_50:GameActionFightDodgePointLossMessage;
            var _local_51:GameActionFightSpellCooldownVariationMessage;
            var _local_52:GameActionFightSpellImmunityMessage;
            var _local_53:GameActionFightInvisibleObstacleMessage;
            var _local_54:GameActionFightKillMessage;
            var _local_55:GameActionFightReduceDamagesMessage;
            var _local_56:GameActionFightReflectDamagesMessage;
            var _local_57:GameActionFightReflectSpellMessage;
            var _local_58:GameActionFightStealKamaMessage;
            var _local_59:GameActionFightTackledMessage;
            var _local_60:GameActionFightTriggerGlyphTrapMessage;
            var _local_61:int;
            var _local_62:MarkInstance;
            var _local_63:GameActionFightActivateGlyphTrapMessage;
            var _local_64:GameActionFightDispellableEffectMessage;
            var _local_65:CastingSpell;
            var _local_66:AbstractFightDispellableEffect;
            var _local_67:BasicBuff;
            var _local_68:GameActionFightModifyEffectsDurationMessage;
            var _local_69:GameActionFightCarryCharacterMessage;
            var _local_70:GameActionFightThrowCharacterMessage;
            var _local_71:uint;
            var _local_72:GameActionFightDropCharacterMessage;
            var _local_73:uint;
            var _local_74:GameActionFightInvisibleDetectedMessage;
            var _local_75:GameFightTurnListMessage;
            var _local_76:GameActionFightCloseCombatMessage;
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
            var spellEffect:EffectInstanceDice;
            var gfsfrsmsg:GameFightShowFighterRandomStaticPoseMessage;
            var illusionCreature:Sprite;
            var _local_96:GameFightShowFighterMessage;
            var _local_97:Sprite;
            var _local_98:int;
            var isBomb:Boolean;
            var isCreature:Boolean;
            var _local_101:GameContextActorInformations;
            var _local_102:GameFightMonsterInformations;
            var monsterS:Monster;
            var _local_104:GameFightCharacterInformations;
            var _local_105:Spell;
            var _local_106:EffectInstanceDice;
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
                        _local_3 = (msg as GameActionFightSpellCastMessage);
                    }
                    else
                    {
                        _local_76 = (msg as GameActionFightCloseCombatMessage);
                        _local_4 = true;
                        _local_5 = _local_76.weaponGenericId;
                        _local_3 = new GameActionFightSpellCastMessage();
                        _local_3.initGameActionFightSpellCastMessage(_local_76.actionId, _local_76.sourceId, _local_76.targetId, _local_76.destinationCellId, _local_76.critical, _local_76.silentCast, 0, 1);
                    };
                    _local_6 = this.fightEntitiesFrame.getEntityInfos(_local_3.sourceId).disposition.cellId;
                    if (this._castingSpell)
                    {
                        if (((_local_4) && (!((_local_5 == 0)))))
                        {
                            this.pushCloseCombatStep(_local_3.sourceId, _local_5, _local_3.critical);
                        }
                        else
                        {
                            this.pushSpellCastStep(_local_3.sourceId, _local_3.destinationCellId, _local_6, _local_3.spellId, _local_3.spellLevel, _local_3.critical);
                        };
                        _log.error((("Il ne peut y avoir qu'un seul cast de sort par séquence (" + msg) + ")"));
                        break;
                    };
                    this._castingSpell = new CastingSpell();
                    this._castingSpell.casterId = _local_3.sourceId;
                    this._castingSpell.spell = Spell.getSpellById(_local_3.spellId);
                    this._castingSpell.spellRank = this._castingSpell.spell.getSpellLevel(_local_3.spellLevel);
                    this._castingSpell.isCriticalFail = (_local_3.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL);
                    this._castingSpell.isCriticalHit = (_local_3.critical == FightSpellCastCriticalEnum.CRITICAL_HIT);
                    this._castingSpell.silentCast = _local_3.silentCast;
                    this._castingSpell.portalIds = _local_3.portalsIds;
                    this._castingSpell.portalMapPoints = MarkedCellsManager.getInstance().getMapPointsFromMarkIds(_local_3.portalsIds);
                    if (!(this._fightBattleFrame.currentPlayerId))
                    {
                        BuffManager.getInstance().spellBuffsToIgnore.push(this._castingSpell);
                    };
                    if (_local_3.destinationCellId != -1)
                    {
                        this._castingSpell.targetedCell = MapPoint.fromCellId(_local_3.destinationCellId);
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
                    if ((((_local_3.sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId)) && (!((_local_3.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL)))))
                    {
                        spellTargetEntities = new Array();
                        spellTargetEntities.push(_local_3.targetId);
                        CurrentPlayedFighterManager.getInstance().getSpellCastManager().castSpell(_local_3.spellId, _local_3.spellLevel, spellTargetEntities);
                    };
                    _local_7 = (_local_3.critical == FightSpellCastCriticalEnum.CRITICAL_HIT);
                    _local_8 = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
                    _local_9 = _local_8[_local_3.sourceId];
                    if (((_local_4) && (!((_local_5 == 0)))))
                    {
                        this.pushCloseCombatStep(_local_3.sourceId, _local_5, _local_3.critical);
                    }
                    else
                    {
                        this.pushSpellCastStep(_local_3.sourceId, _local_3.destinationCellId, _local_6, _local_3.spellId, _local_3.spellLevel, _local_3.critical);
                    };
                    if (_local_3.sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId)
                    {
                        KernelEventsManager.getInstance().processCallback(TriggerHookList.FightSpellCast);
                    };
                    _local_10 = PlayedCharacterManager.getInstance();
                    _local_11 = false;
                    if (((((_local_8[_local_10.id]) && (_local_9))) && (((_local_8[_local_10.id] as GameFightFighterInformations).teamId == _local_9.teamId))))
                    {
                        _local_11 = true;
                    };
                    if (((((!((_local_3.sourceId == _local_10.id))) && (_local_11))) && (!(this._castingSpell.isCriticalFail))))
                    {
                        isSpellKnown = false;
                        for each (spellKnown in _local_10.spellsInventory)
                        {
                            if (spellKnown.id == _local_3.spellId)
                            {
                                isSpellKnown = true;
                                playerSpellLevel = spellKnown.spellLevelInfos;
                                break;
                            };
                        };
                        spell = Spell.getSpellById(_local_3.spellId);
                        castSpellLevel = spell.getSpellLevel(_local_3.spellLevel);
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
                                this.pushSpellCooldownVariationStep(_local_10.id, 0, _local_3.spellId, gcdValue);
                            };
                            fightEntities = this.fightEntitiesFrame.getEntitiesDictionnary();
                            simf = (Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame);
                            for each (fighterInfos in fightEntities)
                            {
                                if ((((((fighterInfos is GameFightCompanionInformations)) && (!((_local_3.sourceId == fighterInfos.contextualId))))) && (((fighterInfos as GameFightCompanionInformations).masterId == _local_10.id))))
                                {
                                    gfsc = new GameFightSpellCooldown();
                                    gfsc.initGameFightSpellCooldown(_local_3.spellId, castSpellLevel.globalCooldown);
                                    simf.addSpellGlobalCoolDownInfo(fighterInfos.contextualId, gfsc);
                                };
                            };
                        };
                    };
                    _local_38 = PlayedCharacterManager.getInstance().id;
                    _local_39 = (this.fightEntitiesFrame.getEntityInfos(_local_3.sourceId) as GameFightFighterInformations);
                    _local_41 = (this.fightEntitiesFrame.getEntityInfos(_local_38) as GameFightFighterInformations);
                    if (_local_7)
                    {
                        if (_local_3.sourceId == _local_38)
                        {
                            SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_OWNER);
                        }
                        else
                        {
                            if (((_local_41) && ((_local_39.teamId == _local_41.teamId))))
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
                        if (_local_3.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL)
                        {
                            if (_local_3.sourceId == _local_38)
                            {
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_OWNER);
                            }
                            else
                            {
                                if (((_local_41) && ((_local_39.teamId == _local_41.teamId))))
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
                    _local_12 = (this.fightEntitiesFrame.getEntityInfos(_local_3.targetId) as GameFightFighterInformations);
                    if (((_local_12) && ((_local_12.disposition.cellId == -1))))
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
                            ts = (DofusEntities.getEntity(_local_3.targetId) as TiphonSprite);
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
                    _local_13 = (msg as GameMapMovementMessage);
                    if (_local_13.actorId == CurrentPlayedFighterManager.getInstance().currentFighterId)
                    {
                        KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerFightMove);
                    };
                    _local_14 = MapMovementAdapter.getClientMovement(_local_13.keyMovements);
                    _local_15 = _local_14.getCells();
                    fightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                    fightContextFrame.saveFighterPosition(_local_13.actorId, _local_15[(_local_15.length - 2)]);
                    this.pushMovementStep(_local_13.actorId, _local_14);
                    return (true);
                case (msg is GameActionFightPointsVariationMessage):
                    _local_16 = (msg as GameActionFightPointsVariationMessage);
                    this.pushPointsVariationStep(_local_16.targetId, _local_16.actionId, _local_16.delta);
                    return (true);
                case (msg is GameActionFightLifeAndShieldPointsLostMessage):
                    _local_17 = (msg as GameActionFightLifeAndShieldPointsLostMessage);
                    this.pushShieldPointsVariationStep(_local_17.targetId, -(_local_17.shieldLoss), _local_17.actionId);
                    this.pushLifePointsVariationStep(_local_17.targetId, -(_local_17.loss), -(_local_17.permanentDamages), _local_17.actionId);
                    return (true);
                case (msg is GameActionFightLifePointsGainMessage):
                    _local_18 = (msg as GameActionFightLifePointsGainMessage);
                    this.pushLifePointsVariationStep(_local_18.targetId, _local_18.delta, 0, _local_18.actionId);
                    return (true);
                case (msg is GameActionFightLifePointsLostMessage):
                    _local_19 = (msg as GameActionFightLifePointsLostMessage);
                    this.pushLifePointsVariationStep(_local_19.targetId, -(_local_19.loss), -(_local_19.permanentDamages), _local_19.actionId);
                    return (true);
                case (msg is GameActionFightTeleportOnSameMapMessage):
                    _local_20 = (msg as GameActionFightTeleportOnSameMapMessage);
                    fightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                    if (((this._castingSpell) && (this._castingSpell.spellRank)))
                    {
                        for each (spellEffect in this._castingSpell.spellRank.effects)
                        {
                            if (spellEffect.effectId == 1100)
                            {
                                _local_21 = true;
                                break;
                            };
                        };
                    };
                    if (!(_local_21))
                    {
                        if (!(this._teleportThroughPortal))
                        {
                            fightContextFrame.saveFighterPosition(_local_20.targetId, fightContextFrame.entitiesFrame.getEntityInfos(_local_20.targetId).disposition.cellId);
                        }
                        else
                        {
                            fightContextFrame.saveFighterPosition(_local_20.targetId, MarkedCellsManager.getInstance().getMarkDatas(this._teleportPortalId).cells[0]);
                        };
                    };
                    this.pushTeleportStep(_local_20.targetId, _local_20.cellId);
                    this._teleportThroughPortal = false;
                    return (true);
                case (msg is GameActionFightExchangePositionsMessage):
                    _local_22 = (msg as GameActionFightExchangePositionsMessage);
                    fightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                    fightContextFrame.saveFighterPosition(_local_22.sourceId, _local_22.casterCellId);
                    fightContextFrame.saveFighterPosition(_local_22.targetId, _local_22.targetCellId);
                    this.pushExchangePositionsStep(_local_22.sourceId, _local_22.casterCellId, _local_22.targetId, _local_22.targetCellId);
                    return (true);
                case (msg is GameActionFightSlideMessage):
                    _local_23 = (msg as GameActionFightSlideMessage);
                    fightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                    fightContextFrame.saveFighterPosition(_local_23.targetId, fightContextFrame.entitiesFrame.getEntityInfos(_local_23.targetId).disposition.cellId);
                    this.pushSlideStep(_local_23.targetId, _local_23.startCellId, _local_23.endCellId);
                    return (true);
                case (msg is GameActionFightSummonMessage):
                    _local_24 = (msg as GameActionFightSummonMessage);
                    if ((((_local_24.actionId == 0x0400)) || ((_local_24.actionId == 1097))))
                    {
                        gfsfrsmsg = new GameFightShowFighterRandomStaticPoseMessage();
                        gfsfrsmsg.initGameFightShowFighterRandomStaticPoseMessage(_local_24.summon);
                        Kernel.getWorker().getFrame(FightEntitiesFrame).process(gfsfrsmsg);
                        illusionCreature = (DofusEntities.getEntity(_local_24.summon.contextualId) as Sprite);
                        if (illusionCreature)
                        {
                            illusionCreature.visible = false;
                        };
                        this.pushVisibilityStep(_local_24.summon.contextualId, true);
                    }
                    else
                    {
                        _local_96 = new GameFightShowFighterMessage();
                        _local_96.initGameFightShowFighterMessage(_local_24.summon);
                        Kernel.getWorker().getFrame(FightEntitiesFrame).process(_local_96);
                        _local_97 = (DofusEntities.getEntity(_local_24.summon.contextualId) as Sprite);
                        if (_local_97)
                        {
                            _local_97.visible = false;
                        };
                        this.pushSummonStep(_local_24.sourceId, _local_24.summon);
                        if ((((_local_24.sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId)) && (!((_local_24.actionId == 185)))))
                        {
                            isBomb = false;
                            isCreature = false;
                            if (_local_24.actionId == 1008)
                            {
                                isBomb = true;
                            }
                            else
                            {
                                _local_101 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_local_24.summon.contextualId);
                                isBomb = false;
                                _local_102 = (_local_101 as GameFightMonsterInformations);
                                if (_local_102)
                                {
                                    monsterS = Monster.getMonsterById(_local_102.creatureGenericId);
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
                                    _local_104 = (_local_101 as GameFightCharacterInformations);
                                };
                            };
                            if (((isCreature) || (_local_104)))
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
                        _local_98 = this._fightBattleFrame.getNextPlayableCharacterId();
                        if (((((!((this._fightBattleFrame.currentPlayerId == CurrentPlayedFighterManager.getInstance().currentFighterId))) && (!((_local_98 == CurrentPlayedFighterManager.getInstance().currentFighterId))))) && ((_local_98 == _local_24.summon.contextualId))))
                        {
                            this._fightBattleFrame.prepareNextPlayableCharacter();
                        };
                    };
                    return (true);
                case (msg is GameActionFightMarkCellsMessage):
                    _local_25 = (msg as GameActionFightMarkCellsMessage);
                    _local_26 = _local_25.mark.markSpellId;
                    if (((this._castingSpell) && (!((this._castingSpell.spell.id == 1750)))))
                    {
                        this._castingSpell.markId = _local_25.mark.markId;
                        this._castingSpell.markType = _local_25.mark.markType;
                        _local_27 = this._castingSpell.spellRank;
                    }
                    else
                    {
                        _local_105 = Spell.getSpellById(_local_26);
                        _local_27 = _local_105.getSpellLevel(_local_25.mark.markSpellLevel);
                        for each (_local_106 in _local_27.effects)
                        {
                            if ((((((_local_106.effectId == ActionIdConverter.ACTION_FIGHT_ADD_TRAP_CASTING_SPELL)) || ((_local_106.effectId == ActionIdConverter.ACTION_FIGHT_ADD_GLYPH_CASTING_SPELL)))) || ((_local_106.effectId == ActionIdConverter.ACTION_FIGHT_ADD_GLYPH_CASTING_SPELL_ENDTURN))))
                            {
                                _local_26 = (_local_106.parameter0 as uint);
                                _local_27 = Spell.getSpellById(_local_26).getSpellLevel((_local_106.parameter1 as uint));
                                break;
                            };
                        };
                    };
                    this.pushMarkCellsStep(_local_25.mark.markId, _local_25.mark.markType, _local_25.mark.cells, _local_26, _local_27, _local_25.mark.markTeamId, _local_25.mark.markimpactCell);
                    return (true);
                case (msg is GameActionFightUnmarkCellsMessage):
                    _local_28 = (msg as GameActionFightUnmarkCellsMessage);
                    this.pushUnmarkCellsStep(_local_28.markId);
                    return (true);
                case (msg is GameActionFightChangeLookMessage):
                    _local_29 = (msg as GameActionFightChangeLookMessage);
                    this.pushChangeLookStep(_local_29.targetId, _local_29.entityLook);
                    return (true);
                case (msg is GameActionFightInvisibilityMessage):
                    _local_30 = (msg as GameActionFightInvisibilityMessage);
                    _local_31 = this.fightEntitiesFrame.getEntityInfos(_local_30.targetId);
                    FightEntitiesFrame.getCurrentInstance().setLastKnownEntityPosition(_local_30.targetId, _local_31.disposition.cellId);
                    FightEntitiesFrame.getCurrentInstance().setLastKnownEntityMovementPoint(_local_30.targetId, 0, true);
                    this.pushChangeVisibilityStep(_local_30.targetId, _local_30.state);
                    return (true);
                case (msg is GameActionFightLeaveMessage):
                    _local_32 = (msg as GameActionFightLeaveMessage);
                    _local_33 = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
                    for each (gcaiL in _local_33)
                    {
                        if ((gcaiL is GameFightFighterInformations))
                        {
                            summonerIdL = (gcaiL as GameFightFighterInformations).stats.summoner;
                            if (summonerIdL == _local_32.targetId)
                            {
                                this.pushDeathStep(gcaiL.contextualId);
                            };
                        };
                    };
                    this.pushDeathStep(_local_32.targetId, false);
                    _local_34 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_local_32.targetId);
                    if ((_local_34 is GameFightMonsterInformations))
                    {
                        summonedEntityInfosL = (_local_34 as GameFightMonsterInformations);
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
                    _local_35 = (msg as GameActionFightDeathMessage);
                    _local_36 = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
                    for each (gcai in _local_36)
                    {
                        if ((gcai is GameFightFighterInformations))
                        {
                            _local_37 = (gcai as GameFightFighterInformations);
                            if (((_local_37.alive) && ((_local_37.stats.summoner == _local_35.targetId))))
                            {
                                this.pushDeathStep(gcai.contextualId);
                            };
                        };
                    };
                    _local_38 = PlayedCharacterManager.getInstance().id;
                    _local_39 = (this.fightEntitiesFrame.getEntityInfos(_local_35.sourceId) as GameFightFighterInformations);
                    _local_40 = (this.fightEntitiesFrame.getEntityInfos(_local_35.targetId) as GameFightFighterInformations);
                    _local_41 = (this.fightEntitiesFrame.getEntityInfos(_local_38) as GameFightFighterInformations);
                    if (((!((_local_35.targetId == this._fightBattleFrame.currentPlayerId))) && ((((this._fightBattleFrame.slaveId == _local_35.targetId)) || ((this._fightBattleFrame.masterId == _local_35.targetId))))))
                    {
                        this._fightBattleFrame.prepareNextPlayableCharacter(_local_35.targetId);
                    };
                    if (_local_35.targetId == _local_38)
                    {
                        if (_local_35.sourceId == _local_35.targetId)
                        {
                            SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_HIMSELF);
                        }
                        else
                        {
                            if (_local_39.teamId != _local_41.teamId)
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
                        if (_local_35.sourceId == _local_38)
                        {
                            if (_local_40.teamId != _local_41.teamId)
                            {
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILL_ENEMY);
                            }
                            else
                            {
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILL_ALLY);
                            };
                        };
                    };
                    this.pushDeathStep(_local_35.targetId);
                    _local_42 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_local_35.targetId);
                    _local_43 = (Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame);
                    _local_44 = ((((((_local_43) && (_local_43.myTurn))) && (!((_local_35.targetId == _local_38))))) && (TackleUtil.isTackling(_local_41, _local_40, _local_43.lastPath)));
                    if ((_local_42 is GameFightMonsterInformations))
                    {
                        summonedEntityInfos = (_local_42 as GameFightMonsterInformations);
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
                        if ((_local_42 is GameFightFighterInformations))
                        {
                            (_local_42 as GameFightFighterInformations).alive = false;
                            if ((_local_42 as GameFightFighterInformations).stats.summoner != 0)
                            {
                                summonedFighterEntityInfos = (_local_42 as GameFightFighterInformations);
                                if (CurrentPlayedFighterManager.getInstance().checkPlayableEntity(summonedFighterEntityInfos.stats.summoner))
                                {
                                    CurrentPlayedFighterManager.getInstance().removeSummonedCreature(summonedFighterEntityInfos.stats.summoner);
                                    SpellWrapper.refreshAllPlayerSpellHolder(summonedFighterEntityInfos.stats.summoner);
                                };
                            };
                        };
                    };
                    fightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                    if (fightContextFrame)
                    {
                        fightContextFrame.outEntity(_local_35.targetId);
                    };
                    FightEntitiesFrame.getCurrentInstance().updateRemovedEntity(_local_35.targetId);
                    if (_local_44)
                    {
                        _local_43.updatePath();
                    };
                    return (true);
                case (msg is GameActionFightVanishMessage):
                    _local_45 = (msg as GameActionFightVanishMessage);
                    this.pushVanishStep(_local_45.targetId, _local_45.sourceId);
                    _local_46 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_local_45.targetId);
                    if ((_local_46 is GameFightFighterInformations))
                    {
                        (_local_46 as GameFightFighterInformations).alive = false;
                    };
                    fightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                    if (fightContextFrame)
                    {
                        fightContextFrame.outEntity(_local_45.targetId);
                    };
                    FightEntitiesFrame.getCurrentInstance().updateRemovedEntity(_local_45.targetId);
                    return (true);
                case (msg is GameActionFightTriggerEffectMessage):
                    return (true);
                case (msg is GameActionFightDispellEffectMessage):
                    _local_47 = (msg as GameActionFightDispellEffectMessage);
                    this.pushDispellEffectStep(_local_47.targetId, _local_47.boostUID);
                    return (true);
                case (msg is GameActionFightDispellSpellMessage):
                    _local_48 = (msg as GameActionFightDispellSpellMessage);
                    this.pushDispellSpellStep(_local_48.targetId, _local_48.spellId);
                    return (true);
                case (msg is GameActionFightDispellMessage):
                    _local_49 = (msg as GameActionFightDispellMessage);
                    this.pushDispellStep(_local_49.targetId);
                    return (true);
                case (msg is GameActionFightDodgePointLossMessage):
                    _local_50 = (msg as GameActionFightDodgePointLossMessage);
                    this.pushPointsLossDodgeStep(_local_50.targetId, _local_50.actionId, _local_50.amount);
                    return (true);
                case (msg is GameActionFightSpellCooldownVariationMessage):
                    _local_51 = (msg as GameActionFightSpellCooldownVariationMessage);
                    this.pushSpellCooldownVariationStep(_local_51.targetId, _local_51.actionId, _local_51.spellId, _local_51.value);
                    return (true);
                case (msg is GameActionFightSpellImmunityMessage):
                    _local_52 = (msg as GameActionFightSpellImmunityMessage);
                    this.pushSpellImmunityStep(_local_52.targetId);
                    return (true);
                case (msg is GameActionFightInvisibleObstacleMessage):
                    _local_53 = (msg as GameActionFightInvisibleObstacleMessage);
                    this.pushInvisibleObstacleStep(_local_53.sourceId, _local_53.sourceSpellId);
                    return (true);
                case (msg is GameActionFightKillMessage):
                    _local_54 = (msg as GameActionFightKillMessage);
                    this.pushKillStep(_local_54.targetId, _local_54.sourceId);
                    return (true);
                case (msg is GameActionFightReduceDamagesMessage):
                    _local_55 = (msg as GameActionFightReduceDamagesMessage);
                    this.pushReducedDamagesStep(_local_55.targetId, _local_55.amount);
                    return (true);
                case (msg is GameActionFightReflectDamagesMessage):
                    _local_56 = (msg as GameActionFightReflectDamagesMessage);
                    this.pushReflectedDamagesStep(_local_56.sourceId);
                    return (true);
                case (msg is GameActionFightReflectSpellMessage):
                    _local_57 = (msg as GameActionFightReflectSpellMessage);
                    this.pushReflectedSpellStep(_local_57.targetId);
                    return (true);
                case (msg is GameActionFightStealKamaMessage):
                    _local_58 = (msg as GameActionFightStealKamaMessage);
                    this.pushStealKamasStep(_local_58.sourceId, _local_58.targetId, _local_58.amount);
                    return (true);
                case (msg is GameActionFightTackledMessage):
                    _local_59 = (msg as GameActionFightTackledMessage);
                    this.pushTackledStep(_local_59.sourceId);
                    return (true);
                case (msg is GameActionFightTriggerGlyphTrapMessage):
                    if (this._castingSpell)
                    {
                        this._fightBattleFrame.process(new SequenceEndMessage());
                        this._fightBattleFrame.process(new SequenceStartMessage());
                        this._fightBattleFrame.currentSequenceFrame.process(msg);
                        return (true);
                    };
                    _local_60 = (msg as GameActionFightTriggerGlyphTrapMessage);
                    this.pushMarkTriggeredStep(_local_60.triggeringCharacterId, _local_60.sourceId, _local_60.markId);
                    this._fxScriptId = 1;
                    this._castingSpell = new CastingSpell();
                    this._castingSpell.casterId = _local_60.sourceId;
                    _local_61 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_local_60.triggeringCharacterId).disposition.cellId;
                    if (_local_61 != -1)
                    {
                        this._castingSpell.targetedCell = MapPoint.fromCellId(_local_61);
                        this._castingSpell.spell = Spell.getSpellById(1750);
                        this._castingSpell.spellRank = this._castingSpell.spell.getSpellLevel(1);
                    };
                    _local_62 = MarkedCellsManager.getInstance().getMarkDatas(_local_60.markId);
                    if (((_local_62) && ((_local_62.markType == GameActionMarkTypeEnum.PORTAL))))
                    {
                        this._teleportThroughPortal = true;
                        this._teleportPortalId = _local_62.markId;
                    };
                    return (true);
                case (msg is GameActionFightActivateGlyphTrapMessage):
                    _local_63 = (msg as GameActionFightActivateGlyphTrapMessage);
                    this.pushMarkActivateStep(_local_63.markId, _local_63.active);
                    return (true);
                case (msg is GameActionFightDispellableEffectMessage):
                    _local_64 = (msg as GameActionFightDispellableEffectMessage);
                    if (_local_64.actionId == ActionIdConverter.ACTION_CHARACTER_UPDATE_BOOST)
                    {
                        _local_65 = new CastingSpell(false);
                    }
                    else
                    {
                        _local_65 = new CastingSpell((this._castingSpell == null));
                    };
                    if (this._castingSpell)
                    {
                        _local_65.castingSpellId = this._castingSpell.castingSpellId;
                        if (this._castingSpell.castingSpellId == _local_64.effect.spellId)
                        {
                            _local_65.spellRank = this._castingSpell.spellRank;
                        };
                    };
                    _local_65.spell = Spell.getSpellById(_local_64.effect.spellId);
                    _local_65.casterId = _local_64.sourceId;
                    _local_66 = _local_64.effect;
                    _local_67 = BuffManager.makeBuffFromEffect(_local_66, _local_65, _local_64.actionId);
                    if ((_local_67 is StateBuff))
                    {
                        sb = (_local_67 as StateBuff);
                        if (sb.actionId == 952)
                        {
                            step = new FightLeavingStateStep(sb.targetId, sb.stateId);
                        }
                        else
                        {
                            step = new FightEnteringStateStep(sb.targetId, sb.stateId, sb.effects.durationString);
                        };
                        if (_local_65 != null)
                        {
                            step.castingSpellId = _local_65.castingSpellId;
                        };
                        this._stepsBuffer.push(step);
                    };
                    if ((_local_66 is FightTemporaryBoostEffect))
                    {
                        actionId = _local_64.actionId;
                        if (((((((((((!((actionId == ActionIdConverter.ACTION_CHARACTER_MAKE_INVISIBLE))) && (!((actionId == ActionIdConverter.ACTION_CHARACTER_UPDATE_BOOST))))) && (!((actionId == ActionIdConverter.ACTION_CHARACTER_CHANGE_LOOK))))) && (!((actionId == ActionIdConverter.ACTION_CHARACTER_CHANGE_COLOR))))) && (!((actionId == ActionIdConverter.ACTION_CHARACTER_ADD_APPEARANCE))))) && (!((actionId == ActionIdConverter.ACTION_FIGHT_SET_STATE)))))
                        {
                            this.pushTemporaryBoostStep(_local_64.effect.targetId, _local_67.effects.description, _local_67.effects.duration, _local_67.effects.durationString, _local_67.effects);
                        };
                        if (actionId == ActionIdConverter.ACTION_CHARACTER_BOOST_SHIELD)
                        {
                            this.pushShieldPointsVariationStep(_local_64.effect.targetId, (_local_67 as StatBuff).delta, actionId);
                        };
                    };
                    this.pushDisplayBuffStep(_local_67);
                    return (true);
                case (msg is GameActionFightModifyEffectsDurationMessage):
                    _local_68 = (msg as GameActionFightModifyEffectsDurationMessage);
                    this.pushModifyEffectsDurationStep(_local_68.sourceId, _local_68.targetId, _local_68.delta);
                    return (false);
                case (msg is GameActionFightCarryCharacterMessage):
                    _local_69 = (msg as GameActionFightCarryCharacterMessage);
                    if (_local_69.cellId != -1)
                    {
                        this.pushCarryCharacterStep(_local_69.sourceId, _local_69.targetId, _local_69.cellId);
                    };
                    return (false);
                case (msg is GameActionFightThrowCharacterMessage):
                    _local_70 = (msg as GameActionFightThrowCharacterMessage);
                    _local_71 = ((this._castingSpell) ? this._castingSpell.targetedCell.cellId : _local_70.cellId);
                    this.pushThrowCharacterStep(_local_70.sourceId, _local_70.targetId, _local_71);
                    return (false);
                case (msg is GameActionFightDropCharacterMessage):
                    _local_72 = (msg as GameActionFightDropCharacterMessage);
                    _local_73 = _local_72.cellId;
                    if ((((_local_73 == -1)) && (this._castingSpell)))
                    {
                        _local_73 = this._castingSpell.targetedCell.cellId;
                    };
                    this.pushThrowCharacterStep(_local_72.sourceId, _local_72.targetId, _local_73);
                    return (false);
                case (msg is GameActionFightInvisibleDetectedMessage):
                    _local_74 = (msg as GameActionFightInvisibleDetectedMessage);
                    this.pushFightInvisibleTemporarilyDetectedStep(_local_74.sourceId, _local_74.cellId);
                    FightEntitiesFrame.getCurrentInstance().setLastKnownEntityPosition(_local_74.targetId, _local_74.cellId);
                    FightEntitiesFrame.getCurrentInstance().setLastKnownEntityMovementPoint(_local_74.targetId, 0);
                    return (true);
                case (msg is GameFightTurnListMessage):
                    _local_75 = (msg as GameFightTurnListMessage);
                    this.pushTurnListStep(_local_75.ids, _local_75.deadsIds);
                    return (true);
                case (msg is AbstractGameActionMessage):
                    _log.error((("Unsupported game action " + msg) + " ! This action was discarded."));
                    return (true);
            };
            return (false);
        }

        public function execute(callback:Function=null):void
        {
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
                if (((this._castingSpell) && (this._castingSpell.spell)))
                {
                    _log.info((((((("Executing SpellScript" + this._fxScriptId) + " for spell '") + this._castingSpell.spell.name) + "' (") + this._castingSpell.spell.id) + ")"));
                }
                else
                {
                    _log.info((("Executing SpellScript" + this._fxScriptId) + " for unknown spell"));
                };
                this._scriptStarted = getTimer();
                SpellScriptManager.getInstance().runSpellScript(this._fxScriptId, this, new Callback(this.executeBuffer, callback, true, true), new Callback(this.executeBuffer, callback, true, false));
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
                        if (_local_29.target == null)
                        {
                            break;
                        };
                        if (_local_29.value < 0)
                        {
                            _local_29.virtual = true;
                            if (shieldLoseSum[_local_29.target] == null)
                            {
                                shieldLoseSum[_local_29.target] = 0;
                            };
                            shieldLoseSum[_local_29.target] = (shieldLoseSum[_local_29.target] + _local_29.value);
                            shieldLoseLastStep[_local_29.target] = _local_29;
                        };
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

        private function pushMarkCellsStep(markId:int, markType:int, cells:Vector.<GameActionMarkedCell>, markSpellId:int, markSpellLevel:SpellLevel, teamId:int, markImpactCell:int):void
        {
            var step:FightMarkCellsStep = new FightMarkCellsStep(markId, markType, cells, markSpellId, markSpellLevel, teamId, markImpactCell);
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

        private function pushTemporaryBoostStep(fighterId:int, statName:String, duration:int, durationText:String, effect:EffectInstance):void
        {
            var step:FightTemporaryBoostStep = new FightTemporaryBoostStep(fighterId, statName, duration, durationText, effect);
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

        private function pushMarkActivateStep(markId:int, active:Boolean):void
        {
            var step:FightMarkActivateStep = new FightMarkActivateStep(markId, active);
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
                step.portals = this.castingSpell.portalMapPoints;
                step.portalIds = this.castingSpell.portalIds;
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

