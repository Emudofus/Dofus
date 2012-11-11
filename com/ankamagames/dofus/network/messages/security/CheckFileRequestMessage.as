package com.ankamagames.dofus.network.messages.security
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CheckFileRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var filename:String = "";
        public var type:uint = 0;
        public static const protocolId:uint = 6154;

        public function CheckFileRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6154;
        }// end function

        public function initCheckFileRequestMessage(param1:String = "", param2:uint = 0) : CheckFileRequestMessage
        {
            this.filename = param1;
            this.type = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.filename = "";
            this.type = 0;
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
            this.serializeAs_CheckFileRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_CheckFileRequestMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.filename);
            param1.writeByte(this.type);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CheckFileRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_CheckFileRequestMessage(param1:IDataInput) : void
        {
            this.filename = param1.readUTF();
            this.type = param1.readByte();
            if (this.type < 0)
            {
                throw new Error("Forbidden value (" + this.type + ") on element of CheckFileRequestMessage.type.");
            }
            return;
        }// end function

    }
}
