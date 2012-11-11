package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeKamaModifiedMessage extends ExchangeObjectMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var quantity:uint = 0;
        public static const protocolId:uint = 5521;

        public function ExchangeKamaModifiedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5521;
        }// end function

        public function initExchangeKamaModifiedMessage(param1:Boolean = false, param2:uint = 0) : ExchangeKamaModifiedMessage
        {
            super.initExchangeObjectMessage(param1);
            this.quantity = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.quantity = 0;
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
            this.serializeAs_ExchangeKamaModifiedMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeKamaModifiedMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ExchangeObjectMessage(param1);
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            param1.writeInt(this.quantity);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeKamaModifiedMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeKamaModifiedMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.quantity = param1.readInt();
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element of ExchangeKamaModifiedMessage.quantity.");
            }
            return;
        }// end function

    }
}
