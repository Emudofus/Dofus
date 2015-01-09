package com.hurlant.crypto.prng
{
    import flash.utils.ByteArray;

    public interface IPRNG 
    {

        function getPoolSize():uint;
        function init(_arg_1:ByteArray):void;
        function next():uint;
        function dispose():void;
        function toString():String;

    }
}//package com.hurlant.crypto.prng

