package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeBidHouseBuyResultMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var uid:uint = 0;
        public var bought:Boolean = false;
        public static const protocolId:uint = 6272;

        public function ExchangeBidHouseBuyResultMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6272;
        }// end function

        public function initExchangeBidHouseBuyResultMessage(param1:uint = 0, param2:Boolean = false) : ExchangeBidHouseBuyResultMessage
        {
            this.uid = param1;
            this.bought = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.uid = 0;
            this.bought = false;
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
            this.serializeAs_ExchangeBidHouseBuyResultMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeBidHouseBuyResultMessage(param1:IDataOutput) : void
        {
            if (this.uid < 0)
            {
                throw new Error("Forbidden value (" + this.uid + ") on element uid.");
            }
            param1.writeInt(this.uid);
            param1.writeBoolean(this.bought);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeBidHouseBuyResultMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeBidHouseBuyResultMessage(param1:IDataInput) : void
        {
            this.uid = param1.readInt();
            if (this.uid < 0)
            {
                throw new Error("Forbidden value (" + this.uid + ") on element of ExchangeBidHouseBuyResultMessage.uid.");
            }
            this.bought = param1.readBoolean();
            return;
        }// end function

    }
}
