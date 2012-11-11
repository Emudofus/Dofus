package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeItemGoldAddAsPaymentMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var paymentType:int = 0;
        public var quantity:uint = 0;
        public static const protocolId:uint = 5770;

        public function ExchangeItemGoldAddAsPaymentMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5770;
        }// end function

        public function initExchangeItemGoldAddAsPaymentMessage(param1:int = 0, param2:uint = 0) : ExchangeItemGoldAddAsPaymentMessage
        {
            this.paymentType = param1;
            this.quantity = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.paymentType = 0;
            this.quantity = 0;
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
            this.serializeAs_ExchangeItemGoldAddAsPaymentMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeItemGoldAddAsPaymentMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.paymentType);
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            param1.writeInt(this.quantity);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeItemGoldAddAsPaymentMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeItemGoldAddAsPaymentMessage(param1:IDataInput) : void
        {
            this.paymentType = param1.readByte();
            this.quantity = param1.readInt();
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element of ExchangeItemGoldAddAsPaymentMessage.quantity.");
            }
            return;
        }// end function

    }
}
