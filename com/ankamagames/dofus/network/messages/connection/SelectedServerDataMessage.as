package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SelectedServerDataMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var serverId:int = 0;
        public var address:String = "";
        public var port:uint = 0;
        public var canCreateNewCharacter:Boolean = false;
        public var ticket:String = "";
        public static const protocolId:uint = 42;

        public function SelectedServerDataMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 42;
        }// end function

        public function initSelectedServerDataMessage(param1:int = 0, param2:String = "", param3:uint = 0, param4:Boolean = false, param5:String = "") : SelectedServerDataMessage
        {
            this.serverId = param1;
            this.address = param2;
            this.port = param3;
            this.canCreateNewCharacter = param4;
            this.ticket = param5;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.serverId = 0;
            this.address = "";
            this.port = 0;
            this.canCreateNewCharacter = false;
            this.ticket = "";
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
            this.serializeAs_SelectedServerDataMessage(param1);
            return;
        }// end function

        public function serializeAs_SelectedServerDataMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.serverId);
            param1.writeUTF(this.address);
            if (this.port < 0 || this.port > 65535)
            {
                throw new Error("Forbidden value (" + this.port + ") on element port.");
            }
            param1.writeShort(this.port);
            param1.writeBoolean(this.canCreateNewCharacter);
            param1.writeUTF(this.ticket);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SelectedServerDataMessage(param1);
            return;
        }// end function

        public function deserializeAs_SelectedServerDataMessage(param1:IDataInput) : void
        {
            this.serverId = param1.readShort();
            this.address = param1.readUTF();
            this.port = param1.readUnsignedShort();
            if (this.port < 0 || this.port > 65535)
            {
                throw new Error("Forbidden value (" + this.port + ") on element of SelectedServerDataMessage.port.");
            }
            this.canCreateNewCharacter = param1.readBoolean();
            this.ticket = param1.readUTF();
            return;
        }// end function

    }
}
