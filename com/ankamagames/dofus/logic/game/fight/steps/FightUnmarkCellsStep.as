package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightUnmarkCellsStep extends AbstractSequencable implements IFightStep
    {
        private var _markId:int;

        public function FightUnmarkCellsStep(param1:int)
        {
            this._markId = param1;
            return;
        }// end function

        public function get stepType() : String
        {
            return "unmarkCells";
        }// end function

        override public function start() : void
        {
            var _loc_1:* = MarkedCellsManager.getInstance().getMarkDatas(this._markId);
            if (!_loc_1)
            {
                _log.error("Trying to remove an unknown mark (" + this._markId + "). Aborting.");
                executeCallbacks();
                return;
            }
            MarkedCellsManager.getInstance().removeGlyph(this._markId);
            var _loc_2:* = FightEventEnum.UNKNOWN_FIGHT_EVENT;
            switch(_loc_1.markType)
            {
                case GameActionMarkTypeEnum.GLYPH:
                {
                    _loc_2 = FightEventEnum.GLYPH_DISAPPEARED;
                    break;
                }
                case GameActionMarkTypeEnum.TRAP:
                {
                    _loc_2 = FightEventEnum.TRAP_DISAPPEARED;
                    break;
                }
                default:
                {
                    _log.warn("Unknown mark type (" + _loc_1.markType + ").");
                    break;
                    break;
                }
            }
            FightEventsHelper.sendFightEvent(_loc_2, [_loc_1.associatedSpell.id], 0, castingSpellId);
            MarkedCellsManager.getInstance().removeMark(this._markId);
            executeCallbacks();
            return;
        }// end function

    }
}
