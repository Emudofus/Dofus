package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeCraftResultWithObjectIdMessage extends ExchangeCraftResultMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var objectGenericId:uint = 0;
        public static const protocolId:uint = 6000;

        public function ExchangeCraftResultWithObjectIdMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6000;
        }// end function

        public function initExchangeCraftResultWithObjectIdMessage(param1:uint = 0, param2:uint = 0) : ExchangeCraftResultWithObjectIdMessage
        {
            super.initExchangeCraftResultMessage(param1);
            this.objectGenericId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.objectGenericId = 0;
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
            this.serializeAs_ExchangeCraftResultWithObjectIdMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeCraftResultWithObjectIdMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ExchangeCraftResultMessage(param1);
            if (this.objectGenericId < 0)
            {
                throw new Error("Forbidden value (" + this.objectGenericId + ") on element objectGenericId.");
            }
            param1.writeInt(this.objectGenericId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeCraftResultWithObjectIdMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeCraftResultWithObjectIdMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.objectGenericId = param1.readInt();
            if (this.objectGenericId < 0)
            {
                throw new Error("Forbidden value (" + this.objectGenericId + ") on element of ExchangeCraftResultWithObjectIdMessage.objectGenericId.");
            }
            return;
        }// end function

    }
}
