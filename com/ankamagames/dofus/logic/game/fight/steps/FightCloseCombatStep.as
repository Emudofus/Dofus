package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.types.sequences.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightCloseCombatStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _weaponId:uint;
        private var _critical:uint;

        public function FightCloseCombatStep(param1:int, param2:uint, param3:uint)
        {
            this._fighterId = param1;
            this._weaponId = param2;
            this._critical = param3;
            return;
        }// end function

        public function get stepType() : String
        {
            return "closeCombat";
        }// end function

        override public function start() : void
        {
            var _loc_1:GameFightFighterInformations = null;
            var _loc_2:SerialSequencer = null;
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_CLOSE_COMBAT, [this._fighterId, this._weaponId, this._critical], this._fighterId, castingSpellId, true);
            if (this._critical == FightSpellCastCriticalEnum.CRITICAL_HIT)
            {
                _loc_1 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterId) as GameFightFighterInformations;
                if (_loc_1)
                {
                    _loc_2 = new SerialSequencer();
                    _loc_2.addStep(new AddGfxEntityStep(1062, _loc_1.disposition.cellId));
                    _loc_2.start();
                }
            }
            executeCallbacks();
            return;
        }// end function

    }
}
