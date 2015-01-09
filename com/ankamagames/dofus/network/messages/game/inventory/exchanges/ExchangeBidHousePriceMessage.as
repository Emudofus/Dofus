package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeBidHousePriceMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5805;

        private var _isInitialized:Boolean = false;
        public var genId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5805);
        }

        public function initExchangeBidHousePriceMessage(genId:uint=0):ExchangeBidHousePriceMessage
        {
            this.genId = genId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.genId = 0;
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
            this.serializeAs_ExchangeBidHousePriceMessage(output);
        }

        public function serializeAs_ExchangeBidHousePriceMessage(output:ICustomDataOutput):void
        {
            if (this.genId < 0)
            {
                throw (new Error((("Forbidden value (" + this.genId) + ") on element genId.")));
            };
            output.writeVarShort(this.genId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeBidHousePriceMessage(input);
        }

        public function deserializeAs_ExchangeBidHousePriceMessage(input:ICustomDataInput):void
        {
            this.genId = input.readVarUhShort();
            if (this.genId < 0)
            {
                throw (new Error((("Forbidden value (" + this.genId) + ") on element of ExchangeBidHousePriceMessage.genId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

