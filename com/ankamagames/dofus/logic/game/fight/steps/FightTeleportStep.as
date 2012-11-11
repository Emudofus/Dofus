package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.positions.*;

    public class FightTeleportStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _destinationCell:MapPoint;

        public function FightTeleportStep(param1:int, param2:MapPoint)
        {
            this._fighterId = param1;
            this._destinationCell = param2;
            var _loc_3:* = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterId) as GameFightFighterInformations;
            _loc_3.disposition.cellId = param2.cellId;
            return;
        }// end function

        public function get stepType() : String
        {
            return "teleport";
        }// end function

        override public function start() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = DofusEntities.getEntity(this._fighterId) as IMovable;
            if (_loc_1)
            {
                (_loc_1 as IDisplayable).display(PlacementStrataEnums.STRATA_PLAYER);
                _loc_1.jump(this._destinationCell);
            }
            else
            {
                _log.warn("Unable to teleport unknown entity " + this._fighterId + ".");
            }
            if (this._fighterId == PlayedCharacterManager.getInstance().id)
            {
                _loc_2 = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
                if (_loc_2 && _loc_2.myTurn)
                {
                    _loc_2.drawPath();
                }
            }
            FightSpellCastFrame.updateRangeAndTarget();
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_TELEPORTED, [this._fighterId], 0, castingSpellId);
            executeCallbacks();
            return;
        }// end function

    }
}
