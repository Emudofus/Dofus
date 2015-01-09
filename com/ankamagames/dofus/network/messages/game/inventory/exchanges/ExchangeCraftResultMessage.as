package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeCraftResultMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5790;

        private var _isInitialized:Boolean = false;
        public var craftResult:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5790);
        }

        public function initExchangeCraftResultMessage(craftResult:uint=0):ExchangeCraftResultMessage
        {
            this.craftResult = craftResult;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.craftResult = 0;
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
            this.serializeAs_ExchangeCraftResultMessage(output);
        }

        public function serializeAs_ExchangeCraftResultMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.craftResult);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeCraftResultMessage(input);
        }

        public function deserializeAs_ExchangeCraftResultMessage(input:ICustomDataInput):void
        {
            this.craftResult = input.readByte();
            if (this.craftResult < 0)
            {
                throw (new Error((("Forbidden value (" + this.craftResult) + ") on element of ExchangeCraftResultMessage.craftResult.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

