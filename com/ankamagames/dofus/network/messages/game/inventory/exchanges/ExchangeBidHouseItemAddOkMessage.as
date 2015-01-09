package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInBid;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeBidHouseItemAddOkMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5945;

        private var _isInitialized:Boolean = false;
        public var itemInfo:ObjectItemToSellInBid;

        public function ExchangeBidHouseItemAddOkMessage()
        {
            this.itemInfo = new ObjectItemToSellInBid();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5945);
        }

        public function initExchangeBidHouseItemAddOkMessage(itemInfo:ObjectItemToSellInBid=null):ExchangeBidHouseItemAddOkMessage
        {
            this.itemInfo = itemInfo;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.itemInfo = new ObjectItemToSellInBid();
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
            this.serializeAs_ExchangeBidHouseItemAddOkMessage(output);
        }

        public function serializeAs_ExchangeBidHouseItemAddOkMessage(output:ICustomDataOutput):void
        {
            this.itemInfo.serializeAs_ObjectItemToSellInBid(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeBidHouseItemAddOkMessage(input);
        }

        public function deserializeAs_ExchangeBidHouseItemAddOkMessage(input:ICustomDataInput):void
        {
            this.itemInfo = new ObjectItemToSellInBid();
            this.itemInfo.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

