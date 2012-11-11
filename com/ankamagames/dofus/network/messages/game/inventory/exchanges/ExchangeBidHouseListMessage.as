package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeBidHouseListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var id:uint = 0;
        public static const protocolId:uint = 5807;

        public function ExchangeBidHouseListMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5807;
        }// end function

        public function initExchangeBidHouseListMessage(param1:uint = 0) : ExchangeBidHouseListMessage
        {
            this.id = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.id = 0;
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
            this.serializeAs_ExchangeBidHouseListMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeBidHouseListMessage(param1:IDataOutput) : void
        {
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element id.");
            }
            param1.writeInt(this.id);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeBidHouseListMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeBidHouseListMessage(param1:IDataInput) : void
        {
            this.id = param1.readInt();
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element of ExchangeBidHouseListMessage.id.");
            }
            return;
        }// end function

    }
}
