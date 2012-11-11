package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangePlayerMultiCraftRequestMessage extends ExchangeRequestMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var target:uint = 0;
        public var skillId:uint = 0;
        public static const protocolId:uint = 5784;

        public function ExchangePlayerMultiCraftRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5784;
        }// end function

        public function initExchangePlayerMultiCraftRequestMessage(param1:int = 0, param2:uint = 0, param3:uint = 0) : ExchangePlayerMultiCraftRequestMessage
        {
            super.initExchangeRequestMessage(param1);
            this.target = param2;
            this.skillId = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.target = 0;
            this.skillId = 0;
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
            this.serializeAs_ExchangePlayerMultiCraftRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangePlayerMultiCraftRequestMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ExchangeRequestMessage(param1);
            if (this.target < 0)
            {
                throw new Error("Forbidden value (" + this.target + ") on element target.");
            }
            param1.writeInt(this.target);
            if (this.skillId < 0)
            {
                throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
            }
            param1.writeInt(this.skillId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangePlayerMultiCraftRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangePlayerMultiCraftRequestMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.target = param1.readInt();
            if (this.target < 0)
            {
                throw new Error("Forbidden value (" + this.target + ") on element of ExchangePlayerMultiCraftRequestMessage.target.");
            }
            this.skillId = param1.readInt();
            if (this.skillId < 0)
            {
                throw new Error("Forbidden value (" + this.skillId + ") on element of ExchangePlayerMultiCraftRequestMessage.skillId.");
            }
            return;
        }// end function

    }
}
