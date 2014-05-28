package org.flintparticles.common.energyEasing
{
   public class Quadratic extends Object
   {
      
      public function Quadratic() {
         super();
      }
      
      public static function easeIn(param1:Number, param2:Number) : Number {
         return 1 - (param1 = param1 / param2) * param1;
      }
      
      public static function easeOut(param1:Number, param2:Number) : Number {
         return (param1 = 1 - param1 / param2) * param1;
      }
      
      public static function easeInOut(param1:Number, param2:Number) : Number {
         if((param1 = param1 / (param2 * 0.5)) < 1)
         {
            return 1 - param1 * param1 * 0.5;
         }
         return (param1 = param1 - 2) * param1 * 0.5;
      }
   }
}
