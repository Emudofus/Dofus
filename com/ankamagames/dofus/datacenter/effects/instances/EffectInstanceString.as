package com.ankamagames.dofus.datacenter.effects.instances
{
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class EffectInstanceString extends EffectInstance implements IDataCenter
    {
        public var text:String;

        public function EffectInstanceString()
        {
            return;
        }// end function

        override public function clone() : EffectInstance
        {
            var _loc_1:* = new EffectInstanceString();
            _loc_1.rawZone = rawZone;
            _loc_1.effectId = effectId;
            _loc_1.duration = duration;
            _loc_1.delay = delay;
            _loc_1.text = this.text;
            _loc_1.random = random;
            _loc_1.group = group;
            _loc_1.targetId = targetId;
            return _loc_1;
        }// end function

        override public function get parameter3() : Object
        {
            return this.text;
        }// end function

        override public function setParameter(param1:uint, param2) : void
        {
            if (param1 == 3)
            {
                this.text = String(param2);
            }
            return;
        }// end function

    }
}
