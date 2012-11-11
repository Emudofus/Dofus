package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PrismBalanceResultMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var totalBalanceValue:uint = 0;
        public var subAreaBalanceValue:uint = 0;
        public static const protocolId:uint = 5841;

        public function PrismBalanceResultMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5841;
        }// end function

        public function initPrismBalanceResultMessage(param1:uint = 0, param2:uint = 0) : PrismBalanceResultMessage
        {
            this.totalBalanceValue = param1;
            this.subAreaBalanceValue = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.totalBalanceValue = 0;
            this.subAreaBalanceValue = 0;
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
            this.serializeAs_PrismBalanceResultMessage(param1);
            return;
        }// end function

        public function serializeAs_PrismBalanceResultMessage(param1:IDataOutput) : void
        {
            if (this.totalBalanceValue < 0)
            {
                throw new Error("Forbidden value (" + this.totalBalanceValue + ") on element totalBalanceValue.");
            }
            param1.writeByte(this.totalBalanceValue);
            if (this.subAreaBalanceValue < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaBalanceValue + ") on element subAreaBalanceValue.");
            }
            param1.writeByte(this.subAreaBalanceValue);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PrismBalanceResultMessage(param1);
            return;
        }// end function

        public function deserializeAs_PrismBalanceResultMessage(param1:IDataInput) : void
        {
            this.totalBalanceValue = param1.readByte();
            if (this.totalBalanceValue < 0)
            {
                throw new Error("Forbidden value (" + this.totalBalanceValue + ") on element of PrismBalanceResultMessage.totalBalanceValue.");
            }
            this.subAreaBalanceValue = param1.readByte();
            if (this.subAreaBalanceValue < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaBalanceValue + ") on element of PrismBalanceResultMessage.subAreaBalanceValue.");
            }
            return;
        }// end function

    }
}
