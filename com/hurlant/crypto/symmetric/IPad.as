package com.hurlant.crypto.symmetric
{
    import flash.utils.*;

    public interface IPad
    {

        public function IPad();

        function pad(param1:ByteArray) : void;

        function unpad(param1:ByteArray) : void;

        function setBlockSize(param1:uint) : void;

    }
}
