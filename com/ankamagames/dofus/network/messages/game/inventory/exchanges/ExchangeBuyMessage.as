package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeBuyMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5774;

        private var _isInitialized:Boolean = false;
        public var objectToBuyId:uint = 0;
        public var quantity:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5774);
        }

        public function initExchangeBuyMessage(objectToBuyId:uint=0, quantity:uint=0):ExchangeBuyMessage
        {
            this.objectToBuyId = objectToBuyId;
            this.quantity = quantity;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectToBuyId = 0;
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
            this.serializeAs_ExchangeBuyMessage(output);
        }

        public function serializeAs_ExchangeBuyMessage(output:ICustomDataOutput):void
        {
            if (this.objectToBuyId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectToBuyId) + ") on element objectToBuyId.")));
            };
            output.writeVarInt(this.objectToBuyId);
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element quantity.")));
            };
            output.writeVarInt(this.quantity);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeBuyMessage(input);
        }

        public function deserializeAs_ExchangeBuyMessage(input:ICustomDataInput):void
        {
            this.objectToBuyId = input.readVarUhInt();
            if (this.objectToBuyId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectToBuyId) + ") on element of ExchangeBuyMessage.objectToBuyId.")));
            };
            this.quantity = input.readVarUhInt();
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element of ExchangeBuyMessage.quantity.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

