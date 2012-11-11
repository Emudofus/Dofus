package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeErrorMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var errorType:int = 0;
        public static const protocolId:uint = 5513;

        public function ExchangeErrorMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5513;
        }// end function

        public function initExchangeErrorMessage(param1:int = 0) : ExchangeErrorMessage
        {
            this.errorType = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.errorType = 0;
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
            this.serializeAs_ExchangeErrorMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeErrorMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.errorType);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeErrorMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeErrorMessage(param1:IDataInput) : void
        {
            this.errorType = param1.readByte();
            return;
        }// end function

    }
}
