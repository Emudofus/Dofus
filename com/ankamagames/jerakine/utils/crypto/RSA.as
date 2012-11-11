package com.ankamagames.jerakine.utils.crypto
{
    import com.hurlant.crypto.rsa.*;
    import com.hurlant.util.der.*;
    import flash.utils.*;

    public class RSA extends Object
    {

        public function RSA()
        {
            return;
        }// end function

        public static function publicEncrypt(param1:String, param2:ByteArray) : ByteArray
        {
            var _loc_3:* = new ByteArray();
            var _loc_4:* = PEM.readRSAPublicKey(param1);
            PEM.readRSAPublicKey(param1).encrypt(param2, _loc_3, param2.length);
            return _loc_3;
        }// end function

    }
}
