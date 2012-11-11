package com.ankamagames.dofus.datacenter.effects.instances
{
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class EffectInstanceMinMax extends EffectInstance implements IDataCenter
    {
        public var min:uint;
        public var max:uint;

        public function EffectInstanceMinMax()
        {
            return;
        }// end function

        override public function clone() : EffectInstance
        {
            var _loc_1:* = new EffectInstanceMinMax();
            _loc_1.rawZone = rawZone;
            _loc_1.effectId = effectId;
            _loc_1.duration = duration;
            _loc_1.delay = delay;
            _loc_1.min = this.min;
            _loc_1.max = this.max;
            _loc_1.random = random;
            _loc_1.group = group;
            _loc_1.targetId = targetId;
            return _loc_1;
        }// end function

        override public function get parameter0() : Object
        {
            return this.min;
        }// end function

        override public function get parameter1() : Object
        {
            return this.min != this.max ? (this.max) : (null);
        }// end function

        override public function setParameter(param1:uint, param2) : void
        {
            switch(param1)
            {
                case 0:
                {
                    this.min = uint(param2);
                    break;
                }
                case 1:
                {
                    this.max = uint(param2);
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
