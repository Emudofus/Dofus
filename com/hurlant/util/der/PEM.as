package com.hurlant.util.der
{
    import com.hurlant.crypto.rsa.*;
    import com.hurlant.util.*;
    import flash.utils.*;

    public class PEM extends Object
    {
        private static const RSA_PRIVATE_KEY_HEADER:String = "-----BEGIN RSA PRIVATE KEY-----";
        private static const RSA_PRIVATE_KEY_FOOTER:String = "-----END RSA PRIVATE KEY-----";
        private static const RSA_PUBLIC_KEY_HEADER:String = "-----BEGIN PUBLIC KEY-----";
        private static const RSA_PUBLIC_KEY_FOOTER:String = "-----END PUBLIC KEY-----";
        private static const CERTIFICATE_HEADER:String = "-----BEGIN CERTIFICATE-----";
        private static const CERTIFICATE_FOOTER:String = "-----END CERTIFICATE-----";

        public function PEM()
        {
            return;
        }// end function

        public static function readRSAPrivateKey(param1:String) : RSAKey
        {
            var _loc_4:* = null;
            var _loc_2:* = extractBinary(RSA_PRIVATE_KEY_HEADER, RSA_PRIVATE_KEY_FOOTER, param1);
            if (_loc_2 == null)
            {
                return null;
            }
            var _loc_3:* = DER.parse(_loc_2);
            if (_loc_3 is Array)
            {
                _loc_4 = _loc_3 as Array;
                return new RSAKey(_loc_4[1], _loc_4[2].valueOf(), _loc_4[3], _loc_4[4], _loc_4[5], _loc_4[6], _loc_4[7], _loc_4[8]);
            }
            return null;
        }// end function

        public static function readRSAPublicKey(param1:String) : RSAKey
        {
            var _loc_4:* = null;
            var _loc_2:* = extractBinary(RSA_PUBLIC_KEY_HEADER, RSA_PUBLIC_KEY_FOOTER, param1);
            if (_loc_2 == null)
            {
                return null;
            }
            var _loc_3:* = DER.parse(_loc_2);
            if (_loc_3 is Array)
            {
                _loc_4 = _loc_3 as Array;
                if (_loc_4[0][0].toString() != OID.RSA_ENCRYPTION)
                {
                    return null;
                }
                _loc_4[1].position = 0;
                _loc_3 = DER.parse(_loc_4[1]);
                if (_loc_3 is Array)
                {
                    _loc_4 = _loc_3 as Array;
                    return new RSAKey(_loc_4[0], _loc_4[1]);
                }
                return null;
            }
            else
            {
                return null;
            }
        }// end function

        public static function readCertIntoArray(param1:String) : ByteArray
        {
            var _loc_2:* = extractBinary(CERTIFICATE_HEADER, CERTIFICATE_FOOTER, param1);
            return _loc_2;
        }// end function

        private static function extractBinary(param1:String, param2:String, param3:String) : ByteArray
        {
            var _loc_4:* = param3.indexOf(param1);
            if (param3.indexOf(param1) == -1)
            {
                return null;
            }
            _loc_4 = _loc_4 + param1.length;
            var _loc_5:* = param3.indexOf(param2);
            if (param3.indexOf(param2) == -1)
            {
                return null;
            }
            var _loc_6:* = param3.substring(_loc_4, _loc_5);
            _loc_6 = param3.substring(_loc_4, _loc_5).replace(/\s""\s/mg, "");
            return Base64.decodeToByteArray(_loc_6);
        }// end function

    }
}
