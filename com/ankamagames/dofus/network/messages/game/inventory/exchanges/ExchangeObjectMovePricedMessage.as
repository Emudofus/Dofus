package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeObjectMovePricedMessage extends ExchangeObjectMoveMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var price:int = 0;
        public static const protocolId:uint = 5514;

        public function ExchangeObjectMovePricedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5514;
        }// end function

        public function initExchangeObjectMovePricedMessage(param1:uint = 0, param2:int = 0, param3:int = 0) : ExchangeObjectMovePricedMessage
        {
            super.initExchangeObjectMoveMessage(param1, param2);
            this.price = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.price = 0;
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
            this.serializeAs_ExchangeObjectMovePricedMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeObjectMovePricedMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ExchangeObjectMoveMessage(param1);
            param1.writeInt(this.price);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeObjectMovePricedMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeObjectMovePricedMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.price = param1.readInt();
            return;
        }// end function

    }
}
