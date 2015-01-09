package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
    import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;

    public class FightReflectedDamagesStep extends AbstractSequencable implements IFightStep 
    {

        private var _fighterId:int;

        public function FightReflectedDamagesStep(fighterId:int)
        {
            this._fighterId = fighterId;
        }

        public function get stepType():String
        {
            return ("reflectedDamages");
        }

        override public function start():void
        {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_REFLECTED_DAMAGES, [this._fighterId], this._fighterId, castingSpellId);
            executeCallbacks();
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.steps

