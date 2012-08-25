package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.sequence.*;
    import flash.display.*;
    import flash.events.*;

    public class FightDeathStep extends AbstractSequencable implements IFightStep
    {
        private var _entityId:int;
        private var _deathSubSequence:ISequencer;
        private var _naturalDeath:Boolean;
        private var _targetName:String;
        private var _needToWarn:Boolean = true;

        public function FightDeathStep(param1:int, param2:Boolean = true)
        {
            this._entityId = param1;
            this._naturalDeath = param2;
            var _loc_3:* = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
            if (_loc_3)
            {
                this._targetName = _loc_3.getFighterName(param1);
            }
            else
            {
                this._targetName = "???";
            }
            return;
        }// end function

        public function get stepType() : String
        {
            return "death";
        }// end function

        public function get entityId() : int
        {
            return this._entityId;
        }// end function

        override public function start() : void
        {
            var _loc_1:* = DofusEntities.getEntity(this._entityId);
            if (!_loc_1)
            {
                _log.warn("Unable to play death of an unexisting fighter " + this._entityId + ".");
                this._needToWarn = false;
                this.deathFinished();
                return;
            }
            var _loc_2:* = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._entityId) as GameFightFighterInformations;
            var _loc_3:* = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
            if (_loc_3)
            {
                _loc_3.deadFightersList.push(this._entityId);
            }
            this._needToWarn = true;
            BuffManager.getInstance().dispell(_loc_1.id, false, false, true);
            var _loc_4:* = BuffManager.getInstance().removeLinkedBuff(_loc_1.id, false, false, true);
            BuffManager.getInstance().reaffectBuffs(_loc_1.id);
            _loc_2.stats.lifePoints = 0;
            if (PlayedCharacterManager.getInstance().infos.id == this._entityId)
            {
                PlayedCharacterManager.getInstance().characteristics.lifePoints = 0;
            }
            this._deathSubSequence = new SerialSequencer(FightBattleFrame.FIGHT_SEQUENCER_NAME);
            if (_loc_1 is TiphonSprite)
            {
                this._deathSubSequence.addStep(new PlayAnimationStep(_loc_1 as TiphonSprite, AnimationEnum.ANIM_MORT));
                this._deathSubSequence.addStep(new CallbackStep(new Callback(this.onAnimEnd, _loc_1)));
            }
            this._deathSubSequence.addStep(new CallbackStep(new Callback(this.manualRollOut, this._entityId)));
            this._deathSubSequence.addStep(new FightDestroyEntityStep(_loc_1));
            this._deathSubSequence.addEventListener(SequencerEvent.SEQUENCE_END, this.deathFinished);
            this._deathSubSequence.start();
            return;
        }// end function

        override public function clear() : void
        {
            if (this._deathSubSequence)
            {
                this._deathSubSequence.clear();
            }
            super.clear();
            return;
        }// end function

        private function manualRollOut(param1:int) : void
        {
            var _loc_2:FightContextFrame = null;
            if (FightContextFrame.fighterEntityTooltipId == param1)
            {
                TooltipManager.hide();
                TooltipManager.hide("fighter");
                _loc_2 = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
                if (_loc_2)
                {
                    _loc_2.outEntity(param1);
                }
            }
            return;
        }// end function

        private function onAnimEnd(param1:TiphonSprite) : void
        {
            var _loc_2:* = param1.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0) as TiphonSprite;
            if (_loc_2)
            {
                param1 = _loc_2;
            }
            var _loc_3:* = param1.getSubEntitySlot(FightCarryCharacterStep.CARRIED_SUBENTITY_CATEGORY, FightCarryCharacterStep.CARRIED_SUBENTITY_INDEX);
            if (_loc_3)
            {
                param1.removeSubEntity(_loc_3);
            }
            return;
        }// end function

        private function deathFinished(event:Event = null) : void
        {
            if (this._deathSubSequence)
            {
                this._deathSubSequence.removeEventListener(SequencerEvent.SEQUENCE_END, this.deathFinished);
                this._deathSubSequence = null;
            }
            if (this._needToWarn)
            {
                if (this._naturalDeath)
                {
                    FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_DEATH, [this._entityId, this._targetName], this._entityId, castingSpellId);
                }
                else
                {
                    FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_LEAVE, [this._entityId, this._targetName], this._entityId, castingSpellId);
                }
            }
            FightSpellCastFrame.updateRangeAndTarget();
            executeCallbacks();
            return;
        }// end function

    }
}
