package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeBidHouseInListUpdatedMessage extends ExchangeBidHouseInListAddedMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public static const protocolId:uint = 6337;

        public function ExchangeBidHouseInListUpdatedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6337;
        }// end function

        public function initExchangeBidHouseInListUpdatedMessage(param1:int = 0, param2:int = 0, param3:int = 0, param4:Boolean = false, param5:Vector.<ObjectEffect> = null, param6:Vector.<uint> = null) : ExchangeBidHouseInListUpdatedMessage
        {
            super.initExchangeBidHouseInListAddedMessage(param1, param2, param3, param4, param5, param6);
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
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
            this.serializeAs_ExchangeBidHouseInListUpdatedMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeBidHouseInListUpdatedMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ExchangeBidHouseInListAddedMessage(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeBidHouseInListUpdatedMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeBidHouseInListUpdatedMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            return;
        }// end function

    }
}
