package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.positions.*;

    public class FightExchangePositionsStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterOne:int;
        private var _fighterOneNewCell:int;
        private var _fighterTwo:int;
        private var _fighterTwoNewCell:int;
        private var _fighterOneVisibility:int;

        public function FightExchangePositionsStep(param1:int, param2:int, param3:int, param4:int)
        {
            this._fighterOne = param1;
            this._fighterOneNewCell = param2;
            this._fighterTwo = param3;
            this._fighterTwoNewCell = param4;
            var _loc_5:* = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterOne) as GameFightFighterInformations;
            this._fighterOneVisibility = _loc_5.stats.invisibilityState;
            _loc_5.disposition.cellId = this._fighterOneNewCell;
            _loc_5 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterTwo) as GameFightFighterInformations;
            _loc_5.disposition.cellId = this._fighterTwoNewCell;
            return;
        }// end function

        public function get stepType() : String
        {
            return "exchangePositions";
        }// end function

        override public function start() : void
        {
            if (this._fighterOneVisibility != GameActionFightInvisibilityStateEnum.INVISIBLE)
            {
                if (!this.doJump(this._fighterOne, this._fighterOneNewCell))
                {
                    _log.warn("Unable to move unexisting fighter " + this._fighterOne + " (1) to " + this._fighterOneNewCell + " during a positions exchange.");
                }
            }
            if (!this.doJump(this._fighterTwo, this._fighterTwoNewCell))
            {
                _log.warn("Unable to move unexisting fighter " + this._fighterTwo + " (2) to " + this._fighterTwoNewCell + " during a positions exchange.");
            }
            var _loc_1:* = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterOne) as GameFightFighterInformations;
            var _loc_2:* = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterTwo) as GameFightFighterInformations;
            _loc_1.disposition.cellId = this._fighterOneNewCell;
            _loc_2.disposition.cellId = this._fighterTwoNewCell;
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTERS_POSITION_EXCHANGE, [this._fighterOne, this._fighterTwo], 0, castingSpellId);
            FightSpellCastFrame.updateRangeAndTarget();
            executeCallbacks();
            return;
        }// end function

        private function doJump(param1:int, param2:int) : Boolean
        {
            var _loc_3:IMovable = null;
            if (param2 > -1)
            {
                _loc_3 = DofusEntities.getEntity(param1) as IMovable;
                if (_loc_3)
                {
                    _loc_3.jump(MapPoint.fromCellId(param2));
                }
                else
                {
                    return false;
                }
            }
            return true;
        }// end function

    }
}
