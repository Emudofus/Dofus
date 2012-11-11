package com.ankamagames.atouin.utils
{
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.display.*;

    public class CellUtil extends Object
    {

        public function CellUtil()
        {
            return;
        }// end function

        public static function getPixelXFromMapPoint(param1:MapPoint) : int
        {
            var _loc_2:* = InteractiveCellManager.getInstance().getCell(param1.cellId);
            return _loc_2.x + _loc_2.width / 2;
        }// end function

        public static function getPixelYFromMapPoint(param1:MapPoint) : int
        {
            var _loc_2:* = InteractiveCellManager.getInstance().getCell(param1.cellId);
            return _loc_2.y + _loc_2.height / 2;
        }// end function

        public static function isLeftCol(param1:int) : Boolean
        {
            return param1 % 14 == 0;
        }// end function

        public static function isRightCol(param1:int) : Boolean
        {
            return isLeftCol((param1 + 1));
        }// end function

        public static function isTopRow(param1:int) : Boolean
        {
            return param1 < 28;
        }// end function

        public static function isBottomRow(param1:int) : Boolean
        {
            return param1 > 531;
        }// end function

        public static function isEvenRow(param1:int) : Boolean
        {
            return Math.floor(param1 / 14) % 2 == 0;
        }// end function

    }
}
