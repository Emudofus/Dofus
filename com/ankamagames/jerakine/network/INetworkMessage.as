package com.ankamagames.jerakine.network
{
    import com.ankamagames.jerakine.messages.IdentifiedMessage;
    import com.ankamagames.jerakine.messages.QueueableMessage;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    public interface INetworkMessage extends IdentifiedMessage, QueueableMessage 
    {

        function pack(_arg_1:IDataOutput):void;
        function unpack(_arg_1:IDataInput, _arg_2:uint):void;
        function get isInitialized():Boolean;

    }
}//package com.ankamagames.jerakine.network

