package com.ankamagames.jerakine.script.api
{
   public class MathApi extends Object
   {
      
      public function MathApi() {
         super();
      }
      
      public static const PI:Number = 3.141592653589793;
      
      public static function Max(a:Number, b:Number) : Number {
         return Math.max(a,b);
      }
      
      public static function Min(a:Number, b:Number) : Number {
         return Math.min(a,b);
      }
      
      public static function Abs(value:Number) : Number {
         return Math.abs(value);
      }
      
      public static function Ceil(value:Number) : Number {
         return Math.ceil(value);
      }
      
      public static function Floor(value:Number) : Number {
         return Math.floor(value);
      }
      
      public static function Round(value:Number) : Number {
         return Math.round(value);
      }
      
      public static function Cos(value:Number) : Number {
         return Math.cos(value);
      }
      
      public static function Sin(value:Number) : Number {
         return Math.sin(value);
      }
      
      public static function Acos(value:Number) : Number {
         return Math.acos(value);
      }
      
      public static function Asin(value:Number) : Number {
         return Math.asin(value);
      }
      
      public static function Tan(value:Number) : Number {
         return Math.tan(value);
      }
      
      public static function Atan(value:Number) : Number {
         return Math.atan(value);
      }
      
      public static function Atan2(x:Number, y:Number) : Number {
         return Math.atan2(x,y);
      }
      
      public static function Log(value:Number) : Number {
         return Math.log(value);
      }
      
      public static function Pow(base:Number, exp:Number) : Number {
         return Math.pow(base,exp);
      }
      
      public static function Sqrt(value:Number) : Number {
         return Math.sqrt(value);
      }
   }
}
