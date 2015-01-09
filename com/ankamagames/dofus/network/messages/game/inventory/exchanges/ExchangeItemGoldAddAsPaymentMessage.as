package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class ExchangeItemGoldAddAsPaymentMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5770;

        private var _isInitialized:Boolean = false;
        public var paymentType:int = 0;
        public var quantity:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5770);
        }

        public function initExchangeItemGoldAddAsPaymentMessage(paymentType:int=0, quantity:uint=0):ExchangeItemGoldAddAsPaymentMessage
        {
            this.paymentType = paymentType;
            this.quantity = quantity;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.paymentType = 0;
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
            this.serializeAs_ExchangeItemGoldAddAsPaymentMessage(output);
        }

        public function serializeAs_ExchangeItemGoldAddAsPaymentMessage(output:IDataOutput):void
        {
            output.writeByte(this.paymentType);
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element quantity.")));
            };
            output.writeInt(this.quantity);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ExchangeItemGoldAddAsPaymentMessage(input);
        }

        public function deserializeAs_ExchangeItemGoldAddAsPaymentMessage(input:IDataInput):void
        {
            this.paymentType = input.readByte();
            this.quantity = input.readInt();
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element of ExchangeItemGoldAddAsPaymentMessage.quantity.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

