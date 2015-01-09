package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeItemObjectAddAsPaymentMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5766;

        private var _isInitialized:Boolean = false;
        public var paymentType:uint = 0;
        public var bAdd:Boolean = false;
        public var objectToMoveId:uint = 0;
        public var quantity:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5766);
        }

        public function initExchangeItemObjectAddAsPaymentMessage(paymentType:uint=0, bAdd:Boolean=false, objectToMoveId:uint=0, quantity:uint=0):ExchangeItemObjectAddAsPaymentMessage
        {
            this.paymentType = paymentType;
            this.bAdd = bAdd;
            this.objectToMoveId = objectToMoveId;
            this.quantity = quantity;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.paymentType = 0;
            this.bAdd = false;
            this.objectToMoveId = 0;
            this.quantity = 0;
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
            this.serializeAs_ExchangeItemObjectAddAsPaymentMessage(output);
        }

        public function serializeAs_ExchangeItemObjectAddAsPaymentMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.paymentType);
            output.writeBoolean(this.bAdd);
            if (this.objectToMoveId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectToMoveId) + ") on element objectToMoveId.")));
            };
            output.writeVarInt(this.objectToMoveId);
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element quantity.")));
            };
            output.writeVarInt(this.quantity);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeItemObjectAddAsPaymentMessage(input);
        }

        public function deserializeAs_ExchangeItemObjectAddAsPaymentMessage(input:ICustomDataInput):void
        {
            this.paymentType = input.readByte();
            if (this.paymentType < 0)
            {
                throw (new Error((("Forbidden value (" + this.paymentType) + ") on element of ExchangeItemObjectAddAsPaymentMessage.paymentType.")));
            };
            this.bAdd = input.readBoolean();
            this.objectToMoveId = input.readVarUhInt();
            if (this.objectToMoveId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectToMoveId) + ") on element of ExchangeItemObjectAddAsPaymentMessage.objectToMoveId.")));
            };
            this.quantity = input.readVarUhInt();
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element of ExchangeItemObjectAddAsPaymentMessage.quantity.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

