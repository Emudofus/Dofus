package com.ankamagames.dofus.datacenter.effects.instances
{
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class EffectInstanceMount extends EffectInstance implements IDataCenter
    {
        public var date:Number;
        public var modelId:uint;
        public var mountId:uint;

        public function EffectInstanceMount()
        {
            return;
        }// end function

        override public function clone() : EffectInstance
        {
            var _loc_1:* = new EffectInstanceMount();
            _loc_1.rawZone = rawZone;
            _loc_1.effectId = effectId;
            _loc_1.duration = duration;
            _loc_1.delay = delay;
            _loc_1.date = this.date;
            _loc_1.modelId = this.modelId;
            _loc_1.mountId = this.mountId;
            _loc_1.random = random;
            _loc_1.group = group;
            _loc_1.targetId = targetId;
            return _loc_1;
        }// end function

        override public function get parameter0() : Object
        {
            return this.date;
        }// end function

        override public function get parameter1() : Object
        {
            return this.modelId;
        }// end function

        override public function get parameter2() : Object
        {
            return this.mountId;
        }// end function

        override public function setParameter(param1:uint, param2) : void
        {
            switch(param1)
            {
                case 0:
                {
                    this.date = Number(param2);
                    break;
                }
                case 1:
                {
                    this.modelId = uint(param2);
                    break;
                }
                case 2:
                {
                    this.mountId = uint(param2);
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
