package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightDispellStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;

        public function FightDispellStep(param1:int)
        {
            this._fighterId = param1;
            return;
        }// end function

        public function get stepType() : String
        {
            return "dispell";
        }// end function

        override public function start() : void
        {
            BuffManager.getInstance().dispell(this._fighterId);
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_GOT_DISPELLED, [this._fighterId], this._fighterId, castingSpellId);
            executeCallbacks();
            return;
        }// end function

    }
}
