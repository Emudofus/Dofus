package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightSpellImmunityStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;

        public function FightSpellImmunityStep(param1:int)
        {
            this._fighterId = param1;
            return;
        }// end function

        public function get stepType() : String
        {
            return "spellImmunity";
        }// end function

        override public function start() : void
        {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SPELL_IMMUNITY, [this._fighterId], 0, castingSpellId);
            executeCallbacks();
            return;
        }// end function

    }
}
