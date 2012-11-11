package com.ankamagames.jerakine.network
{
    import com.ankamagames.jerakine.messages.*;
    import flash.utils.*;

    public interface INetworkMessage extends IdentifiedMessage, QueueableMessage
    {

        public function INetworkMessage();

        function pack(param1:IDataOutput) : void;

        function unpack(param1:IDataInput, param2:uint) : void;

        function get isInitialized() : Boolean;

    }
}
