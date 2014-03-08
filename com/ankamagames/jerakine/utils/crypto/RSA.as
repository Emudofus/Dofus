package com.ankamagames.jerakine.utils.crypto
{
   import flash.utils.ByteArray;
   import com.hurlant.util.der.PEM;
   import com.hurlant.crypto.rsa.RSAKey;
   
   public class RSA extends Object
   {
      
      public function RSA() {
         super();
      }
      
      public static function publicEncrypt(param1:String, param2:ByteArray) : ByteArray {
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:RSAKey = PEM.readRSAPublicKey(param1);
         _loc4_.encrypt(param2,_loc3_,param2.length);
         return _loc3_;
      }
   }
}
