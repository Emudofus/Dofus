package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightInvisibleObstacleStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _spellLevelId:int;

        public function FightInvisibleObstacleStep(param1:int, param2:int)
        {
            this._fighterId = param1;
            this._spellLevelId = param2;
            return;
        }// end function

        public function get stepType() : String
        {
            return "invisibleObstacle";
        }// end function

        override public function start() : void
        {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_INVISIBLE_OBSTACLE, [this._fighterId, this._spellLevelId], this._fighterId, castingSpellId);
            executeCallbacks();
            return;
        }// end function

    }
}
