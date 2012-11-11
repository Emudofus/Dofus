package com.ankamagames.jerakine.network
{
    import flash.utils.*;

    public interface RawDataParser
    {

        public function RawDataParser();

        function parse(param1:IDataInput, param2:uint, param3:uint) : INetworkMessage;

    }
}
