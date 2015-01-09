package com.hurlant.crypto.hash
{
    import flash.utils.ByteArray;

    public interface IHMAC 
    {

        function getHashSize():uint;
        function compute(_arg_1:ByteArray, _arg_2:ByteArray):ByteArray;
        function dispose():void;
        function toString():String;

    }
}//package com.hurlant.crypto.hash

