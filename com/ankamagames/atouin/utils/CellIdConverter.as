package com.ankamagames.atouin.utils
{
    import com.ankamagames.atouin.*;
    import flash.geom.*;

    public class CellIdConverter extends Object
    {
        public static var CELLPOS:Array = new Array();
        private static var _bInit:Boolean = false;

        public function CellIdConverter()
        {
            return;
        }// end function

        private static function init() : void
        {
            var _loc_4:* = 0;
            _bInit = true;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < AtouinConstants.MAP_HEIGHT)
            {
                
                _loc_4 = 0;
                while (_loc_4 < AtouinConstants.MAP_WIDTH)
                {
                    
                    CELLPOS[_loc_3] = new Point(_loc_1 + _loc_4, _loc_2 + _loc_4);
                    _loc_3++;
                    _loc_4++;
                }
                _loc_1++;
                _loc_4 = 0;
                while (_loc_4 < AtouinConstants.MAP_WIDTH)
                {
                    
                    CELLPOS[_loc_3] = new Point(_loc_1 + _loc_4, _loc_2 + _loc_4);
                    _loc_3++;
                    _loc_4++;
                }
                _loc_2 = _loc_2 - 1;
                _loc_5++;
            }
            return;
        }// end function

        public static function coordToCellId(param1:int, param2:int) : uint
        {
            if (!_bInit)
            {
                init();
            }
            return (param1 - param2) * AtouinConstants.MAP_WIDTH + param2 + (param1 - param2) / 2;
        }// end function

        public static function cellIdToCoord(param1:uint) : Point
        {
            if (!_bInit)
            {
                init();
            }
            if (!CELLPOS[param1])
            {
                return null;
            }
            return CELLPOS[param1];
        }// end function

    }
}
