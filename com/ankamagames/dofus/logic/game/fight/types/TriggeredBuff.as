package com.ankamagames.dofus.logic.game.fight.types
{
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.network.types.game.actions.fight.*;

    public class TriggeredBuff extends BasicBuff
    {
        public var delay:int;

        public function TriggeredBuff(param1:FightTriggeredEffect = null, param2:CastingSpell = null, param3:uint = 0)
        {
            if (param1)
            {
                super(param1, param2, param3, param1.param1, param1.param2, param1.param3);
                this.delay = param1.delay;
                _effect.delay = this.delay;
            }
            return;
        }// end function

        override public function initParam(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            super.initParam(param1, param2, param3);
            if (Effect.getEffectById(actionId).forceMinMax)
            {
                _loc_4 = param3 + param1;
                _loc_5 = param1 * param2 + param3;
                if (_loc_4 == _loc_5)
                {
                    param1 = _loc_4;
                    var _loc_6:* = 0;
                    param3 = 0;
                    param2 = _loc_6;
                }
                else if (_loc_4 > _loc_5)
                {
                    param1 = _loc_5;
                    param2 = _loc_4;
                    param3 = 0;
                }
                else
                {
                    param1 = _loc_4;
                    param2 = _loc_5;
                    param3 = 0;
                }
            }
            return;
        }// end function

        override public function clone(param1:int = 0) : BasicBuff
        {
            var _loc_2:* = new TriggeredBuff();
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
            _loc_2.delay = this.delay;
            _loc_2._effect.delay = this.delay;
            return _loc_2;
        }// end function

        override public function get active() : Boolean
        {
            return this.delay > 0 || super.active;
        }// end function

        override public function get trigger() : Boolean
        {
            return true;
        }// end function

        override public function incrementDuration(param1:int, param2:Boolean = false) : Boolean
        {
            if (this.delay > 0 && !param2)
            {
                if (this.delay + param1 >= 0)
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this.delay - 1;
                    _loc_3.delay = _loc_4;
                    var _loc_3:* = effects;
                    var _loc_4:* = effects.delay - 1;
                    _loc_3.delay = _loc_4;
                }
                else
                {
                    param1 = param1 + this.delay;
                    this.delay = 0;
                    effects.delay = 0;
                }
            }
            if (param1 != 0)
            {
                return super.incrementDuration(param1, param2);
            }
            return true;
        }// end function

        override public function get unusableNextTurn() : Boolean
        {
            return this.delay <= 1 && super.unusableNextTurn;
        }// end function

    }
}
