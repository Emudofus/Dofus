package com.ankamagames.atouin.utils
{
    import com.ankamagames.atouin.AtouinConstants;
    import flash.geom.Point;

    public class CellIdConverter 
    {

        public static var CELLPOS:Array = new Array();
        private static var _bInit:Boolean = false;


        private static function init():void
        {
            var b:int;
            _bInit = true;
            var startX:int;
            var startY:int;
            var cell:int;
            var a:int;
            while (a < AtouinConstants.MAP_HEIGHT)
            {
                b = 0;
                while (b < AtouinConstants.MAP_WIDTH)
                {
                    CELLPOS[cell] = new Point((startX + b), (startY + b));
                    cell++;
                    b++;
                };
                startX++;
                b = 0;
                while (b < AtouinConstants.MAP_WIDTH)
                {
                    CELLPOS[cell] = new Point((startX + b), (startY + b));
                    cell++;
                    b++;
                };
                startY--;
                a++;
            };
        }

        public static function coordToCellId(x:int, y:int):uint
        {
            if (!(_bInit))
            {
                init();
            };
            return (((((x - y) * AtouinConstants.MAP_WIDTH) + y) + ((x - y) / 2)));
        }

        public static function cellIdToCoord(cellId:uint):Point
        {
            if (!(_bInit))
            {
                init();
            };
            if (!(CELLPOS[cellId]))
            {
                return (null);
            };
            return (CELLPOS[cellId]);
        }


    }
}//package com.ankamagames.atouin.utils

