package com.ankamagames.jerakine.utils.display
{
   public class AngleToOrientation extends Object
   {
      
      public function AngleToOrientation() {
         super();
      }
      
      public static function angleToOrientation(param1:Number) : uint {
         var _loc2_:uint = 0;
         switch(null)
         {
            case param1 > -(Math.PI / 8) && param1 <= Math.PI / 8:
               _loc2_ = 0;
               break;
         }
         return _loc2_;
      }
   }
}
