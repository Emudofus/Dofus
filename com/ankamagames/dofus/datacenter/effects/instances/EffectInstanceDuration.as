package com.ankamagames.dofus.datacenter.effects.instances
{
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class EffectInstanceDuration extends EffectInstance implements IDataCenter
    {
        public var days:uint;
        public var hours:uint;
        public var minutes:uint;

        public function EffectInstanceDuration()
        {
            return;
        }// end function

        override public function clone() : EffectInstance
        {
            var _loc_1:* = new EffectInstanceDuration();
            _loc_1.rawZone = rawZone;
            _loc_1.effectId = effectId;
            _loc_1.duration = duration;
            _loc_1.delay = delay;
            _loc_1.days = this.days;
            _loc_1.hours = this.hours;
            _loc_1.minutes = this.minutes;
            _loc_1.random = random;
            _loc_1.group = group;
            _loc_1.targetId = targetId;
            return _loc_1;
        }// end function

        override public function get parameter0() : Object
        {
            return this.days;
        }// end function

        override public function get parameter1() : Object
        {
            return this.hours;
        }// end function

        override public function get parameter2() : Object
        {
            return this.minutes;
        }// end function

        override public function setParameter(param1:uint, param2) : void
        {
            switch(param1)
            {
                case 0:
                {
                    this.days = uint(param2);
                    break;
                }
                case 1:
                {
                    this.hours = uint(param2);
                    break;
                }
                case 2:
                {
                    this.minutes = uint(param2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
