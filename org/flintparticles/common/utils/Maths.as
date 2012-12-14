package org.flintparticles.common.utils
{

    public class Maths extends Object
    {
        private static const RADTODEG:Number = 57.2958;
        private static const DEGTORAD:Number = 0.0174533;

        public function Maths()
        {
            return;
        }// end function

        public static function asDegrees(param1:Number) : Number
        {
            return param1 * RADTODEG;
        }// end function

        public static function asRadians(param1:Number) : Number
        {
            return param1 * DEGTORAD;
        }// end function

    }
}
