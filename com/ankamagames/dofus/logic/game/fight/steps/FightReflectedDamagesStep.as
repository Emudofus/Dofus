package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightReflectedDamagesStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _amount:int;

        public function FightReflectedDamagesStep(param1:int, param2:int)
        {
            this._fighterId = param1;
            this._amount = param2;
            return;
        }// end function

        public function get stepType() : String
        {
            return "reflectedDamages";
        }// end function

        override public function start() : void
        {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_REFLECTED_DAMAGES, [this._fighterId, this._amount], this._fighterId, castingSpellId);
            executeCallbacks();
            return;
        }// end function

    }
}
