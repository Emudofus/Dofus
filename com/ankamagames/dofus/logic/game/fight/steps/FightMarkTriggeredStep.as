package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.types.look.*;

    public class FightMarkTriggeredStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _casterId:int;
        private var _markId:int;

        public function FightMarkTriggeredStep(param1:int, param2:int, param3:int)
        {
            this._fighterId = param1;
            this._casterId = param2;
            this._markId = param3;
            return;
        }// end function

        public function get stepType() : String
        {
            return "markTriggered";
        }// end function

        override public function start() : void
        {
            var _loc_1:* = MarkedCellsManager.getInstance().getMarkDatas(this._markId);
            if (!_loc_1)
            {
                _log.error("Trying to trigger an unknown mark (" + this._markId + "). Aborting.");
                executeCallbacks();
                return;
            }
            var _loc_2:* = FightEventEnum.UNKNOWN_FIGHT_EVENT;
            switch(_loc_1.markType)
            {
                case GameActionMarkTypeEnum.GLYPH:
                {
                    this.addProjectile(1016);
                    _loc_2 = FightEventEnum.FIGHTER_TRIGGERED_GLYPH;
                    break;
                }
                case GameActionMarkTypeEnum.TRAP:
                {
                    this.addProjectile(1017);
                    _loc_2 = FightEventEnum.FIGHTER_TRIGGERED_TRAP;
                    break;
                }
                default:
                {
                    _log.warn("Unknown mark type triggered (" + _loc_1.markType + ").");
                    break;
                }
            }
            FightEventsHelper.sendFightEvent(_loc_2, [this._fighterId, this._casterId, _loc_1.associatedSpell.id], 0, castingSpellId);
            executeCallbacks();
            return;
        }// end function

        private function addProjectile(param1:int) : void
        {
            var _loc_2:* = EntitiesManager.getInstance().getFreeEntityId();
            var _loc_3:* = new Projectile(_loc_2, TiphonEntityLook.fromString("{" + param1 + "}"), true);
            _loc_3.init();
            if (MarkedCellsManager.getInstance().getGlyph(this._markId) == null)
            {
                return;
            }
            _loc_3.position = MarkedCellsManager.getInstance().getGlyph(this._markId).position;
            _loc_3.display(PlacementStrataEnums.STRATA_AREA);
            _loc_3.addEventListener(TiphonEvent.ANIMATION_END, this.removeProjectile);
            return;
        }// end function

        private function removeProjectile(event:TiphonEvent) : void
        {
            (event.target as Projectile).remove();
            return;
        }// end function

    }
}
