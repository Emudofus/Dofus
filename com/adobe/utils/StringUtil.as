package com.adobe.utils
{
   public class StringUtil extends Object
   {
      
      public function StringUtil() {
         super();
      }
      
      public static function beginsWith(param1:String, param2:String) : Boolean {
         return param2 == param1.substring(0,param2.length);
      }
      
      public static function trim(param1:String) : String {
         return StringUtil.ltrim(StringUtil.rtrim(param1));
      }
      
      public static function stringsAreEqual(param1:String, param2:String, param3:Boolean) : Boolean {
         if(param3)
         {
            return param1 == param2;
         }
         return param1.toUpperCase() == param2.toUpperCase();
      }
      
      public static function replace(param1:String, param2:String, param3:String) : String {
         return param1.split(param2).join(param3);
      }
      
      public static function rtrim(param1:String) : String {
         var _loc2_:Number = param1.length;
         var _loc3_:Number = _loc2_;
         while(_loc3_ > 0)
         {
            if(param1.charCodeAt(_loc3_-1) > 32)
            {
               return param1.substring(0,_loc3_);
            }
            _loc3_--;
         }
         return "";
      }
      
      public static function endsWith(param1:String, param2:String) : Boolean {
         return param2 == param1.substring(param1.length - param2.length);
      }
      
      public static function stringHasValue(param1:String) : Boolean {
         return !(param1 == null) && param1.length > 0;
      }
      
      public static function remove(param1:String, param2:String) : String {
         return StringUtil.replace(param1,param2,"");
      }
      
      public static function ltrim(param1:String) : String {
         var _loc2_:Number = param1.length;
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1.charCodeAt(_loc3_) > 32)
            {
               return param1.substring(_loc3_);
            }
            _loc3_++;
         }
         return "";
      }
   }
}
