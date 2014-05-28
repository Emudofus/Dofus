package com.ankamagames.atouin.utils
{
   import flash.geom.Point;
   import com.ankamagames.atouin.AtouinConstants;
   
   public class CellIdConverter extends Object
   {
      
      public function CellIdConverter() {
         super();
      }
      
      public static var CELLPOS:Array;
      
      private static var _bInit:Boolean = false;
      
      private static function init() : void {
         var b:* = 0;
         _bInit = true;
         var startX:int = 0;
         var startY:int = 0;
         var cell:int = 0;
         var a:int = 0;
         while(a < AtouinConstants.MAP_HEIGHT)
         {
            b = 0;
            while(b < AtouinConstants.MAP_WIDTH)
            {
               CELLPOS[cell] = new Point(startX + b,startY + b);
               cell++;
               b++;
            }
            startX++;
            b = 0;
            while(b < AtouinConstants.MAP_WIDTH)
            {
               CELLPOS[cell] = new Point(startX + b,startY + b);
               cell++;
               b++;
            }
            startY--;
            a++;
         }
      }
      
      public static function coordToCellId(x:int, y:int) : uint {
         if(!_bInit)
         {
            init();
         }
         return (x - y) * AtouinConstants.MAP_WIDTH + y + (x - y) / 2;
      }
      
      public static function cellIdToCoord(cellId:uint) : Point {
         if(!_bInit)
         {
            init();
         }
         if(!CELLPOS[cellId])
         {
            return null;
         }
         return CELLPOS[cellId];
      }
   }
}
