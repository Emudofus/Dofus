package com.ankamagames.dofus.datacenter.effects.instances
{
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class EffectInstanceDice extends EffectInstanceInteger implements IDataCenter
    {
        public var diceNum:uint;
        public var diceSide:uint;

        public function EffectInstanceDice()
        {
            return;
        }// end function

        override public function clone() : EffectInstance
        {
            var _loc_1:* = new EffectInstanceDice();
            _loc_1.rawZone = rawZone;
            _loc_1.effectId = effectId;
            _loc_1.duration = duration;
            _loc_1.delay = delay;
            _loc_1.diceNum = this.diceNum;
            _loc_1.diceSide = this.diceSide;
            _loc_1.value = value;
            _loc_1.random = random;
            _loc_1.group = group;
            _loc_1.hidden = hidden;
            _loc_1.targetId = targetId;
            return _loc_1;
        }// end function

        override public function get parameter0() : Object
        {
            return this.diceNum != 0 ? (this.diceNum) : (null);
        }// end function

        override public function get parameter1() : Object
        {
            return this.diceSide != 0 ? (this.diceSide) : (null);
        }// end function

        override public function get parameter2() : Object
        {
            return value != 0 ? (value) : (null);
        }// end function

        override public function setParameter(param1:uint, param2) : void
        {
            switch(param1)
            {
                case 0:
                {
                    this.diceNum = uint(param2);
                    break;
                }
                case 1:
                {
                    this.diceSide = uint(param2);
                    break;
                }
                case 2:
                {
                    this.value = int(param2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function add(param1) : EffectInstance
        {
            if (param1 is EffectInstanceDice)
            {
                this.diceNum = this.diceNum + param1.diceNum;
                this.diceSide = this.diceSide + param1.diceSide;
                forceDescriptionRefresh();
            }
            else if (param1 is EffectInstanceInteger)
            {
                this.diceNum = this.diceNum + param1.value;
                this.diceSide = this.diceSide != 0 ? (this.diceSide + param1.value) : (0);
                forceDescriptionRefresh();
            }
            else
            {
                _log.error(param1 + " cannot be added to EffectInstanceDice.");
            }
            return this;
        }// end function

    }
}
