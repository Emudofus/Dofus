package com.ankamagames.jerakine.types
{
    import flash.utils.*;

    public class ColorMultiplicator extends Object
    {
        public var red:Number;
        public var green:Number;
        public var blue:Number;
        private var _isOne:Boolean;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);

        public function ColorMultiplicator(param1:int, param2:int, param3:int, param4:Boolean = false)
        {
            MEMORY_LOG[this] = 1;
            this.red = param1;
            this.green = param2;
            this.blue = param3;
            if (!param4 && param1 + param2 + param3 == 0)
            {
                this._isOne = true;
            }
            return;
        }// end function

        public function isOne() : Boolean
        {
            return this._isOne;
        }// end function

        public function multiply(param1:ColorMultiplicator) : ColorMultiplicator
        {
            if (this._isOne)
            {
                return param1;
            }
            if (param1.isOne())
            {
                return this;
            }
            var _loc_2:* = new ColorMultiplicator(0, 0, 0);
            _loc_2.red = this.red + param1.red;
            _loc_2.green = this.green + param1.green;
            _loc_2.blue = this.blue + param1.blue;
            _loc_2.red = clamp(_loc_2.red, -128, 127);
            _loc_2.green = clamp(_loc_2.green, -128, 127);
            _loc_2.blue = clamp(_loc_2.blue, -128, 127);
            _loc_2._isOne = false;
            return _loc_2;
        }// end function

        public function toString() : String
        {
            return "[r: " + this.red + ", g: " + this.green + ", b: " + this.blue + "]";
        }// end function

        public static function clamp(param1:Number, param2:Number, param3:Number) : Number
        {
            if (param1 > param3)
            {
                return param3;
            }
            if (param1 < param2)
            {
                return param2;
            }
            return param1;
        }// end function

    }
}
