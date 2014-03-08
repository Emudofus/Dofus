package com.ankamagames.jerakine.utils.crypto
{
   import flash.utils.ByteArray;
   import by.blooddy.crypto.Base64;
   
   public class Base64 extends Object
   {
      
      public function Base64() {
         super();
      }
      
      public static function encode(param1:String) : String {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         return by.blooddy.crypto.Base64.encode(_loc2_);
      }
      
      public static function encodeByteArray(param1:ByteArray) : String {
         return by.blooddy.crypto.Base64.encode(param1);
      }
      
      public static function decode(param1:String) : String {
         var _loc2_:ByteArray = by.blooddy.crypto.Base64.decode(param1);
         return _loc2_.readUTFBytes(_loc2_.length);
      }
      
      public static function decodeToByteArray(param1:String) : ByteArray {
         return by.blooddy.crypto.Base64.decode(param1);
      }
   }
}
