package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeBidHouseTypeMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var type:uint = 0;
        public static const protocolId:uint = 5803;

        public function ExchangeBidHouseTypeMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5803;
        }// end function

        public function initExchangeBidHouseTypeMessage(param1:uint = 0) : ExchangeBidHouseTypeMessage
        {
            this.type = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.type = 0;
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
            this.serializeAs_ExchangeBidHouseTypeMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeBidHouseTypeMessage(param1:IDataOutput) : void
        {
            if (this.type < 0)
            {
                throw new Error("Forbidden value (" + this.type + ") on element type.");
            }
            param1.writeInt(this.type);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeBidHouseTypeMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeBidHouseTypeMessage(param1:IDataInput) : void
        {
            this.type = param1.readInt();
            if (this.type < 0)
            {
                throw new Error("Forbidden value (" + this.type + ") on element of ExchangeBidHouseTypeMessage.type.");
            }
            return;
        }// end function

    }
}
