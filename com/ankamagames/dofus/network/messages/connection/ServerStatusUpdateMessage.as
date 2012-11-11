package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.dofus.network.types.connection.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ServerStatusUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var server:GameServerInformations;
        public static const protocolId:uint = 50;

        public function ServerStatusUpdateMessage()
        {
            this.server = new GameServerInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 50;
        }// end function

        public function initServerStatusUpdateMessage(param1:GameServerInformations = null) : ServerStatusUpdateMessage
        {
            this.server = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.server = new GameServerInformations();
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
            this.serializeAs_ServerStatusUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_ServerStatusUpdateMessage(param1:IDataOutput) : void
        {
            this.server.serializeAs_GameServerInformations(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ServerStatusUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_ServerStatusUpdateMessage(param1:IDataInput) : void
        {
            this.server = new GameServerInformations();
            this.server.deserialize(param1);
            return;
        }// end function

    }
}
