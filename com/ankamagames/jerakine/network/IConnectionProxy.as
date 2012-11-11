package com.ankamagames.jerakine.network
{
    import flash.utils.*;

    public interface IConnectionProxy
    {

        public function IConnectionProxy();

        function processAndSend(param1:INetworkMessage, param2:IDataOutput) : void;

        function processAndReceive(param1:IDataInput) : INetworkMessage;

    }
}
