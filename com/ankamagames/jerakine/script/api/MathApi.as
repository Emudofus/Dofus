package com.ankamagames.jerakine.script.api
{
   public class MathApi extends Object
   {
      
      public function MathApi() {
         super();
      }
      
      public static const PI:Number = 3.141592653589793;
      
      public static function Max(param1:Number, param2:Number) : Number {
         return Math.max(param1,param2);
      }
      
      public static function Min(param1:Number, param2:Number) : Number {
         return Math.min(param1,param2);
      }
      
      public static function Abs(param1:Number) : Number {
         return Math.abs(param1);
      }
      
      public static function Ceil(param1:Number) : Number {
         return Math.ceil(param1);
      }
      
      public static function Floor(param1:Number) : Number {
         return Math.floor(param1);
      }
      
      public static function Round(param1:Number) : Number {
         return Math.round(param1);
      }
      
      public static function Cos(param1:Number) : Number {
         return Math.cos(param1);
      }
      
      public static function Sin(param1:Number) : Number {
         return Math.sin(param1);
      }
      
      public static function Acos(param1:Number) : Number {
         return Math.acos(param1);
      }
      
      public static function Asin(param1:Number) : Number {
         return Math.asin(param1);
      }
      
      public static function Tan(param1:Number) : Number {
         return Math.tan(param1);
      }
      
      public static function Atan(param1:Number) : Number {
         return Math.atan(param1);
      }
      
      public static function Atan2(param1:Number, param2:Number) : Number {
         return Math.atan2(param1,param2);
      }
      
      public static function Log(param1:Number) : Number {
         return Math.log(param1);
      }
      
      public static function Pow(param1:Number, param2:Number) : Number {
         return Math.pow(param1,param2);
      }
      
      public static function Sqrt(param1:Number) : Number {
         return Math.sqrt(param1);
      }
   }
}
