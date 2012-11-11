package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeShopStockMovementRemovedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var objectId:uint = 0;
        public static const protocolId:uint = 5907;

        public function ExchangeShopStockMovementRemovedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5907;
        }// end function

        public function initExchangeShopStockMovementRemovedMessage(param1:uint = 0) : ExchangeShopStockMovementRemovedMessage
        {
            this.objectId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.objectId = 0;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ExchangeShopStockMovementRemovedMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeShopStockMovementRemovedMessage(param1:IDataOutput) : void
        {
            if (this.objectId < 0)
            {
                throw new Error("Forbidden value (" + this.objectId + ") on element objectId.");
            }
            param1.writeInt(this.objectId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeShopStockMovementRemovedMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeShopStockMovementRemovedMessage(param1:IDataInput) : void
        {
            this.objectId = param1.readInt();
            if (this.objectId < 0)
            {
                throw new Error("Forbidden value (" + this.objectId + ") on element of ExchangeShopStockMovementRemovedMessage.objectId.");
            }
            return;
        }// end function

    }
}
