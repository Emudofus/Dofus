package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightStealingKamasStep extends AbstractSequencable implements IFightStep
    {
        private var _robberId:int;
        private var _victimId:int;
        private var _amount:uint;

        public function FightStealingKamasStep(param1:int, param2:int, param3:uint)
        {
            this._robberId = param1;
            this._victimId = param2;
            this._amount = param3;
            return;
        }// end function

        public function get stepType() : String
        {
            return "stealingKamas";
        }// end function

        override public function start() : void
        {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_STEALING_KAMAS, [this._robberId, this._victimId, this._amount], 0, castingSpellId);
            executeCallbacks();
            return;
        }// end function

    }
}
