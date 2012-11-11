package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeStartedBidSellerMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var sellerDescriptor:SellerBuyerDescriptor;
        public var objectsInfos:Vector.<ObjectItemToSellInBid>;
        public static const protocolId:uint = 5905;

        public function ExchangeStartedBidSellerMessage()
        {
            this.sellerDescriptor = new SellerBuyerDescriptor();
            this.objectsInfos = new Vector.<ObjectItemToSellInBid>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5905;
        }// end function

        public function initExchangeStartedBidSellerMessage(param1:SellerBuyerDescriptor = null, param2:Vector.<ObjectItemToSellInBid> = null) : ExchangeStartedBidSellerMessage
        {
            this.sellerDescriptor = param1;
            this.objectsInfos = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.sellerDescriptor = new SellerBuyerDescriptor();
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
            this.serializeAs_ExchangeStartedBidSellerMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeStartedBidSellerMessage(param1:IDataOutput) : void
        {
            this.sellerDescriptor.serializeAs_SellerBuyerDescriptor(param1);
            param1.writeShort(this.objectsInfos.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.objectsInfos.length)
            {
                
                (this.objectsInfos[_loc_2] as ObjectItemToSellInBid).serializeAs_ObjectItemToSellInBid(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeStartedBidSellerMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeStartedBidSellerMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            this.sellerDescriptor = new SellerBuyerDescriptor();
            this.sellerDescriptor.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new ObjectItemToSellInBid();
                _loc_4.deserialize(param1);
                this.objectsInfos.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
