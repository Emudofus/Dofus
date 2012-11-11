package com.ankamagames.dofus.datacenter.effects.instances
{
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class EffectInstanceCreature extends EffectInstance implements IDataCenter
    {
        public var monsterFamilyId:uint;

        public function EffectInstanceCreature()
        {
            return;
        }// end function

        override public function clone() : EffectInstance
        {
            var _loc_1:* = new EffectInstanceCreature();
            _loc_1.rawZone = rawZone;
            _loc_1.effectId = effectId;
            _loc_1.duration = duration;
            _loc_1.delay = delay;
            _loc_1.monsterFamilyId = this.monsterFamilyId;
            _loc_1.random = random;
            _loc_1.group = group;
            _loc_1.targetId = targetId;
            return _loc_1;
        }// end function

        override public function get parameter0() : Object
        {
            return this.monsterFamilyId;
        }// end function

        override public function setParameter(param1:uint, param2) : void
        {
            if (param1 == 0)
            {
                this.monsterFamilyId = uint(param2);
            }
            return;
        }// end function

    }
}
