package flashx.textLayout.utils
{
   public final class Twips extends Object
   {
      
      public function Twips() {
         super();
      }
      
      public static const ONE_TWIP:Number = 0.05;
      
      public static const TWIPS_PER_PIXEL:int = 20;
      
      public static const MAX_VALUE:int = int.MAX_VALUE;
      
      public static const MIN_VALUE:int = int.MIN_VALUE;
      
      public static function to(param1:Number) : int {
         return int(param1 * 20);
      }
      
      public static function roundTo(param1:Number) : int {
         return int(Math.round(param1) * 20);
      }
      
      public static function from(param1:int) : Number {
         return Number(param1) / 20;
      }
      
      public static function ceil(param1:Number) : Number {
         return Math.ceil(param1 * 20) / 20;
      }
      
      public static function floor(param1:Number) : Number {
         return Math.floor(param1 * 20) / 20;
      }
      
      public static function round(param1:Number) : Number {
         return Math.round(param1 * 20) / 20;
      }
   }
}
