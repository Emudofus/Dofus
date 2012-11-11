package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeItemObjectAddAsPaymentMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var paymentType:int = 0;
        public var bAdd:Boolean = false;
        public var objectToMoveId:uint = 0;
        public var quantity:uint = 0;
        public static const protocolId:uint = 5766;

        public function ExchangeItemObjectAddAsPaymentMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5766;
        }// end function

        public function initExchangeItemObjectAddAsPaymentMessage(param1:int = 0, param2:Boolean = false, param3:uint = 0, param4:uint = 0) : ExchangeItemObjectAddAsPaymentMessage
        {
            this.paymentType = param1;
            this.bAdd = param2;
            this.objectToMoveId = param3;
            this.quantity = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.paymentType = 0;
            this.bAdd = false;
            this.objectToMoveId = 0;
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
            this.serializeAs_ExchangeItemObjectAddAsPaymentMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeItemObjectAddAsPaymentMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.paymentType);
            param1.writeBoolean(this.bAdd);
            if (this.objectToMoveId < 0)
            {
                throw new Error("Forbidden value (" + this.objectToMoveId + ") on element objectToMoveId.");
            }
            param1.writeInt(this.objectToMoveId);
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            param1.writeInt(this.quantity);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeItemObjectAddAsPaymentMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeItemObjectAddAsPaymentMessage(param1:IDataInput) : void
        {
            this.paymentType = param1.readByte();
            this.bAdd = param1.readBoolean();
            this.objectToMoveId = param1.readInt();
            if (this.objectToMoveId < 0)
            {
                throw new Error("Forbidden value (" + this.objectToMoveId + ") on element of ExchangeItemObjectAddAsPaymentMessage.objectToMoveId.");
            }
            this.quantity = param1.readInt();
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element of ExchangeItemObjectAddAsPaymentMessage.quantity.");
            }
            return;
        }// end function

    }
}
