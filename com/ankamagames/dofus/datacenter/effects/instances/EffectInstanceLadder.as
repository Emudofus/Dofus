package com.ankamagames.dofus.datacenter.effects.instances
{
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class EffectInstanceLadder extends EffectInstanceCreature implements IDataCenter
    {
        public var monsterCount:uint;

        public function EffectInstanceLadder()
        {
            return;
        }// end function

        override public function clone() : EffectInstance
        {
            var _loc_1:* = new EffectInstanceLadder();
            _loc_1.rawZone = rawZone;
            _loc_1.effectId = effectId;
            _loc_1.duration = duration;
            _loc_1.delay = delay;
            _loc_1.monsterFamilyId = monsterFamilyId;
            _loc_1.monsterCount = this.monsterCount;
            _loc_1.random = random;
            _loc_1.group = group;
            _loc_1.targetId = targetId;
            return _loc_1;
        }// end function

        override public function get parameter0() : Object
        {
            return monsterFamilyId;
        }// end function

        override public function get parameter2() : Object
        {
            return this.monsterCount;
        }// end function

        override public function setParameter(param1:uint, param2) : void
        {
            switch(param1)
            {
                case 0:
                {
                    monsterFamilyId = uint(param2);
                    break;
                }
                case 2:
                {
                    this.monsterCount = uint(param2);
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
