package com.ankamagames.dofus.logic.game.fight.steps.abstract
{
    import com.ankamagames.jerakine.sequencer.*;

    public class AbstractDodgePointLossStep extends AbstractSequencable
    {
        protected var _fighterId:int;
        protected var _amount:int;

        public function AbstractDodgePointLossStep(param1:int, param2:int)
        {
            this._fighterId = param1;
            this._amount = param2;
            return;
        }// end function

    }
}
