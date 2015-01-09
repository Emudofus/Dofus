package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
    import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;

    public class FightSpellImmunityStep extends AbstractSequencable implements IFightStep 
    {

        private var _fighterId:int;

        public function FightSpellImmunityStep(fighterId:int)
        {
            this._fighterId = fighterId;
        }

        public function get stepType():String
        {
            return ("spellImmunity");
        }

        override public function start():void
        {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SPELL_IMMUNITY, [this._fighterId], 0, castingSpellId);
            executeCallbacks();
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.steps

