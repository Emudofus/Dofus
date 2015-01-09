package com.ankamagames.dofus.logic.game.fight.steps.abstract
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;

    public class AbstractDodgePointLossStep extends AbstractSequencable 
    {

        protected var _fighterId:int;
        protected var _amount:int;

        public function AbstractDodgePointLossStep(fighterId:int, amount:int)
        {
            this._fighterId = fighterId;
            this._amount = amount;
        }

    }
}//package com.ankamagames.dofus.logic.game.fight.steps.abstract

