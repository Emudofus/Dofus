package com.ankamagames.jerakine.utils.display
{
   public class AngleToOrientation extends Object
   {
      
      public function AngleToOrientation() {
         super();
      }
      
      public static function angleToOrientation(radianAngle:Number) : uint {
         var orientation:uint = 0;
         switch(null)
         {
            case radianAngle > -(Math.PI / 8) && radianAngle <= Math.PI / 8:
               orientation = 0;
               break;
         }
         return orientation;
      }
   }
}
