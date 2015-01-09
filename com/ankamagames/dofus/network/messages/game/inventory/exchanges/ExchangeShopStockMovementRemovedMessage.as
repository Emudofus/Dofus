package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeShopStockMovementRemovedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5907;

        private var _isInitialized:Boolean = false;
        public var objectId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5907);
        }

        public function initExchangeShopStockMovementRemovedMessage(objectId:uint=0):ExchangeShopStockMovementRemovedMessage
        {
            this.objectId = objectId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectId = 0;
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
            this.serializeAs_ExchangeShopStockMovementRemovedMessage(output);
        }

        public function serializeAs_ExchangeShopStockMovementRemovedMessage(output:ICustomDataOutput):void
        {
            if (this.objectId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectId) + ") on element objectId.")));
            };
            output.writeVarInt(this.objectId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeShopStockMovementRemovedMessage(input);
        }

        public function deserializeAs_ExchangeShopStockMovementRemovedMessage(input:ICustomDataInput):void
        {
            this.objectId = input.readVarUhInt();
            if (this.objectId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectId) + ") on element of ExchangeShopStockMovementRemovedMessage.objectId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

