package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeRequestOnTaxCollectorMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5779;

        private var _isInitialized:Boolean = false;
        public var taxCollectorId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5779);
        }

        public function initExchangeRequestOnTaxCollectorMessage(taxCollectorId:int=0):ExchangeRequestOnTaxCollectorMessage
        {
            this.taxCollectorId = taxCollectorId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.taxCollectorId = 0;
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
            this.serializeAs_ExchangeRequestOnTaxCollectorMessage(output);
        }

        public function serializeAs_ExchangeRequestOnTaxCollectorMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.taxCollectorId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeRequestOnTaxCollectorMessage(input);
        }

        public function deserializeAs_ExchangeRequestOnTaxCollectorMessage(input:ICustomDataInput):void
        {
            this.taxCollectorId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

