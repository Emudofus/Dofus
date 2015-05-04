package com.ankamagames.jerakine.utils.display
{
   import flash.geom.Point;
   import src.flash.MapTools;
   
   public class Dofus2Line extends Object
   {
      
      public function Dofus2Line()
      {
         super();
      }
      
      public static function getLine(param1:uint, param2:uint) : Vector.<Point>
      {
         var _loc3_:Vector.<Point> = MapTools.getLOSCellsVector(param1,param2).reverse();
         return _loc3_;
      }
   }
}
