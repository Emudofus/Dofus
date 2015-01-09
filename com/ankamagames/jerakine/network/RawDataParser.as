package com.ankamagames.jerakine.network
{
    import flash.utils.IDataInput;

    public interface RawDataParser 
    {

        function parse(_arg_1:IDataInput, _arg_2:uint, _arg_3:uint):INetworkMessage;

    }
}//package com.ankamagames.jerakine.network

