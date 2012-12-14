package com.ankamagames.jerakine.utils.crypto
{
    import flash.utils.*;

    public class Base64 extends Object
    {

        public function Base64()
        {
            return;
        }// end function

        public static function encode(param1:String) : String
        {
            var _loc_2:* = new ByteArray();
            _loc_2.writeUTFBytes(param1);
            return by.blooddy.crypto::Base64.encode(_loc_2);
        }// end function

        public static function encodeByteArray(param1:ByteArray) : String
        {
            return by.blooddy.crypto::Base64.encode(param1);
        }// end function

        public static function decode(param1:String) : String
        {
            var _loc_2:* = by.blooddy.crypto::Base64.decode(param1);
            return _loc_2.readUTFBytes(_loc_2.length);
        }// end function

        public static function decodeToByteArray(param1:String) : ByteArray
        {
            return by.blooddy.crypto::Base64.decode(param1);
        }// end function

    }
}
