package com.ankamagames.jerakine.script.api
{

    public class MathApi extends Object
    {
        public static const PI:Number = 3.14159;

        public function MathApi()
        {
            return;
        }// end function

        public static function Max(param1:Number, param2:Number) : Number
        {
            return Math.max(param1, param2);
        }// end function

        public static function Min(param1:Number, param2:Number) : Number
        {
            return Math.min(param1, param2);
        }// end function

        public static function Abs(param1:Number) : Number
        {
            return Math.abs(param1);
        }// end function

        public static function Ceil(param1:Number) : Number
        {
            return Math.ceil(param1);
        }// end function

        public static function Floor(param1:Number) : Number
        {
            return Math.floor(param1);
        }// end function

        public static function Round(param1:Number) : Number
        {
            return Math.round(param1);
        }// end function

        public static function Cos(param1:Number) : Number
        {
            return Math.cos(param1);
        }// end function

        public static function Sin(param1:Number) : Number
        {
            return Math.sin(param1);
        }// end function

        public static function Acos(param1:Number) : Number
        {
            return Math.acos(param1);
        }// end function

        public static function Asin(param1:Number) : Number
        {
            return Math.asin(param1);
        }// end function

        public static function Tan(param1:Number) : Number
        {
            return Math.tan(param1);
        }// end function

        public static function Atan(param1:Number) : Number
        {
            return Math.atan(param1);
        }// end function

        public static function Atan2(param1:Number, param2:Number) : Number
        {
            return Math.atan2(param1, param2);
        }// end function

        public static function Log(param1:Number) : Number
        {
            return Math.log(param1);
        }// end function

        public static function Pow(param1:Number, param2:Number) : Number
        {
            return Math.pow(param1, param2);
        }// end function

        public static function Sqrt(param1:Number) : Number
        {
            return Math.sqrt(param1);
        }// end function

    }
}
