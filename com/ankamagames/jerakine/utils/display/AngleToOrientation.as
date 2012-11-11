package com.ankamagames.jerakine.utils.display
{

    public class AngleToOrientation extends Object
    {

        public function AngleToOrientation()
        {
            return;
        }// end function

        public static function angleToOrientation(param1:Number) : uint
        {
            var _loc_2:* = 0;
            switch(true)
            {
                case param1 > -Math.PI / 8 && param1 <= Math.PI / 8:
                {
                    _loc_2 = 0;
                    break;
                }
                case param1 > -Math.PI * (3 / 8) && param1 <= -Math.PI / 8:
                {
                    _loc_2 = 7;
                    break;
                }
                case param1 > -Math.PI * (5 / 8) && param1 <= -Math.PI * (3 / 8):
                {
                    _loc_2 = 6;
                    break;
                }
                case param1 > -Math.PI * (7 / 8) && param1 <= -Math.PI * (5 / 8):
                {
                    _loc_2 = 5;
                    break;
                }
                case param1 > Math.PI * (7 / 8) || param1 <= -Math.PI * (7 / 8):
                {
                    _loc_2 = 4;
                    break;
                }
                case param1 > Math.PI * (5 / 8) && param1 <= Math.PI * (7 / 8):
                {
                    _loc_2 = 3;
                    break;
                }
                case param1 > Math.PI * (3 / 8) && param1 <= Math.PI * (5 / 8):
                {
                    _loc_2 = 2;
                    break;
                }
                case param1 > Math.PI / 8 && param1 <= Math.PI * (3 / 8):
                {
                    _loc_2 = 1;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
