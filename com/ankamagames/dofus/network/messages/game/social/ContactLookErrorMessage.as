package com.ankamagames.dofus.network.messages.game.social
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ContactLookErrorMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var requestId:uint = 0;
        public static const protocolId:uint = 6045;

        public function ContactLookErrorMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6045;
        }// end function

        public function initContactLookErrorMessage(param1:uint = 0) : ContactLookErrorMessage
        {
            this.requestId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.requestId = 0;
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
            this.serializeAs_ContactLookErrorMessage(param1);
            return;
        }// end function

        public function serializeAs_ContactLookErrorMessage(param1:IDataOutput) : void
        {
            if (this.requestId < 0)
            {
                throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
            }
            param1.writeInt(this.requestId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ContactLookErrorMessage(param1);
            return;
        }// end function

        public function deserializeAs_ContactLookErrorMessage(param1:IDataInput) : void
        {
            this.requestId = param1.readInt();
            if (this.requestId < 0)
            {
                throw new Error("Forbidden value (" + this.requestId + ") on element of ContactLookErrorMessage.requestId.");
            }
            return;
        }// end function

    }
}
