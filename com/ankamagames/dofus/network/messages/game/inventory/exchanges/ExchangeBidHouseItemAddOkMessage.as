package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeBidHouseItemAddOkMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var itemInfo:ObjectItemToSellInBid;
        public static const protocolId:uint = 5945;

        public function ExchangeBidHouseItemAddOkMessage()
        {
            this.itemInfo = new ObjectItemToSellInBid();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5945;
        }// end function

        public function initExchangeBidHouseItemAddOkMessage(param1:ObjectItemToSellInBid = null) : ExchangeBidHouseItemAddOkMessage
        {
            this.itemInfo = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.itemInfo = new ObjectItemToSellInBid();
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
            this.serializeAs_ExchangeBidHouseItemAddOkMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeBidHouseItemAddOkMessage(param1:IDataOutput) : void
        {
            this.itemInfo.serializeAs_ObjectItemToSellInBid(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeBidHouseItemAddOkMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeBidHouseItemAddOkMessage(param1:IDataInput) : void
        {
            this.itemInfo = new ObjectItemToSellInBid();
            this.itemInfo.deserialize(param1);
            return;
        }// end function

    }
}
