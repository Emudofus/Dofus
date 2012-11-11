package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeCraftSlotCountIncreasedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var newMaxSlot:uint = 0;
        public static const protocolId:uint = 6125;

        public function ExchangeCraftSlotCountIncreasedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6125;
        }// end function

        public function initExchangeCraftSlotCountIncreasedMessage(param1:uint = 0) : ExchangeCraftSlotCountIncreasedMessage
        {
            this.newMaxSlot = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.newMaxSlot = 0;
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
            this.serializeAs_ExchangeCraftSlotCountIncreasedMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeCraftSlotCountIncreasedMessage(param1:IDataOutput) : void
        {
            if (this.newMaxSlot < 0)
            {
                throw new Error("Forbidden value (" + this.newMaxSlot + ") on element newMaxSlot.");
            }
            param1.writeByte(this.newMaxSlot);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeCraftSlotCountIncreasedMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeCraftSlotCountIncreasedMessage(param1:IDataInput) : void
        {
            this.newMaxSlot = param1.readByte();
            if (this.newMaxSlot < 0)
            {
                throw new Error("Forbidden value (" + this.newMaxSlot + ") on element of ExchangeCraftSlotCountIncreasedMessage.newMaxSlot.");
            }
            return;
        }// end function

    }
}
