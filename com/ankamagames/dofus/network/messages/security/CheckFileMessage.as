package com.ankamagames.dofus.network.messages.security
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CheckFileMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var filenameHash:String = "";
        public var type:uint = 0;
        public var value:String = "";
        public static const protocolId:uint = 6156;

        public function CheckFileMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6156;
        }// end function

        public function initCheckFileMessage(param1:String = "", param2:uint = 0, param3:String = "") : CheckFileMessage
        {
            this.filenameHash = param1;
            this.type = param2;
            this.value = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.filenameHash = "";
            this.type = 0;
            this.value = "";
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
            this.serializeAs_CheckFileMessage(param1);
            return;
        }// end function

        public function serializeAs_CheckFileMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.filenameHash);
            param1.writeByte(this.type);
            param1.writeUTF(this.value);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CheckFileMessage(param1);
            return;
        }// end function

        public function deserializeAs_CheckFileMessage(param1:IDataInput) : void
        {
            this.filenameHash = param1.readUTF();
            this.type = param1.readByte();
            if (this.type < 0)
            {
                throw new Error("Forbidden value (" + this.type + ") on element of CheckFileMessage.type.");
            }
            this.value = param1.readUTF();
            return;
        }// end function

    }
}
