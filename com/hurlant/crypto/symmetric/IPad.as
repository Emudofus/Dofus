package com.hurlant.crypto.symmetric
{
    import flash.utils.ByteArray;

    public interface IPad 
    {

        function pad(_arg_1:ByteArray):void;
        function unpad(_arg_1:ByteArray):void;
        function setBlockSize(_arg_1:uint):void;

    }
}//package com.hurlant.crypto.symmetric

