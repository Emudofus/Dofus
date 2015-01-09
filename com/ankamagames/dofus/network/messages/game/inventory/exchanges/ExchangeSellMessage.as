package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class ExchangeSellMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5778;

        private var _isInitialized:Boolean = false;
        public var objectToSellId:uint = 0;
        public var quantity:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5778);
        }

        public function initExchangeSellMessage(objectToSellId:uint=0, quantity:uint=0):ExchangeSellMessage
        {
            this.objectToSellId = objectToSellId;
            this.quantity = quantity;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectToSellId = 0;
            this.quantity = 0;
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_ExchangeSellMessage(output);
        }

        public function serializeAs_ExchangeSellMessage(output:IDataOutput):void
        {
            if (this.objectToSellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectToSellId) + ") on element objectToSellId.")));
            };
            output.writeInt(this.objectToSellId);
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element quantity.")));
            };
            output.writeInt(this.quantity);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ExchangeSellMessage(input);
        }

        public function deserializeAs_ExchangeSellMessage(input:IDataInput):void
        {
            this.objectToSellId = input.readInt();
            if (this.objectToSellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectToSellId) + ") on element of ExchangeSellMessage.objectToSellId.")));
            };
            this.quantity = input.readInt();
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element of ExchangeSellMessage.quantity.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

