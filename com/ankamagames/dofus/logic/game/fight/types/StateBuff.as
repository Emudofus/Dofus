package com.ankamagames.dofus.logic.game.fight.types
{
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.network.types.game.actions.fight.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class StateBuff extends BasicBuff
    {
        private var _statName:String;
        public var stateId:int;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(StateBuff));

        public function StateBuff(param1:FightTemporaryBoostStateEffect = null, param2:CastingSpell = null, param3:uint = 0)
        {
            if (param1)
            {
                super(param1, param2, param3, param1.stateId, null, null);
                this._statName = ActionIdConverter.getActionStatName(param3);
                this.stateId = param1.stateId;
            }
            return;
        }// end function

        override public function get type() : String
        {
            return "StateBuff";
        }// end function

        public function get statName() : String
        {
            return this._statName;
        }// end function

        override public function onApplyed() : void
        {
            FightersStateManager.getInstance().addStateOnTarget(this.stateId, targetId);
            SpellWrapper.refreshAllPlayerSpellHolder(targetId);
            if (actionId == 952)
            {
                FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_LEAVING_STATE, [targetId, this.stateId], targetId, -1, true);
            }
            else
            {
                FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_ENTERING_STATE, [targetId, this.stateId, effects.durationString], targetId, -1, true);
            }
            super.onApplyed();
            return;
        }// end function

        override public function onRemoved() : void
        {
            if (!_removed)
            {
                FightersStateManager.getInstance().removeStateOnTarget(this.stateId, targetId);
                SpellWrapper.refreshAllPlayerSpellHolder(targetId);
                if (actionId == 952)
                {
                    FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_ENTERING_STATE, [targetId, this.stateId], targetId, -1, true);
                }
                else
                {
                    FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_LEAVING_STATE, [targetId, this.stateId], targetId, -1, true);
                }
            }
            super.onRemoved();
            return;
        }// end function

        override public function clone(param1:int = 0) : BasicBuff
        {
            var _loc_2:* = new StateBuff();
            _loc_2._statName = this._statName;
            _loc_2.stateId = this.stateId;
            _loc_2.id = uid;
            _loc_2.uid = uid;
            _loc_2.actionId = actionId;
            _loc_2.targetId = targetId;
            _loc_2.castingSpell = castingSpell;
            _loc_2.duration = duration;
            _loc_2.dispelable = dispelable;
            _loc_2.source = source;
            _loc_2.aliveSource = aliveSource;
            _loc_2.parentBoostUid = parentBoostUid;
            _loc_2.initParam(param1, param2, param3);
            return _loc_2;
        }// end function

    }
}
