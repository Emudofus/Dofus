package com.ankamagames.jerakine.utils.display
{
   import flash.geom.Point;
   import src.flash.MapTools;
   
   public class Dofus2Line extends Object
   {
      
      public function Dofus2Line() {
         super();
      }
      
      public static function getLine(startCellId:uint, endCellId:uint) : Vector.<Point> {
         var points:Vector.<Point> = MapTools.getLOSCellsVector(startCellId,endCellId).reverse();
         return points;
      }
   }
}
