package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.steps.abstract.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.managers.*;

    public class FightMovementPointsVariationStep extends AbstractStatContextualStep implements IFightStep
    {
        private var _intValue:int;
        private var _voluntarlyUsed:Boolean;
        private var _updateCharacteristicManager:Boolean;
        private var _showChatmessage:Boolean;
        public static const COLOR:uint = 26112;
        private static const BLOCKING:Boolean = false;

        public function FightMovementPointsVariationStep(param1:int, param2:int, param3:Boolean, param4:Boolean = true, param5:Boolean = true)
        {
            super(COLOR, param2 > 0 ? ("+" + param2) : (param2.toString()), param1, BLOCKING);
            this._showChatmessage = param5;
            this._intValue = param2;
            this._voluntarlyUsed = param3;
            _virtual = this._voluntarlyUsed && !OptionManager.getOptionManager("dofus").showUsedPaPm;
            this._updateCharacteristicManager = param4;
            return;
        }// end function

        public function get stepType() : String
        {
            return "movementPointsVariation";
        }// end function

        public function get value() : int
        {
            return this._intValue;
        }// end function

        override public function start() : void
        {
            var _loc_1:GameFightFighterInformations = null;
            var _loc_2:int = 0;
            if (this._updateCharacteristicManager)
            {
                _loc_1 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_targetId) as GameFightFighterInformations;
                _loc_2 = _loc_1.stats.movementPoints;
                _loc_1.stats.movementPoints = _loc_1.stats.movementPoints + this._intValue;
                if (CurrentPlayedFighterManager.getInstance().currentFighterId == _targetId)
                {
                    CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().movementPointsCurrent = _loc_1.stats.movementPoints;
                }
                if (_loc_1.disposition.cellId == -1)
                {
                    super.executeCallbacks();
                    return;
                }
            }
            if (this._showChatmessage)
            {
                if (this._intValue > 0)
                {
                    FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_MP_GAINED, [_targetId, Math.abs(this._intValue)], _targetId, castingSpellId);
                }
                else if (this._intValue < 0)
                {
                    if (this._voluntarlyUsed)
                    {
                        FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_MP_USED, [_targetId, Math.abs(this._intValue)], _targetId, castingSpellId);
                    }
                    else
                    {
                        FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_MP_LOST, [_targetId, Math.abs(this._intValue)], _targetId, castingSpellId);
                    }
                }
            }
            super.start();
            return;
        }// end function

    }
}
