package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangePlayerRequestMessage extends ExchangeRequestMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5773;

        private var _isInitialized:Boolean = false;
        public var target:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5773);
        }

        public function initExchangePlayerRequestMessage(exchangeType:int=0, target:uint=0):ExchangePlayerRequestMessage
        {
            super.initExchangeRequestMessage(exchangeType);
            this.target = target;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.target = 0;
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            if (HASH_FUNCTION != null)
            {
                HASH_FUNCTION(data);
            };
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ExchangePlayerRequestMessage(output);
        }

        public function serializeAs_ExchangePlayerRequestMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ExchangeRequestMessage(output);
            if (this.target < 0)
            {
                throw (new Error((("Forbidden value (" + this.target) + ") on element target.")));
            };
            output.writeVarInt(this.target);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangePlayerRequestMessage(input);
        }

        public function deserializeAs_ExchangePlayerRequestMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.target = input.readVarUhInt();
            if (this.target < 0)
            {
                throw (new Error((("Forbidden value (" + this.target) + ") on element of ExchangePlayerRequestMessage.target.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

