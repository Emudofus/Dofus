package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeObjectModifyPricedMessage extends ExchangeObjectMovePricedMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public static const protocolId:uint = 6238;

        public function ExchangeObjectModifyPricedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6238;
        }// end function

        public function initExchangeObjectModifyPricedMessage(param1:uint = 0, param2:int = 0, param3:int = 0) : ExchangeObjectModifyPricedMessage
        {
            super.initExchangeObjectMovePricedMessage(param1, param2, param3);
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
            this.serializeAs_ExchangeObjectModifyPricedMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeObjectModifyPricedMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ExchangeObjectMovePricedMessage(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeObjectModifyPricedMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeObjectModifyPricedMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            return;
        }// end function

    }
}
