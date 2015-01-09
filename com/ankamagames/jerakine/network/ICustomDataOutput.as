package com.ankamagames.jerakine.network
{
    import flash.utils.IDataOutput;

    public interface ICustomDataOutput extends IDataOutput 
    {

        function writeVarInt(_arg_1:int):void;
        function writeVarShort(_arg_1:int):void;
        function writeVarLong(_arg_1:Number):void;

    }
}//package com.ankamagames.jerakine.network

