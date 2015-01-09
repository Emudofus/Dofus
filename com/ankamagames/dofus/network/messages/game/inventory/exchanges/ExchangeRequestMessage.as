package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5505;

        private var _isInitialized:Boolean = false;
        public var exchangeType:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5505);
        }

        public function initExchangeRequestMessage(exchangeType:int=0):ExchangeRequestMessage
        {
            this.exchangeType = exchangeType;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.exchangeType = 0;
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
            this.serializeAs_ExchangeRequestMessage(output);
        }

        public function serializeAs_ExchangeRequestMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.exchangeType);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeRequestMessage(input);
        }

        public function deserializeAs_ExchangeRequestMessage(input:ICustomDataInput):void
        {
            this.exchangeType = input.readByte();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

