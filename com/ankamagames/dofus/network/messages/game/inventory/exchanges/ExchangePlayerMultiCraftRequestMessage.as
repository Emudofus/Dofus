package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangePlayerMultiCraftRequestMessage extends ExchangeRequestMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5784;

        private var _isInitialized:Boolean = false;
        public var target:uint = 0;
        public var skillId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5784);
        }

        public function initExchangePlayerMultiCraftRequestMessage(exchangeType:int=0, target:uint=0, skillId:uint=0):ExchangePlayerMultiCraftRequestMessage
        {
            super.initExchangeRequestMessage(exchangeType);
            this.target = target;
            this.skillId = skillId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.target = 0;
            this.skillId = 0;
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
            this.serializeAs_ExchangePlayerMultiCraftRequestMessage(output);
        }

        public function serializeAs_ExchangePlayerMultiCraftRequestMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ExchangeRequestMessage(output);
            if (this.target < 0)
            {
                throw (new Error((("Forbidden value (" + this.target) + ") on element target.")));
            };
            output.writeVarInt(this.target);
            if (this.skillId < 0)
            {
                throw (new Error((("Forbidden value (" + this.skillId) + ") on element skillId.")));
            };
            output.writeVarInt(this.skillId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangePlayerMultiCraftRequestMessage(input);
        }

        public function deserializeAs_ExchangePlayerMultiCraftRequestMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.target = input.readVarUhInt();
            if (this.target < 0)
            {
                throw (new Error((("Forbidden value (" + this.target) + ") on element of ExchangePlayerMultiCraftRequestMessage.target.")));
            };
            this.skillId = input.readVarUhInt();
            if (this.skillId < 0)
            {
                throw (new Error((("Forbidden value (" + this.skillId) + ") on element of ExchangePlayerMultiCraftRequestMessage.skillId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

