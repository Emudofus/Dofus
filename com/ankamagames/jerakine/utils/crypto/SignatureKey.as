package com.ankamagames.jerakine.utils.crypto
{
    import com.hurlant.crypto.rsa.*;
    import com.hurlant.math.*;
    import flash.utils.*;

    public class SignatureKey extends RSAKey
    {
        private var _canSign:Boolean;
        private static const PUBLIC_KEY_HEADER:String = "DofusPublicKey";
        private static const PRIVATE_KEY_HEADER:String = "DofusPrivateKey";

        public function SignatureKey(param1:BigInteger, param2:int, param3:BigInteger = null, param4:BigInteger = null, param5:BigInteger = null, param6:BigInteger = null, param7:BigInteger = null, param8:BigInteger = null)
        {
            super(param1, param2, param3, param4, param5, param6, param7, param8);
            return;
        }// end function

        public function get canSign() : Boolean
        {
            return canEncrypt;
        }// end function

        public static function fromByte(param1:IDataInput) : SignatureKey
        {
            var _loc_3:RSAKey = null;
            var _loc_2:* = param1.readUTF();
            if (_loc_2 != PUBLIC_KEY_HEADER && _loc_2 != PRIVATE_KEY_HEADER)
            {
                throw Error("Invalid public or private header");
            }
            if (_loc_2 == PUBLIC_KEY_HEADER)
            {
                _loc_3 = RSAKey.parsePublicKey(param1.readUTF(), param1.readUTF());
            }
            else
            {
                _loc_3 = RSAKey.parsePrivateKey(param1.readUTF(), param1.readUTF(), param1.readUTF(), param1.readUTF(), param1.readUTF(), param1.readUTF(), param1.readUTF());
            }
            return new SignatureKey(_loc_3.n, _loc_3.e, _loc_3.d, _loc_3.p, _loc_3.q, _loc_3.dmp1, _loc_3.dmq1, _loc_3.coeff);
        }// end function

    }
}
