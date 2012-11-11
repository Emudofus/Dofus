package com.ankamagames.dofus.datacenter.effects.instances
{
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class EffectInstanceDate extends EffectInstance implements IDataCenter
    {
        public var year:uint;
        public var month:uint;
        public var day:uint;
        public var hour:uint;
        public var minute:uint;

        public function EffectInstanceDate()
        {
            return;
        }// end function

        override public function clone() : EffectInstance
        {
            var _loc_1:* = new EffectInstanceDate();
            _loc_1.rawZone = rawZone;
            _loc_1.effectId = effectId;
            _loc_1.duration = duration;
            _loc_1.delay = delay;
            _loc_1.year = this.year;
            _loc_1.month = this.month;
            _loc_1.day = this.day;
            _loc_1.hour = this.hour;
            _loc_1.minute = this.minute;
            _loc_1.random = random;
            _loc_1.group = group;
            _loc_1.targetId = targetId;
            return _loc_1;
        }// end function

        override public function get parameter0() : Object
        {
            return String(this.year);
        }// end function

        override public function get parameter1() : Object
        {
            var _loc_1:* = this.month > 9 ? (String(this.month)) : ("0" + String(this.month));
            var _loc_2:* = this.day > 9 ? (String(this.day)) : ("0" + String(this.day));
            return _loc_1 + _loc_2;
        }// end function

        override public function get parameter2() : Object
        {
            var _loc_1:* = this.hour > 9 ? (String(this.hour)) : ("0" + String(this.hour));
            var _loc_2:* = this.minute > 9 ? (String(this.minute)) : ("0" + String(this.minute));
            return _loc_1 + _loc_2;
        }// end function

        override public function get parameter3() : Object
        {
            return this.month;
        }// end function

        override public function get parameter4() : Object
        {
            return this.day;
        }// end function

        override public function setParameter(param1:uint, param2) : void
        {
            switch(param1)
            {
                case 0:
                {
                    this.year = uint(param2);
                    break;
                }
                case 1:
                {
                    this.month = uint(String(param2).substr(0, 2));
                    this.day = uint(String(param2).substr(2, 2));
                    break;
                }
                case 2:
                {
                    this.hour = uint(String(param2).substr(0, 2));
                    this.minute = uint(String(param2).substr(2, 2));
                    break;
                }
                case 3:
                {
                    this.month = uint(param2);
                    break;
                }
                case 4:
                {
                    this.day = uint(param2);
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
