package gs.easing
{


   public class Strong extends Object
   {
         

      public function Strong() {
         super();
      }

      public static function easeIn(t:Number, b:Number, c:Number, d:Number) : Number {
         return c*(t=t/d)*t*t*t*t+b;
      }

      public static function easeOut(t:Number, b:Number, c:Number, d:Number) : Number {
         return c*((t=t/d-1)*t*t*t*t+1)+b;
      }

      public static function easeInOut(t:Number, b:Number, c:Number, d:Number) : Number {
         if((t=t/d/2)<1)
         {
            return c/2*t*t*t*t*t+b;
         }
         return c/2*((t=t-2)*t*t*t*t+2)+b;
      }


   }

}