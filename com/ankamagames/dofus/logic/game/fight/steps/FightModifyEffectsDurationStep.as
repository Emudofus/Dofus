package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightModifyEffectsDurationStep extends AbstractSequencable implements IFightStep, ISequencableListener
    {
        private var _sourceId:int;
        private var _targetId:int;
        private var _delta:int;
        private var _virtualStep:IFightStep;

        public function FightModifyEffectsDurationStep(param1:int, param2:int, param3:int)
        {
            this._sourceId = param1;
            this._targetId = param2;
            this._delta = param3;
            return;
        }// end function

        public function get stepType() : String
        {
            return "modifyEffectsDuration";
        }// end function

        override public function start() : void
        {
            BuffManager.getInstance().incrementDuration(this._targetId, this._delta, true, BuffManager.INCREMENT_MODE_TARGET);
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_EFFECTS_MODIFY_DURATION, [this._sourceId, this._targetId, this._delta], this._targetId, castingSpellId);
            if (!this._virtualStep)
            {
                executeCallbacks();
            }
            else
            {
                this._virtualStep.addListener(this);
                this._virtualStep.start();
            }
            return;
        }// end function

        public function stepFinished() : void
        {
            this._virtualStep.removeListener(this);
            executeCallbacks();
            return;
        }// end function

    }
}
