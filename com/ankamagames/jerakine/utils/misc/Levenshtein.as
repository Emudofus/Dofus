package com.ankamagames.jerakine.utils.misc
{

    public class Levenshtein extends Object
    {

        public function Levenshtein()
        {
            return;
        }// end function

        public static function distance(param1:String, param2:String) : Number
        {
            var _loc_3:uint = 0;
            var _loc_4:uint = 0;
            var _loc_5:Number = NaN;
            var _loc_6:* = new Array();
            if (param1.length == 0)
            {
                return param2.length;
            }
            if (param2.length == 0)
            {
                return param1.length;
            }
            _loc_3 = 0;
            while (_loc_3 <= param1.length)
            {
                
                _loc_6[_loc_3] = new Array();
                _loc_6[_loc_3][0] = _loc_3;
                _loc_3 = _loc_3 + 1;
            }
            _loc_4 = 0;
            while (_loc_4 <= param2.length)
            {
                
                _loc_6[0][_loc_4] = _loc_4;
                _loc_4 = _loc_4 + 1;
            }
            _loc_3 = 1;
            while (_loc_3 <= param1.length)
            {
                
                _loc_4 = 1;
                while (_loc_4 <= param2.length)
                {
                    
                    if (param1.charAt((_loc_3 - 1)) == param2.charAt((_loc_4 - 1)))
                    {
                        _loc_5 = 0;
                    }
                    else
                    {
                        _loc_5 = 1;
                    }
                    _loc_6[_loc_3][_loc_4] = Math.min((_loc_6[(_loc_3 - 1)][_loc_4] + 1), (_loc_6[_loc_3][(_loc_4 - 1)] + 1), _loc_6[(_loc_3 - 1)][(_loc_4 - 1)] + _loc_5);
                    _loc_4 = _loc_4 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_6[param1.length][param2.length];
        }// end function

        public static function suggest(param1:String, param2:Array, param3:uint = 5) : String
        {
            var _loc_4:String = null;
            var _loc_6:uint = 0;
            var _loc_5:uint = 100000;
            var _loc_7:uint = 0;
            while (_loc_7 < param2.length)
            {
                
                _loc_6 = distance(param1, param2[_loc_7]);
                if (_loc_5 > _loc_6 && _loc_6 <= param3)
                {
                    _loc_5 = _loc_6;
                    _loc_4 = param2[_loc_7];
                }
                _loc_7 = _loc_7 + 1;
            }
            return _loc_4;
        }// end function

    }
}
