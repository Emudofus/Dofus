package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeReadyMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var ready:Boolean = false;
        public var step:uint = 0;
        public static const protocolId:uint = 5511;

        public function ExchangeReadyMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5511;
        }// end function

        public function initExchangeReadyMessage(param1:Boolean = false, param2:uint = 0) : ExchangeReadyMessage
        {
            this.ready = param1;
            this.step = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.ready = false;
            this.step = 0;
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
            this.serializeAs_ExchangeReadyMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeReadyMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.ready);
            if (this.step < 0)
            {
                throw new Error("Forbidden value (" + this.step + ") on element step.");
            }
            param1.writeShort(this.step);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeReadyMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeReadyMessage(param1:IDataInput) : void
        {
            this.ready = param1.readBoolean();
            this.step = param1.readShort();
            if (this.step < 0)
            {
                throw new Error("Forbidden value (" + this.step + ") on element of ExchangeReadyMessage.step.");
            }
            return;
        }// end function

    }
}
