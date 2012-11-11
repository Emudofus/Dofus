package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeReplyTaxVendorMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var objectValue:uint = 0;
        public var totalTaxValue:uint = 0;
        public static const protocolId:uint = 5787;

        public function ExchangeReplyTaxVendorMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5787;
        }// end function

        public function initExchangeReplyTaxVendorMessage(param1:uint = 0, param2:uint = 0) : ExchangeReplyTaxVendorMessage
        {
            this.objectValue = param1;
            this.totalTaxValue = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.objectValue = 0;
            this.totalTaxValue = 0;
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
            this.serializeAs_ExchangeReplyTaxVendorMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeReplyTaxVendorMessage(param1:IDataOutput) : void
        {
            if (this.objectValue < 0)
            {
                throw new Error("Forbidden value (" + this.objectValue + ") on element objectValue.");
            }
            param1.writeInt(this.objectValue);
            if (this.totalTaxValue < 0)
            {
                throw new Error("Forbidden value (" + this.totalTaxValue + ") on element totalTaxValue.");
            }
            param1.writeInt(this.totalTaxValue);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeReplyTaxVendorMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeReplyTaxVendorMessage(param1:IDataInput) : void
        {
            this.objectValue = param1.readInt();
            if (this.objectValue < 0)
            {
                throw new Error("Forbidden value (" + this.objectValue + ") on element of ExchangeReplyTaxVendorMessage.objectValue.");
            }
            this.totalTaxValue = param1.readInt();
            if (this.totalTaxValue < 0)
            {
                throw new Error("Forbidden value (" + this.totalTaxValue + ") on element of ExchangeReplyTaxVendorMessage.totalTaxValue.");
            }
            return;
        }// end function

    }
}
