package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ServerSelectionMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var serverId:int = 0;
        public static const protocolId:uint = 40;

        public function ServerSelectionMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 40;
        }// end function

        public function initServerSelectionMessage(param1:int = 0) : ServerSelectionMessage
        {
            this.serverId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.serverId = 0;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ServerSelectionMessage(param1);
            return;
        }// end function

        public function serializeAs_ServerSelectionMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.serverId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ServerSelectionMessage(param1);
            return;
        }// end function

        public function deserializeAs_ServerSelectionMessage(param1:IDataInput) : void
        {
            this.serverId = param1.readShort();
            return;
        }// end function

    }
}
