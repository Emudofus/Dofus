package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeBidHouseBuyMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var uid:uint = 0;
        public var qty:uint = 0;
        public var price:uint = 0;
        public static const protocolId:uint = 5804;

        public function ExchangeBidHouseBuyMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5804;
        }// end function

        public function initExchangeBidHouseBuyMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : ExchangeBidHouseBuyMessage
        {
            this.uid = param1;
            this.qty = param2;
            this.price = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.uid = 0;
            this.qty = 0;
            this.price = 0;
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
            this.serializeAs_ExchangeBidHouseBuyMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeBidHouseBuyMessage(param1:IDataOutput) : void
        {
            if (this.uid < 0)
            {
                throw new Error("Forbidden value (" + this.uid + ") on element uid.");
            }
            param1.writeInt(this.uid);
            if (this.qty < 0)
            {
                throw new Error("Forbidden value (" + this.qty + ") on element qty.");
            }
            param1.writeInt(this.qty);
            if (this.price < 0)
            {
                throw new Error("Forbidden value (" + this.price + ") on element price.");
            }
            param1.writeInt(this.price);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeBidHouseBuyMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeBidHouseBuyMessage(param1:IDataInput) : void
        {
            this.uid = param1.readInt();
            if (this.uid < 0)
            {
                throw new Error("Forbidden value (" + this.uid + ") on element of ExchangeBidHouseBuyMessage.uid.");
            }
            this.qty = param1.readInt();
            if (this.qty < 0)
            {
                throw new Error("Forbidden value (" + this.qty + ") on element of ExchangeBidHouseBuyMessage.qty.");
            }
            this.price = param1.readInt();
            if (this.price < 0)
            {
                throw new Error("Forbidden value (" + this.price + ") on element of ExchangeBidHouseBuyMessage.price.");
            }
            return;
        }// end function

    }
}
