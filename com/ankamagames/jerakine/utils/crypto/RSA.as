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
      
      public static function publicEncrypt(key:String, baIn:ByteArray) : ByteArray {
         var baOut:ByteArray = new ByteArray();
         var publicKey:RSAKey = PEM.readRSAPublicKey(key);
         publicKey.encrypt(baIn,baOut,baIn.length);
         return baOut;
      }
   }
}
