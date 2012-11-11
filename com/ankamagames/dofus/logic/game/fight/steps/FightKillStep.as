package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightKillStep extends AbstractSequencable implements IFightStep
    {
        private var _killerId:int;
        private var _fighterId:int;

        public function FightKillStep(param1:int, param2:int)
        {
            this._killerId = param2;
            this._fighterId = param1;
            return;
        }// end function

        public function get stepType() : String
        {
            return "kill";
        }// end function

        override public function start() : void
        {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_GOT_KILLED, [this._killerId, this._fighterId], 0, castingSpellId);
            executeCallbacks();
            return;
        }// end function

    }
}
