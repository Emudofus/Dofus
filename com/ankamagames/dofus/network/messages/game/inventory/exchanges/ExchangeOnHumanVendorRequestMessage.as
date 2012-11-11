package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeOnHumanVendorRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var humanVendorId:uint = 0;
        public var humanVendorCell:uint = 0;
        public static const protocolId:uint = 5772;

        public function ExchangeOnHumanVendorRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5772;
        }// end function

        public function initExchangeOnHumanVendorRequestMessage(param1:uint = 0, param2:uint = 0) : ExchangeOnHumanVendorRequestMessage
        {
            this.humanVendorId = param1;
            this.humanVendorCell = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.humanVendorId = 0;
            this.humanVendorCell = 0;
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
            this.serializeAs_ExchangeOnHumanVendorRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeOnHumanVendorRequestMessage(param1:IDataOutput) : void
        {
            if (this.humanVendorId < 0)
            {
                throw new Error("Forbidden value (" + this.humanVendorId + ") on element humanVendorId.");
            }
            param1.writeInt(this.humanVendorId);
            if (this.humanVendorCell < 0)
            {
                throw new Error("Forbidden value (" + this.humanVendorCell + ") on element humanVendorCell.");
            }
            param1.writeInt(this.humanVendorCell);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeOnHumanVendorRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeOnHumanVendorRequestMessage(param1:IDataInput) : void
        {
            this.humanVendorId = param1.readInt();
            if (this.humanVendorId < 0)
            {
                throw new Error("Forbidden value (" + this.humanVendorId + ") on element of ExchangeOnHumanVendorRequestMessage.humanVendorId.");
            }
            this.humanVendorCell = param1.readInt();
            if (this.humanVendorCell < 0)
            {
                throw new Error("Forbidden value (" + this.humanVendorCell + ") on element of ExchangeOnHumanVendorRequestMessage.humanVendorCell.");
            }
            return;
        }// end function

    }
}
