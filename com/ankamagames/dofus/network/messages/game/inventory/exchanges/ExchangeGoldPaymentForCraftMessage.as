package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeGoldPaymentForCraftMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var onlySuccess:Boolean = false;
        public var goldSum:uint = 0;
        public static const protocolId:uint = 5833;

        public function ExchangeGoldPaymentForCraftMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5833;
        }// end function

        public function initExchangeGoldPaymentForCraftMessage(param1:Boolean = false, param2:uint = 0) : ExchangeGoldPaymentForCraftMessage
        {
            this.onlySuccess = param1;
            this.goldSum = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.onlySuccess = false;
            this.goldSum = 0;
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
            this.serializeAs_ExchangeGoldPaymentForCraftMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeGoldPaymentForCraftMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.onlySuccess);
            if (this.goldSum < 0)
            {
                throw new Error("Forbidden value (" + this.goldSum + ") on element goldSum.");
            }
            param1.writeInt(this.goldSum);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeGoldPaymentForCraftMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeGoldPaymentForCraftMessage(param1:IDataInput) : void
        {
            this.onlySuccess = param1.readBoolean();
            this.goldSum = param1.readInt();
            if (this.goldSum < 0)
            {
                throw new Error("Forbidden value (" + this.goldSum + ") on element of ExchangeGoldPaymentForCraftMessage.goldSum.");
            }
            return;
        }// end function

    }
}
