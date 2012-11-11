package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeCraftResultMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var craftResult:uint = 0;
        public static const protocolId:uint = 5790;

        public function ExchangeCraftResultMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5790;
        }// end function

        public function initExchangeCraftResultMessage(param1:uint = 0) : ExchangeCraftResultMessage
        {
            this.craftResult = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.craftResult = 0;
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
            this.serializeAs_ExchangeCraftResultMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeCraftResultMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.craftResult);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeCraftResultMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeCraftResultMessage(param1:IDataInput) : void
        {
            this.craftResult = param1.readByte();
            if (this.craftResult < 0)
            {
                throw new Error("Forbidden value (" + this.craftResult + ") on element of ExchangeCraftResultMessage.craftResult.");
            }
            return;
        }// end function

    }
}
