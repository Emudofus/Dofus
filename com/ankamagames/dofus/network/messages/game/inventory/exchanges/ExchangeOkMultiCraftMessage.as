package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeOkMultiCraftMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var initiatorId:uint = 0;
        public var otherId:uint = 0;
        public var role:int = 0;
        public static const protocolId:uint = 5768;

        public function ExchangeOkMultiCraftMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5768;
        }// end function

        public function initExchangeOkMultiCraftMessage(param1:uint = 0, param2:uint = 0, param3:int = 0) : ExchangeOkMultiCraftMessage
        {
            this.initiatorId = param1;
            this.otherId = param2;
            this.role = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.initiatorId = 0;
            this.otherId = 0;
            this.role = 0;
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
            this.serializeAs_ExchangeOkMultiCraftMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeOkMultiCraftMessage(param1:IDataOutput) : void
        {
            if (this.initiatorId < 0)
            {
                throw new Error("Forbidden value (" + this.initiatorId + ") on element initiatorId.");
            }
            param1.writeInt(this.initiatorId);
            if (this.otherId < 0)
            {
                throw new Error("Forbidden value (" + this.otherId + ") on element otherId.");
            }
            param1.writeInt(this.otherId);
            param1.writeByte(this.role);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeOkMultiCraftMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeOkMultiCraftMessage(param1:IDataInput) : void
        {
            this.initiatorId = param1.readInt();
            if (this.initiatorId < 0)
            {
                throw new Error("Forbidden value (" + this.initiatorId + ") on element of ExchangeOkMultiCraftMessage.initiatorId.");
            }
            this.otherId = param1.readInt();
            if (this.otherId < 0)
            {
                throw new Error("Forbidden value (" + this.otherId + ") on element of ExchangeOkMultiCraftMessage.otherId.");
            }
            this.role = param1.readByte();
            return;
        }// end function

    }
}
