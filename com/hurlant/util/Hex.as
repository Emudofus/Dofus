package com.hurlant.util
{
   import flash.utils.ByteArray;
   
   public class Hex extends Object
   {
      
      public function Hex()
      {
         super();
      }
      
      public static function toArray(param1:String) : ByteArray
      {
         var param1:String = param1.replace(new RegExp("\\s|:","gm"),"");
         var _loc2_:ByteArray = new ByteArray();
         if(param1.length & 1 == 1)
         {
            param1 = "0" + param1;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_[_loc3_ / 2] = parseInt(param1.substr(_loc3_,2),16);
            _loc3_ = _loc3_ + 2;
         }
         return _loc2_;
      }
      
      public static function fromArray(param1:ByteArray, param2:Boolean = false) : String
      {
         var _loc3_:* = "";
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = _loc3_ + ("0" + param1[_loc4_].toString(16)).substr(-2,2);
            if(param2)
            {
               if(_loc4_ < param1.length - 1)
               {
                  _loc3_ = _loc3_ + ":";
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function toString(param1:String) : String
      {
         var _loc2_:ByteArray = toArray(param1);
         return _loc2_.readUTFBytes(_loc2_.length);
      }
      
      public static function fromString(param1:String, param2:Boolean = false) : String
      {
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes(param1);
         return fromArray(_loc3_,param2);
      }
   }
}
