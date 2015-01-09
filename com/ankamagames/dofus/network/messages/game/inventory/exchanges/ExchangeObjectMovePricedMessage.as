package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeObjectMovePricedMessage extends ExchangeObjectMoveMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5514;

        private var _isInitialized:Boolean = false;
        public var price:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5514);
        }

        public function initExchangeObjectMovePricedMessage(objectUID:uint=0, quantity:int=0, price:uint=0):ExchangeObjectMovePricedMessage
        {
            super.initExchangeObjectMoveMessage(objectUID, quantity);
            this.price = price;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.price = 0;
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ExchangeObjectMovePricedMessage(output);
        }

        public function serializeAs_ExchangeObjectMovePricedMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ExchangeObjectMoveMessage(output);
            if (this.price < 0)
            {
                throw (new Error((("Forbidden value (" + this.price) + ") on element price.")));
            };
            output.writeVarInt(this.price);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeObjectMovePricedMessage(input);
        }

        public function deserializeAs_ExchangeObjectMovePricedMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.price = input.readVarUhInt();
            if (this.price < 0)
            {
                throw (new Error((("Forbidden value (" + this.price) + ") on element of ExchangeObjectMovePricedMessage.price.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

