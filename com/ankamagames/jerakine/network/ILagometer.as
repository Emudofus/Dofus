package com.ankamagames.jerakine.network
{

    public interface ILagometer
    {

        public function ILagometer();

        function ping() : void;

        function pong() : void;

        function stop() : void;

    }
}
