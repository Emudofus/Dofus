package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeStartedWithStorageMessage extends ExchangeStartedMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var storageMaxSlot:uint = 0;
        public static const protocolId:uint = 6236;

        public function ExchangeStartedWithStorageMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6236;
        }// end function

        public function initExchangeStartedWithStorageMessage(param1:int = 0, param2:uint = 0) : ExchangeStartedWithStorageMessage
        {
            super.initExchangeStartedMessage(param1);
            this.storageMaxSlot = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.storageMaxSlot = 0;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ExchangeStartedWithStorageMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeStartedWithStorageMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ExchangeStartedMessage(param1);
            if (this.storageMaxSlot < 0)
            {
                throw new Error("Forbidden value (" + this.storageMaxSlot + ") on element storageMaxSlot.");
            }
            param1.writeInt(this.storageMaxSlot);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeStartedWithStorageMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeStartedWithStorageMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.storageMaxSlot = param1.readInt();
            if (this.storageMaxSlot < 0)
            {
                throw new Error("Forbidden value (" + this.storageMaxSlot + ") on element of ExchangeStartedWithStorageMessage.storageMaxSlot.");
            }
            return;
        }// end function

    }
}
