package com.ankamagames.jerakine.network
{
    import com.ankamagames.jerakine.messages.MessageHandler;

    public interface IServerConnection 
    {

        function get rawParser():RawDataParser;
        function set rawParser(_arg_1:RawDataParser):void;
        function get handler():MessageHandler;
        function set handler(_arg_1:MessageHandler):void;
        function get pauseBuffer():Array;
        function get connected():Boolean;
        function get latencyAvg():uint;
        function get latencySamplesCount():uint;
        function get latencySamplesMax():uint;
        function get lagometer():ILagometer;
        function set lagometer(_arg_1:ILagometer):void;
        function connect(_arg_1:String, _arg_2:int):void;
        function close():void;
        function pause():void;
        function resume():void;
        function send(_arg_1:INetworkMessage):void;

    }
}//package com.ankamagames.jerakine.network

