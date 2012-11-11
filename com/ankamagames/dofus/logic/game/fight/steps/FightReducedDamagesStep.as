package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightReducedDamagesStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _amount:int;

        public function FightReducedDamagesStep(param1:int, param2:int)
        {
            this._fighterId = param1;
            this._amount = param2;
            return;
        }// end function

        public function get stepType() : String
        {
            return "reducedDamages";
        }// end function

        override public function start() : void
        {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_REDUCED_DAMAGES, [this._fighterId, this._amount], this._fighterId, castingSpellId);
            executeCallbacks();
            return;
        }// end function

    }
}
