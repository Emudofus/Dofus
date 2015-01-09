package com.ankamagames.jerakine.network
{
    import com.ankamagames.jerakine.messages.IdentifiedMessage;
    import com.ankamagames.jerakine.messages.QueueableMessage;

    public interface INetworkMessage extends IdentifiedMessage, QueueableMessage 
    {

        function pack(_arg_1:ICustomDataOutput):void;
        function unpack(_arg_1:ICustomDataInput, _arg_2:uint):void;
        function get isInitialized():Boolean;

    }
}//package com.ankamagames.jerakine.network

