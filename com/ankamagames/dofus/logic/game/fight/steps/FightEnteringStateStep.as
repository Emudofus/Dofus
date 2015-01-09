package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.datacenter.spells.SpellState;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
    import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;

    public class FightEnteringStateStep extends AbstractSequencable implements IFightStep 
    {

        private var _fighterId:int;
        private var _stateId:int;
        private var _durationString:String;

        public function FightEnteringStateStep(fighterId:int, stateId:int, durationString:String)
        {
            this._fighterId = fighterId;
            this._stateId = stateId;
            this._durationString = durationString;
        }

        public function get stepType():String
        {
            return ("enteringState");
        }

        override public function start():void
        {
            if (!(SpellState.getSpellStateById(this._stateId).isSilent))
            {
                FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_ENTERING_STATE, [this._fighterId, this._stateId, this._durationString], this._fighterId, -1, false, 2);
            };
            executeCallbacks();
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.steps

