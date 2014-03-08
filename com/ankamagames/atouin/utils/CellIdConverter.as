package com.ankamagames.atouin.utils
{
   import flash.geom.Point;
   import com.ankamagames.atouin.AtouinConstants;
   
   public class CellIdConverter extends Object
   {
      
      public function CellIdConverter() {
         super();
      }
      
      public static var CELLPOS:Array = new Array();
      
      private static var _bInit:Boolean = false;
      
      private static function init() : void {
         var _loc4_:* = 0;
         _bInit = true;
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc5_:* = 0;
         while(_loc5_ < AtouinConstants.MAP_HEIGHT)
         {
            _loc4_ = 0;
            while(_loc4_ < AtouinConstants.MAP_WIDTH)
            {
               CELLPOS[_loc3_] = new Point(_loc1_ + _loc4_,_loc2_ + _loc4_);
               _loc3_++;
               _loc4_++;
            }
            _loc1_++;
            _loc4_ = 0;
            while(_loc4_ < AtouinConstants.MAP_WIDTH)
            {
               CELLPOS[_loc3_] = new Point(_loc1_ + _loc4_,_loc2_ + _loc4_);
               _loc3_++;
               _loc4_++;
            }
            _loc2_--;
            _loc5_++;
         }
      }
      
      public static function coordToCellId(param1:int, param2:int) : uint {
         if(!_bInit)
         {
            init();
         }
         return (param1 - param2) * AtouinConstants.MAP_WIDTH + param2 + (param1 - param2) / 2;
      }
      
      public static function cellIdToCoord(param1:uint) : Point {
         if(!_bInit)
         {
            init();
         }
         if(!CELLPOS[param1])
         {
            return null;
         }
         return CELLPOS[param1];
      }
   }
}
