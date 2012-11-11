package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.steps.abstract.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;

    public class FightShieldPointsVariationStep extends AbstractStatContextualStep implements IFightStep
    {
        private var _intValue:int;
        private var _actionId:int;
        public static const COLOR:uint = 10053324;
        private static const BLOCKING:Boolean = false;

        public function FightShieldPointsVariationStep(param1:int, param2:int, param3:int)
        {
            super(COLOR, param2.toString(), param1, BLOCKING);
            this._intValue = param2;
            this._actionId = param3;
            _virtual = true;
            return;
        }// end function

        public function get stepType() : String
        {
            return "shieldPointsVariation";
        }// end function

        public function get value() : int
        {
            return this._intValue;
        }// end function

        override public function start() : void
        {
            var _loc_2:* = 0;
            var _loc_1:* = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_targetId) as GameFightFighterInformations;
            if (!_loc_1)
            {
                super.executeCallbacks();
                return;
            }
            if (this._intValue < 0)
            {
                FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SHIELD_LOSS, [_targetId, Math.abs(this._intValue), this._actionId], _targetId, castingSpellId);
            }
            else if (this._intValue > 0)
            {
                FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SHIELD_GAIN, [_targetId, Math.abs(this._intValue)], _targetId, castingSpellId);
            }
            else
            {
                FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_NO_CHANGE, [_targetId], _targetId, castingSpellId);
            }
            super.start();
            return;
        }// end function

    }
}
