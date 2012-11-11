package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightReflectedSpellStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;

        public function FightReflectedSpellStep(param1:int)
        {
            this._fighterId = param1;
            return;
        }// end function

        public function get stepType() : String
        {
            return "reflectedSpell";
        }// end function

        override public function start() : void
        {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_REFLECTED_SPELL, [this._fighterId], this._fighterId, castingSpellId);
            executeCallbacks();
            return;
        }// end function

    }
}
