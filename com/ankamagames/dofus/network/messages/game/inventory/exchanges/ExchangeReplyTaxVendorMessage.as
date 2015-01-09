package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeReplyTaxVendorMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5787;

        private var _isInitialized:Boolean = false;
        public var objectValue:uint = 0;
        public var totalTaxValue:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5787);
        }

        public function initExchangeReplyTaxVendorMessage(objectValue:uint=0, totalTaxValue:uint=0):ExchangeReplyTaxVendorMessage
        {
            this.objectValue = objectValue;
            this.totalTaxValue = totalTaxValue;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectValue = 0;
            this.totalTaxValue = 0;
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
            this.serializeAs_ExchangeReplyTaxVendorMessage(output);
        }

        public function serializeAs_ExchangeReplyTaxVendorMessage(output:ICustomDataOutput):void
        {
            if (this.objectValue < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectValue) + ") on element objectValue.")));
            };
            output.writeVarInt(this.objectValue);
            if (this.totalTaxValue < 0)
            {
                throw (new Error((("Forbidden value (" + this.totalTaxValue) + ") on element totalTaxValue.")));
            };
            output.writeVarInt(this.totalTaxValue);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeReplyTaxVendorMessage(input);
        }

        public function deserializeAs_ExchangeReplyTaxVendorMessage(input:ICustomDataInput):void
        {
            this.objectValue = input.readVarUhInt();
            if (this.objectValue < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectValue) + ") on element of ExchangeReplyTaxVendorMessage.objectValue.")));
            };
            this.totalTaxValue = input.readVarUhInt();
            if (this.totalTaxValue < 0)
            {
                throw (new Error((("Forbidden value (" + this.totalTaxValue) + ") on element of ExchangeReplyTaxVendorMessage.totalTaxValue.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

