package com.ankamagames.jerakine.utils.crypto
{
   import com.hurlant.crypto.rsa.RSAKey;
   import flash.utils.IDataInput;
   import com.hurlant.math.BigInteger;
   
   public class SignatureKey extends RSAKey
   {
      
      public function SignatureKey(param1:BigInteger, param2:int, param3:BigInteger=null, param4:BigInteger=null, param5:BigInteger=null, param6:BigInteger=null, param7:BigInteger=null, param8:BigInteger=null) {
         super(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      private static const PUBLIC_KEY_HEADER:String = "DofusPublicKey";
      
      private static const PRIVATE_KEY_HEADER:String = "DofusPrivateKey";
      
      public static function fromByte(param1:IDataInput) : SignatureKey {
         var _loc3_:RSAKey = null;
         var _loc2_:String = param1.readUTF();
         if(!(_loc2_ == PUBLIC_KEY_HEADER) && !(_loc2_ == PRIVATE_KEY_HEADER))
         {
            throw Error("Invalid public or private header");
         }
         else
         {
            if(_loc2_ == PUBLIC_KEY_HEADER)
            {
               _loc3_ = RSAKey.parsePublicKey(param1.readUTF(),param1.readUTF());
            }
            else
            {
               _loc3_ = RSAKey.parsePrivateKey(param1.readUTF(),param1.readUTF(),param1.readUTF(),param1.readUTF(),param1.readUTF(),param1.readUTF(),param1.readUTF(),param1.readUTF());
            }
            return new SignatureKey(_loc3_.n,_loc3_.e,_loc3_.d,_loc3_.p,_loc3_.q,_loc3_.dmp1,_loc3_.dmq1,_loc3_.coeff);
         }
      }
      
      private var _canSign:Boolean;
      
      public function get canSign() : Boolean {
         return canEncrypt;
      }
   }
}
