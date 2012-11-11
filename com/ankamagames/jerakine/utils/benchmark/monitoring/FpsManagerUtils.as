package com.ankamagames.jerakine.utils.benchmark.monitoring
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.ui.*;
    import flash.system.*;
    import flash.utils.*;

    public class FpsManagerUtils extends Object
    {

        public function FpsManagerUtils()
        {
            return;
        }// end function

        public static function countKeys(param1:Dictionary) : int
        {
            var _loc_3:* = undefined;
            var _loc_2:* = 0;
            for (_loc_3 in param1)
            {
                
                _loc_2++;
            }
            return _loc_2;
        }// end function

        public static function calculateMB(param1:uint) : Number
        {
            var _loc_2:* = Math.round(param1 / 1024 / 1024 * 100);
            return _loc_2 / 100;
        }// end function

        public static function getTimeFromNow(param1:int) : String
        {
            var _loc_2:* = getTimer() - param1;
            var _loc_3:* = _loc_2 / 1000;
            var _loc_4:* = _loc_3 / 60;
            _loc_3 = _loc_3 - _loc_4 * 60;
            return (_loc_4 > 0 ? (_loc_4.toString() + " min ") : ("")) + _loc_3.toString() + " sec";
        }// end function

        public static function isSpecialGraph(param1:String) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in FpsManagerConst.SPECIAL_GRAPH)
            {
                
                if (_loc_2.name == param1)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public static function numberOfSpecialGraphDisplayed(param1:Dictionary) : int
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            for each (_loc_3 in param1)
            {
                
                if (FpsManagerUtils.isSpecialGraph(_loc_3.indice))
                {
                    _loc_2++;
                }
            }
            return _loc_2;
        }// end function

        public static function getVectorMaxValue(param1:Vector.<Number>) : Number
        {
            var _loc_3:* = NaN;
            var _loc_2:* = 0;
            for each (_loc_3 in param1)
            {
                
                if (_loc_3 > _loc_2)
                {
                    _loc_2 = _loc_3;
                }
            }
            return _loc_2;
        }// end function

        public static function getVersion() : Number
        {
            var _loc_1:* = Capabilities.version;
            var _loc_2:* = _loc_1.split(" ");
            var _loc_3:* = _loc_2[1].split(",");
            var _loc_4:* = _loc_3[0];
            return _loc_3[0];
        }// end function

        public static function getBrightRandomColor() : uint
        {
            var _loc_1:* = getRandomColor();
            while (_loc_1 < 8000000)
            {
                
                _loc_1 = getRandomColor();
            }
            return _loc_1;
        }// end function

        public static function getRandomColor() : uint
        {
            return Math.random() * 16777215;
        }// end function

        public static function addAlphaToColor(param1:uint, param2:uint) : uint
        {
            return (param2 << 24) + param1;
        }// end function

    }
}
