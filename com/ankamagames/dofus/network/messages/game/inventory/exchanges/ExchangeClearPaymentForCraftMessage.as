package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeClearPaymentForCraftMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6145;

        private var _isInitialized:Boolean = false;
        public var paymentType:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6145);
        }

        public function initExchangeClearPaymentForCraftMessage(paymentType:uint=0):ExchangeClearPaymentForCraftMessage
        {
            this.paymentType = paymentType;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.paymentType = 0;
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
            this.serializeAs_ExchangeClearPaymentForCraftMessage(output);
        }

        public function serializeAs_ExchangeClearPaymentForCraftMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.paymentType);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeClearPaymentForCraftMessage(input);
        }

        public function deserializeAs_ExchangeClearPaymentForCraftMessage(input:ICustomDataInput):void
        {
            this.paymentType = input.readByte();
            if (this.paymentType < 0)
            {
                throw (new Error((("Forbidden value (" + this.paymentType) + ") on element of ExchangeClearPaymentForCraftMessage.paymentType.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

