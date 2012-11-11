package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.steps.abstract.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;

    public class FightLifeVariationStep extends AbstractStatContextualStep implements IFightStep
    {
        private var _delta:int;
        private var _permanentDamages:int;
        private var _actionId:int;
        public var skipTextEvent:Boolean = false;
        public static const COLOR:uint = 16711680;
        private static const BLOCKING:Boolean = false;

        public function FightLifeVariationStep(param1:int, param2:int, param3:int, param4:int)
        {
            super(COLOR, param2.toString(), param1, BLOCKING);
            _virtual = true;
            this._delta = param2;
            this._permanentDamages = param3;
            this._actionId = param4;
            return;
        }// end function

        public function get stepType() : String
        {
            return "lifeVariation";
        }// end function

        public function get value() : int
        {
            return this._delta;
        }// end function

        public function get delta() : int
        {
            return this._delta;
        }// end function

        public function get permanentDamages() : int
        {
            return this._permanentDamages;
        }// end function

        public function get actionId() : int
        {
            return this._actionId;
        }// end function

        override public function start() : void
        {
            var _loc_1:* = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_targetId) as GameFightFighterInformations;
            if (!_loc_1)
            {
                super.executeCallbacks();
                return;
            }
            var _loc_2:* = _loc_1.stats.lifePoints + this._delta;
            _loc_1.stats.lifePoints = Math.max(0, _loc_2);
            _loc_1.stats.maxLifePoints = Math.max(1, _loc_1.stats.maxLifePoints + this._permanentDamages);
            if (_loc_1.stats.lifePoints > _loc_1.stats.maxLifePoints)
            {
                _loc_1.stats.lifePoints = _loc_1.stats.maxLifePoints;
            }
            if (_loc_1 is GameFightCharacterInformations)
            {
                TooltipManager.updateContent("PlayerShortInfos", "tooltipOverEntity_" + _loc_1.contextualId, _loc_1);
            }
            else
            {
                TooltipManager.updateContent("EntityShortInfos", "tooltipOverEntity_" + _loc_1.contextualId, _loc_1);
            }
            if (PlayedCharacterManager.getInstance().infos.id == _targetId)
            {
                PlayedCharacterManager.getInstance().characteristics.lifePoints = _loc_1.stats.lifePoints;
                PlayedCharacterManager.getInstance().characteristics.maxLifePoints = _loc_1.stats.maxLifePoints;
            }
            if (this._delta < 0 || this._delta == 0 && !this.skipTextEvent)
            {
                FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_LIFE_LOSS, [_targetId, Math.abs(this._delta), this._actionId], _targetId, castingSpellId, false, 2);
            }
            else if (this._delta > 0)
            {
                FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_LIFE_GAIN, [_targetId, Math.abs(this._delta), this._actionId], _targetId, castingSpellId, false, 2);
            }
            super.start();
            return;
        }// end function

    }
}
