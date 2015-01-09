package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeRequestedTradeMessage extends ExchangeRequestedMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5523;

        private var _isInitialized:Boolean = false;
        public var source:uint = 0;
        public var target:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5523);
        }

        public function initExchangeRequestedTradeMessage(exchangeType:int=0, source:uint=0, target:uint=0):ExchangeRequestedTradeMessage
        {
            super.initExchangeRequestedMessage(exchangeType);
            this.source = source;
            this.target = target;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.source = 0;
            this.target = 0;
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
            this.serializeAs_ExchangeRequestedTradeMessage(output);
        }

        public function serializeAs_ExchangeRequestedTradeMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ExchangeRequestedMessage(output);
            if (this.source < 0)
            {
                throw (new Error((("Forbidden value (" + this.source) + ") on element source.")));
            };
            output.writeVarInt(this.source);
            if (this.target < 0)
            {
                throw (new Error((("Forbidden value (" + this.target) + ") on element target.")));
            };
            output.writeVarInt(this.target);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeRequestedTradeMessage(input);
        }

        public function deserializeAs_ExchangeRequestedTradeMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.source = input.readVarUhInt();
            if (this.source < 0)
            {
                throw (new Error((("Forbidden value (" + this.source) + ") on element of ExchangeRequestedTradeMessage.source.")));
            };
            this.target = input.readVarUhInt();
            if (this.target < 0)
            {
                throw (new Error((("Forbidden value (" + this.target) + ") on element of ExchangeRequestedTradeMessage.target.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

