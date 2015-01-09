package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class ExchangeObjectUseInWorkshopMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6004;

        private var _isInitialized:Boolean = false;
        public var objectUID:uint = 0;
        public var quantity:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6004);
        }

        public function initExchangeObjectUseInWorkshopMessage(objectUID:uint=0, quantity:int=0):ExchangeObjectUseInWorkshopMessage
        {
            this.objectUID = objectUID;
            this.quantity = quantity;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectUID = 0;
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
            this.serializeAs_ExchangeObjectUseInWorkshopMessage(output);
        }

        public function serializeAs_ExchangeObjectUseInWorkshopMessage(output:IDataOutput):void
        {
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element objectUID.")));
            };
            output.writeInt(this.objectUID);
            output.writeInt(this.quantity);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ExchangeObjectUseInWorkshopMessage(input);
        }

        public function deserializeAs_ExchangeObjectUseInWorkshopMessage(input:IDataInput):void
        {
            this.objectUID = input.readInt();
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element of ExchangeObjectUseInWorkshopMessage.objectUID.")));
            };
            this.quantity = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

