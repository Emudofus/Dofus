package org.flintparticles.common.energyEasing
{
   public class Linear extends Object
   {
      
      public function Linear() {
         super();
      }
      
      public static function easeNone(param1:Number, param2:Number) : Number {
         return 1 - param1 / param2;
      }
      
      public static function easeIn(param1:Number, param2:Number) : Number {
         return 1 - param1 / param2;
      }
      
      public static function easeOut(param1:Number, param2:Number) : Number {
         return 1 - param1 / param2;
      }
      
      public static function easeInOut(param1:Number, param2:Number) : Number {
         return 1 - param1 / param2;
      }
   }
}
