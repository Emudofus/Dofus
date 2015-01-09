package com.ankamagames.jerakine.network
{
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    public interface IConnectionProxy 
    {

        function processAndSend(_arg_1:INetworkMessage, _arg_2:IDataOutput):void;
        function processAndReceive(_arg_1:IDataInput):INetworkMessage;

    }
}//package com.ankamagames.jerakine.network

