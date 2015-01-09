package com.ankamagames.jerakine.utils.display
{
    import src.flash.MapTools;
    import __AS3__.vec.Vector;
    import flash.geom.Point;

    public class Dofus2Line 
    {


        public static function getLine(startCellId:uint, endCellId:uint):Vector.<Point>
        {
            var points:Vector.<Point> = MapTools.getLOSCellsVector(startCellId, endCellId).reverse();
            return (points);
        }


    }
}//package com.ankamagames.jerakine.utils.display

