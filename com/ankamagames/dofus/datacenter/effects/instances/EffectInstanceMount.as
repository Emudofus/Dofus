package com.ankamagames.dofus.datacenter.effects.instances
{
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.jerakine.interfaces.IDataCenter;

    public class EffectInstanceMount extends EffectInstance implements IDataCenter 
    {

        public var date:Number;
        public var modelId:uint;
        public var mountId:uint;


        override public function clone():EffectInstance
        {
            var o:EffectInstanceMount = new EffectInstanceMount();
            o.rawZone = rawZone;
            o.effectId = effectId;
            o.duration = duration;
            o.delay = delay;
            o.date = this.date;
            o.modelId = this.modelId;
            o.mountId = this.mountId;
            o.random = random;
            o.group = group;
            o.targetId = targetId;
            o.targetMask = targetMask;
            return (o);
        }

        override public function get parameter0():Object
        {
            return (this.date);
        }

        override public function get parameter1():Object
        {
            return (this.modelId);
        }

        override public function get parameter2():Object
        {
            return (this.mountId);
        }

        override public function setParameter(paramIndex:uint, value:*):void
        {
            switch (paramIndex)
            {
                case 0:
                    this.date = Number(value);
                    return;
                case 1:
                    this.modelId = uint(value);
                    return;
                case 2:
                    this.mountId = uint(value);
                    return;
            };
        }


    }
}//package com.ankamagames.dofus.datacenter.effects.instances

