package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
    import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;

    public class FightKillStep extends AbstractSequencable implements IFightStep 
    {

        private var _killerId:int;
        private var _fighterId:int;

        public function FightKillStep(fighterId:int, killerId:int)
        {
            this._killerId = killerId;
            this._fighterId = fighterId;
        }

        public function get stepType():String
        {
            return ("kill");
        }

        override public function start():void
        {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_GOT_KILLED, [this._killerId, this._fighterId], this._fighterId, castingSpellId);
            executeCallbacks();
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.steps

