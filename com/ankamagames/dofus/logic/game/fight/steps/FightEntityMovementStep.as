package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.positions.*;

    public class FightEntityMovementStep extends AbstractSequencable implements IFightStep
    {
        private var _entityId:int;
        private var _path:MovementPath;

        public function FightEntityMovementStep(param1:int, param2:MovementPath)
        {
            this._entityId = param1;
            this._path = param2;
            return;
        }// end function

        public function get stepType() : String
        {
            return "entityMovement";
        }// end function

        override public function start() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = DofusEntities.getEntity(this._entityId) as IMovable;
            if (_loc_1)
            {
                _loc_2 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._entityId) as GameFightFighterInformations;
                _loc_2.disposition.cellId = this._path.end.cellId;
                _loc_1.move(this._path, this.movementEnd);
            }
            else
            {
                _log.warn("Unable to move unknown entity " + this._entityId + ".");
                this.movementEnd();
            }
            return;
        }// end function

        private function movementEnd() : void
        {
            FightSpellCastFrame.updateRangeAndTarget();
            executeCallbacks();
            return;
        }// end function

    }
}
