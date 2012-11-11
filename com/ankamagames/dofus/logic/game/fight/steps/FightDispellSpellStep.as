package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightDispellSpellStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _spellId:int;

        public function FightDispellSpellStep(param1:int, param2:int)
        {
            this._fighterId = param1;
            this._spellId = param2;
            return;
        }// end function

        public function get stepType() : String
        {
            return "dispellSpell";
        }// end function

        override public function start() : void
        {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SPELL_DISPELLED, [this._fighterId, this._spellId], 0, castingSpellId);
            BuffManager.getInstance().dispellSpell(this._fighterId, this._spellId, true);
            executeCallbacks();
            return;
        }// end function

    }
}
