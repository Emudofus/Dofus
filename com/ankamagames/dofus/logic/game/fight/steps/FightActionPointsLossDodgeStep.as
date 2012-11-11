package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.steps.abstract.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;

    public class FightActionPointsLossDodgeStep extends AbstractDodgePointLossStep implements IFightStep
    {

        public function FightActionPointsLossDodgeStep(param1:int, param2:int)
        {
            super(param1, param2);
            return;
        }// end function

        public function get stepType() : String
        {
            return "actionPointsLossDodge";
        }// end function

        override public function start() : void
        {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_AP_LOSS_DODGED, [_fighterId, _amount], _fighterId, castingSpellId);
            executeCallbacks();
            return;
        }// end function

    }
}
