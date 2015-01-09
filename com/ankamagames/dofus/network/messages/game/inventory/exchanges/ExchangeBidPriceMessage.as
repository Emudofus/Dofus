package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeBidPriceMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5755;

        private var _isInitialized:Boolean = false;
        public var genericId:uint = 0;
        public var averagePrice:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5755);
        }

        public function initExchangeBidPriceMessage(genericId:uint=0, averagePrice:int=0):ExchangeBidPriceMessage
        {
            this.genericId = genericId;
            this.averagePrice = averagePrice;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.genericId = 0;
            this.averagePrice = 0;
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
            this.serializeAs_ExchangeBidPriceMessage(output);
        }

        public function serializeAs_ExchangeBidPriceMessage(output:ICustomDataOutput):void
        {
            if (this.genericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.genericId) + ") on element genericId.")));
            };
            output.writeVarShort(this.genericId);
            output.writeVarInt(this.averagePrice);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeBidPriceMessage(input);
        }

        public function deserializeAs_ExchangeBidPriceMessage(input:ICustomDataInput):void
        {
            this.genericId = input.readVarUhShort();
            if (this.genericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.genericId) + ") on element of ExchangeBidPriceMessage.genericId.")));
            };
            this.averagePrice = input.readVarInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

