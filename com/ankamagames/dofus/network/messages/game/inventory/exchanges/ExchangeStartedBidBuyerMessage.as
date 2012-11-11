package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeStartedBidBuyerMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var buyerDescriptor:SellerBuyerDescriptor;
        public static const protocolId:uint = 5904;

        public function ExchangeStartedBidBuyerMessage()
        {
            this.buyerDescriptor = new SellerBuyerDescriptor();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5904;
        }// end function

        public function initExchangeStartedBidBuyerMessage(param1:SellerBuyerDescriptor = null) : ExchangeStartedBidBuyerMessage
        {
            this.buyerDescriptor = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.buyerDescriptor = new SellerBuyerDescriptor();
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
            this.serializeAs_ExchangeStartedBidBuyerMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeStartedBidBuyerMessage(param1:IDataOutput) : void
        {
            this.buyerDescriptor.serializeAs_SellerBuyerDescriptor(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeStartedBidBuyerMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeStartedBidBuyerMessage(param1:IDataInput) : void
        {
            this.buyerDescriptor = new SellerBuyerDescriptor();
            this.buyerDescriptor.deserialize(param1);
            return;
        }// end function

    }
}
