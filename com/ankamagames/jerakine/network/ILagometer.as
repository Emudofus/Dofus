package com.ankamagames.jerakine.network
{

    public interface ILagometer
    {

        public function ILagometer();

        function ping(param1:INetworkMessage = null) : void;

        function pong(param1:INetworkMessage = null) : void;

        function stop() : void;

    }
}
