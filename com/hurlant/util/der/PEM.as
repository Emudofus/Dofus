package com.hurlant.util.der
{
   import com.hurlant.crypto.rsa.RSAKey;
   import flash.utils.ByteArray;
   import com.hurlant.util.Base64;
   
   public class PEM extends Object
   {
      
      public function PEM() {
         super();
      }
      
      private static const RSA_PRIVATE_KEY_HEADER:String = "-----BEGIN RSA PRIVATE KEY-----";
      
      private static const RSA_PRIVATE_KEY_FOOTER:String = "-----END RSA PRIVATE KEY-----";
      
      private static const RSA_PUBLIC_KEY_HEADER:String = "-----BEGIN PUBLIC KEY-----";
      
      private static const RSA_PUBLIC_KEY_FOOTER:String = "-----END PUBLIC KEY-----";
      
      private static const CERTIFICATE_HEADER:String = "-----BEGIN CERTIFICATE-----";
      
      private static const CERTIFICATE_FOOTER:String = "-----END CERTIFICATE-----";
      
      public static function readRSAPrivateKey(param1:String) : RSAKey {
         var _loc4_:Array = null;
         var _loc2_:ByteArray = extractBinary(RSA_PRIVATE_KEY_HEADER,RSA_PRIVATE_KEY_FOOTER,param1);
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:* = DER.parse(_loc2_);
         if(_loc3_ is Array)
         {
            _loc4_ = _loc3_ as Array;
            return new RSAKey(_loc4_[1],_loc4_[2].valueOf(),_loc4_[3],_loc4_[4],_loc4_[5],_loc4_[6],_loc4_[7],_loc4_[8]);
         }
         return null;
      }
      
      public static function readRSAPublicKey(param1:String) : RSAKey {
         var _loc4_:Array = null;
         var _loc2_:ByteArray = extractBinary(RSA_PUBLIC_KEY_HEADER,RSA_PUBLIC_KEY_FOOTER,param1);
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:* = DER.parse(_loc2_);
         if(_loc3_ is Array)
         {
            _loc4_ = _loc3_ as Array;
            if(_loc4_[0][0].toString() != OID.RSA_ENCRYPTION)
            {
               return null;
            }
            _loc4_[1].position = 0;
            _loc3_ = DER.parse(_loc4_[1]);
            if(_loc3_ is Array)
            {
               _loc4_ = _loc3_ as Array;
               return new RSAKey(_loc4_[0],_loc4_[1]);
            }
            return null;
         }
         return null;
      }
      
      public static function readCertIntoArray(param1:String) : ByteArray {
         var _loc2_:ByteArray = extractBinary(CERTIFICATE_HEADER,CERTIFICATE_FOOTER,param1);
         return _loc2_;
      }
      
      private static function extractBinary(param1:String, param2:String, param3:String) : ByteArray {
         var _loc4_:int = param3.indexOf(param1);
         if(_loc4_ == -1)
         {
            return null;
         }
         _loc4_ = _loc4_ + param1.length;
         var _loc5_:int = param3.indexOf(param2);
         if(_loc5_ == -1)
         {
            return null;
         }
         var _loc6_:String = param3.substring(_loc4_,_loc5_);
         _loc6_ = _loc6_.replace(new RegExp("\\s","mg"),"");
         return Base64.decodeToByteArray(_loc6_);
      }
   }
}
