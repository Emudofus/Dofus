package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.data.items.SellerBuyerDescriptor;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeStartedBidBuyerMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5904;

        private var _isInitialized:Boolean = false;
        public var buyerDescriptor:SellerBuyerDescriptor;

        public function ExchangeStartedBidBuyerMessage()
        {
            this.buyerDescriptor = new SellerBuyerDescriptor();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5904);
        }

        public function initExchangeStartedBidBuyerMessage(buyerDescriptor:SellerBuyerDescriptor=null):ExchangeStartedBidBuyerMessage
        {
            this.buyerDescriptor = buyerDescriptor;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.buyerDescriptor = new SellerBuyerDescriptor();
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ExchangeStartedBidBuyerMessage(output);
        }

        public function serializeAs_ExchangeStartedBidBuyerMessage(output:ICustomDataOutput):void
        {
            this.buyerDescriptor.serializeAs_SellerBuyerDescriptor(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeStartedBidBuyerMessage(input);
        }

        public function deserializeAs_ExchangeStartedBidBuyerMessage(input:ICustomDataInput):void
        {
            this.buyerDescriptor = new SellerBuyerDescriptor();
            this.buyerDescriptor.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

