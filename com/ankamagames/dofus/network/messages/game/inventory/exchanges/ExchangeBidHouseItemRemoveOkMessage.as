package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeBidHouseItemRemoveOkMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var sellerId:int = 0;
        public static const protocolId:uint = 5946;

        public function ExchangeBidHouseItemRemoveOkMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5946;
        }// end function

        public function initExchangeBidHouseItemRemoveOkMessage(param1:int = 0) : ExchangeBidHouseItemRemoveOkMessage
        {
            this.sellerId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.sellerId = 0;
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
            this.serializeAs_ExchangeBidHouseItemRemoveOkMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeBidHouseItemRemoveOkMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.sellerId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeBidHouseItemRemoveOkMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeBidHouseItemRemoveOkMessage(param1:IDataInput) : void
        {
            this.sellerId = param1.readInt();
            return;
        }// end function

    }
}
