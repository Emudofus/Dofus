package com.ankamagames.jerakine.script.api
{
   public class StringApi extends Object
   {
      
      public function StringApi() {
         super();
      }
      
      public static function Substr(str:String, startIndex:int, length:int) : String {
         return str.substr(startIndex,length);
      }
      
      public static function Substring(str:String, startIndex:int, endIndex:int) : String {
         return str.substring(startIndex,endIndex);
      }
      
      public static function ToLowerCase(str:String) : String {
         return str.toLowerCase();
      }
      
      public static function ToUpperCase(str:String) : String {
         return str.toUpperCase();
      }
      
      public static function GetIndexOf(haystack:String, needle:String, startIndex:int=0) : int {
         return haystack.indexOf(needle,startIndex);
      }
      
      public static function GetLastIndexOf(haystack:String, needle:String, startIndex:int=2147483647) : int {
         return haystack.lastIndexOf(needle,startIndex);
      }
      
      public static function GetLength(str:String) : int {
         return str.length;
      }
   }
}
