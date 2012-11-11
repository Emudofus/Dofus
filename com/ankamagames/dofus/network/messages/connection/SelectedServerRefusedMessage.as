package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SelectedServerRefusedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var serverId:int = 0;
        public var error:uint = 1;
        public var serverStatus:uint = 1;
        public static const protocolId:uint = 41;

        public function SelectedServerRefusedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 41;
        }// end function

        public function initSelectedServerRefusedMessage(param1:int = 0, param2:uint = 1, param3:uint = 1) : SelectedServerRefusedMessage
        {
            this.serverId = param1;
            this.error = param2;
            this.serverStatus = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.serverId = 0;
            this.error = 1;
            this.serverStatus = 1;
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
            this.serializeAs_SelectedServerRefusedMessage(param1);
            return;
        }// end function

        public function serializeAs_SelectedServerRefusedMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.serverId);
            param1.writeByte(this.error);
            param1.writeByte(this.serverStatus);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SelectedServerRefusedMessage(param1);
            return;
        }// end function

        public function deserializeAs_SelectedServerRefusedMessage(param1:IDataInput) : void
        {
            this.serverId = param1.readShort();
            this.error = param1.readByte();
            if (this.error < 0)
            {
                throw new Error("Forbidden value (" + this.error + ") on element of SelectedServerRefusedMessage.error.");
            }
            this.serverStatus = param1.readByte();
            if (this.serverStatus < 0)
            {
                throw new Error("Forbidden value (" + this.serverStatus + ") on element of SelectedServerRefusedMessage.serverStatus.");
            }
            return;
        }// end function

    }
}
