package org.flintparticles.common.energyEasing
{

    public class Quadratic extends Object
    {

        public function Quadratic()
        {
            return;
        }// end function

        public static function easeIn(param1:Number, param2:Number) : Number
        {
            var _loc_3:* = param1 / param2;
            param1 = param1 / param2;
            return 1 - _loc_3 * param1;
        }// end function

        public static function easeOut(param1:Number, param2:Number) : Number
        {
            var _loc_3:* = 1 - param1 / param2;
            param1 = 1 - param1 / param2;
            return _loc_3 * param1;
        }// end function

        public static function easeInOut(param1:Number, param2:Number) : Number
        {
            var _loc_3:* = param1 / (param2 * 0.5);
            param1 = param1 / (param2 * 0.5);
            if (_loc_3 < 1)
            {
                return 1 - param1 * param1 * 0.5;
            }
            var _loc_3:* = param1 - 2;
            param1 = param1 - 2;
            return _loc_3 * param1 * 0.5;
        }// end function

    }
}
