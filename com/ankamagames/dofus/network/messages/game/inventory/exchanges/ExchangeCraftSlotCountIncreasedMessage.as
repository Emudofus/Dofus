package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class ExchangeCraftSlotCountIncreasedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6125;

        private var _isInitialized:Boolean = false;
        public var newMaxSlot:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6125);
        }

        public function initExchangeCraftSlotCountIncreasedMessage(newMaxSlot:uint=0):ExchangeCraftSlotCountIncreasedMessage
        {
            this.newMaxSlot = newMaxSlot;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.newMaxSlot = 0;
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
            this.serializeAs_ExchangeCraftSlotCountIncreasedMessage(output);
        }

        public function serializeAs_ExchangeCraftSlotCountIncreasedMessage(output:IDataOutput):void
        {
            if (this.newMaxSlot < 0)
            {
                throw (new Error((("Forbidden value (" + this.newMaxSlot) + ") on element newMaxSlot.")));
            };
            output.writeByte(this.newMaxSlot);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ExchangeCraftSlotCountIncreasedMessage(input);
        }

        public function deserializeAs_ExchangeCraftSlotCountIncreasedMessage(input:IDataInput):void
        {
            this.newMaxSlot = input.readByte();
            if (this.newMaxSlot < 0)
            {
                throw (new Error((("Forbidden value (" + this.newMaxSlot) + ") on element of ExchangeCraftSlotCountIncreasedMessage.newMaxSlot.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

