package com.hurlant.crypto.prng
{
    import flash.utils.*;

    public interface IPRNG
    {

        public function IPRNG();

        function getPoolSize() : uint;

        function init(param1:ByteArray) : void;

        function next() : uint;

        function dispose() : void;

        function toString() : String;

    }
}
