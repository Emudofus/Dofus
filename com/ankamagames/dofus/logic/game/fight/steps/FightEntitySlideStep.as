package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.positions.*;

    public class FightEntitySlideStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _startCell:MapPoint;
        private var _endCell:MapPoint;

        public function FightEntitySlideStep(param1:int, param2:MapPoint, param3:MapPoint)
        {
            this._fighterId = param1;
            this._startCell = param2;
            this._endCell = param3;
            var _loc_4:* = FightEntitiesFrame.getCurrentInstance().getEntityInfos(param1) as GameFightFighterInformations;
            (FightEntitiesFrame.getCurrentInstance().getEntityInfos(param1) as GameFightFighterInformations).disposition.cellId = param3.cellId;
            return;
        }// end function

        public function get stepType() : String
        {
            return "entitySlide";
        }// end function

        override public function start() : void
        {
            var _loc_2:GameFightFighterInformations = null;
            var _loc_3:MovementPath = null;
            var _loc_1:* = DofusEntities.getEntity(this._fighterId) as IMovable;
            if (_loc_1)
            {
                if (!_loc_1.position.equals(this._startCell))
                {
                    _log.warn("We were ordered to slide " + this._fighterId + " from " + this._startCell.cellId + ", but this fighter is on " + _loc_1.position.cellId + ".");
                }
                if (_loc_1 is AnimatedCharacter)
                {
                    (_loc_1 as AnimatedCharacter).slideOnNextMove = true;
                }
                _loc_2 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterId) as GameFightFighterInformations;
                _loc_2.disposition.cellId = this._endCell.cellId;
                _loc_3 = new MovementPath();
                _loc_3.start = _loc_1.position;
                _loc_3.end = this._endCell;
                _loc_3.addPoint(new PathElement(_loc_1.position, _loc_3.start.orientationTo(_loc_3.end)));
                _loc_3.fill();
                _loc_1.move(_loc_3, this.slideFinished);
            }
            else
            {
                _log.warn("Unable to slide unexisting fighter " + this._fighterId + ".");
                this.slideFinished();
            }
            return;
        }// end function

        private function slideFinished() : void
        {
            FightSpellCastFrame.updateRangeAndTarget();
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SLIDE, [this._fighterId], this._fighterId, castingSpellId);
            executeCallbacks();
            return;
        }// end function

    }
}
