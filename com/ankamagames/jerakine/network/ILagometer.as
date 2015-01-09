package com.ankamagames.jerakine.network
{
    public interface ILagometer 
    {

        function ping(_arg_1:INetworkMessage=null):void;
        function pong(_arg_1:INetworkMessage=null):void;
        function stop():void;

    }
}//package com.ankamagames.jerakine.network

