package com.ankamagames.dofus.network.messages.game.social
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ContactLookRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var requestId:uint = 0;
        public var contactType:uint = 0;
        public static const protocolId:uint = 5932;

        public function ContactLookRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5932;
        }// end function

        public function initContactLookRequestMessage(param1:uint = 0, param2:uint = 0) : ContactLookRequestMessage
        {
            this.requestId = param1;
            this.contactType = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.requestId = 0;
            this.contactType = 0;
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
            this.serializeAs_ContactLookRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_ContactLookRequestMessage(param1:IDataOutput) : void
        {
            if (this.requestId < 0 || this.requestId > 255)
            {
                throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
            }
            param1.writeByte(this.requestId);
            param1.writeByte(this.contactType);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ContactLookRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_ContactLookRequestMessage(param1:IDataInput) : void
        {
            this.requestId = param1.readUnsignedByte();
            if (this.requestId < 0 || this.requestId > 255)
            {
                throw new Error("Forbidden value (" + this.requestId + ") on element of ContactLookRequestMessage.requestId.");
            }
            this.contactType = param1.readByte();
            if (this.contactType < 0)
            {
                throw new Error("Forbidden value (" + this.contactType + ") on element of ContactLookRequestMessage.contactType.");
            }
            return;
        }// end function

    }
}
