package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangePlayerRequestMessage extends ExchangeRequestMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var target:uint = 0;
        public static const protocolId:uint = 5773;

        public function ExchangePlayerRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5773;
        }// end function

        public function initExchangePlayerRequestMessage(param1:int = 0, param2:uint = 0) : ExchangePlayerRequestMessage
        {
            super.initExchangeRequestMessage(param1);
            this.target = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.target = 0;
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
            this.serializeAs_ExchangePlayerRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangePlayerRequestMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ExchangeRequestMessage(param1);
            if (this.target < 0)
            {
                throw new Error("Forbidden value (" + this.target + ") on element target.");
            }
            param1.writeInt(this.target);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangePlayerRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangePlayerRequestMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.target = param1.readInt();
            if (this.target < 0)
            {
                throw new Error("Forbidden value (" + this.target + ") on element of ExchangePlayerRequestMessage.target.");
            }
            return;
        }// end function

    }
}
