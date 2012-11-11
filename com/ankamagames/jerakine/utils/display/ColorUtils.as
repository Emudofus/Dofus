package com.ankamagames.jerakine.utils.display
{

    public class ColorUtils extends Object
    {

        public function ColorUtils()
        {
            return;
        }// end function

        public static function rgb2hsl(param1:uint) : Object
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            _loc_2 = (param1 & 16711680) >> 16;
            _loc_3 = (param1 & 65280) >> 8;
            _loc_4 = param1 & 255;
            _loc_2 = _loc_2 / 255;
            _loc_3 = _loc_3 / 255;
            _loc_4 = _loc_4 / 255;
            var _loc_8:* = Math.min(_loc_2, _loc_3, _loc_4);
            var _loc_9:* = Math.max(_loc_2, _loc_3, _loc_4);
            var _loc_10:* = Math.max(_loc_2, _loc_3, _loc_4) - _loc_8;
            _loc_7 = 1 - (_loc_9 + _loc_8) / 2;
            if (_loc_10 == 0)
            {
                _loc_5 = 0;
                _loc_6 = 0;
            }
            else
            {
                if (_loc_9 + _loc_8 < 1)
                {
                    _loc_6 = 1 - _loc_10 / (_loc_9 + _loc_8);
                }
                else
                {
                    _loc_6 = 1 - _loc_10 / (2 - _loc_9 - _loc_8);
                }
                _loc_11 = ((_loc_9 - _loc_2) / 6 + _loc_10 / 2) / _loc_10;
                _loc_12 = ((_loc_9 - _loc_3) / 6 + _loc_10 / 2) / _loc_10;
                _loc_13 = ((_loc_9 - _loc_4) / 6 + _loc_10 / 2) / _loc_10;
                if (_loc_2 == _loc_9)
                {
                    _loc_5 = _loc_13 - _loc_12;
                }
                else if (_loc_3 == _loc_9)
                {
                    _loc_5 = 1 / 3 + _loc_11 - _loc_13;
                }
                else if (_loc_4 == _loc_9)
                {
                    _loc_5 = 2 / 3 + _loc_12 - _loc_11;
                }
                if (_loc_5 < 0)
                {
                    _loc_5 = _loc_5 + 1;
                }
                if (_loc_5 > 1)
                {
                    _loc_5 = _loc_5 - 1;
                }
            }
            return {h:_loc_5, s:_loc_6, l:_loc_7};
        }// end function

    }
}
