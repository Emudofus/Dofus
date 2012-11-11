package com.ankamagames.dofus.datacenter.effects.instances
{
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class EffectInstanceInteger extends EffectInstance implements IDataCenter
    {
        public var value:int;

        public function EffectInstanceInteger()
        {
            return;
        }// end function

        override public function clone() : EffectInstance
        {
            var _loc_1:* = new EffectInstanceInteger();
            _loc_1.rawZone = rawZone;
            _loc_1.effectId = effectId;
            _loc_1.duration = duration;
            _loc_1.delay = delay;
            _loc_1.value = this.value;
            _loc_1.random = random;
            _loc_1.group = group;
            _loc_1.hidden = hidden;
            _loc_1.targetId = targetId;
            return _loc_1;
        }// end function

        override public function get parameter0() : Object
        {
            return this.value;
        }// end function

        override public function setParameter(param1:uint, param2) : void
        {
            if (param1 == 2)
            {
                this.value = int(param2);
            }
            return;
        }// end function

        override public function add(param1) : EffectInstance
        {
            if (param1 is EffectInstanceDice)
            {
                return param1.add(this);
            }
            if (param1 is EffectInstanceInteger)
            {
                this.value = this.value + param1.value;
                forceDescriptionRefresh();
            }
            else
            {
                _log.error(param1 + " cannot be added to EffectInstanceInteger.");
            }
            return this;
        }// end function

    }
}
