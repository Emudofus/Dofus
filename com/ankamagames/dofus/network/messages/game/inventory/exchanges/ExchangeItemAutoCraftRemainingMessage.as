package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeItemAutoCraftRemainingMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6015;

        private var _isInitialized:Boolean = false;
        public var count:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6015);
        }

        public function initExchangeItemAutoCraftRemainingMessage(count:uint=0):ExchangeItemAutoCraftRemainingMessage
        {
            this.count = count;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.count = 0;
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
            this.serializeAs_ExchangeItemAutoCraftRemainingMessage(output);
        }

        public function serializeAs_ExchangeItemAutoCraftRemainingMessage(output:ICustomDataOutput):void
        {
            if (this.count < 0)
            {
                throw (new Error((("Forbidden value (" + this.count) + ") on element count.")));
            };
            output.writeVarInt(this.count);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeItemAutoCraftRemainingMessage(input);
        }

        public function deserializeAs_ExchangeItemAutoCraftRemainingMessage(input:ICustomDataInput):void
        {
            this.count = input.readVarUhInt();
            if (this.count < 0)
            {
                throw (new Error((("Forbidden value (" + this.count) + ") on element of ExchangeItemAutoCraftRemainingMessage.count.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

