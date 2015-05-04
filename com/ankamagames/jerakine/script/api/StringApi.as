package com.ankamagames.jerakine.script.api
{
   public class StringApi extends Object
   {
      
      public function StringApi()
      {
         super();
      }
      
      public static function Substr(param1:String, param2:int, param3:int) : String
      {
         return param1.substr(param2,param3);
      }
      
      public static function Substring(param1:String, param2:int, param3:int) : String
      {
         return param1.substring(param2,param3);
      }
      
      public static function ToLowerCase(param1:String) : String
      {
         return param1.toLowerCase();
      }
      
      public static function ToUpperCase(param1:String) : String
      {
         return param1.toUpperCase();
      }
      
      public static function GetIndexOf(param1:String, param2:String, param3:int = 0) : int
      {
         return param1.indexOf(param2,param3);
      }
      
      public static function GetLastIndexOf(param1:String, param2:String, param3:int = 2147483647) : int
      {
         return param1.lastIndexOf(param2,param3);
      }
      
      public static function GetLength(param1:String) : int
      {
         return param1.length;
      }
   }
}
