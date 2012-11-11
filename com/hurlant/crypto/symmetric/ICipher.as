package com.hurlant.crypto.symmetric
{
    import flash.utils.*;

    public interface ICipher
    {

        public function ICipher();

        function getBlockSize() : uint;

        function encrypt(param1:ByteArray) : void;

        function decrypt(param1:ByteArray) : void;

        function dispose() : void;

        function toString() : String;

    }
}
