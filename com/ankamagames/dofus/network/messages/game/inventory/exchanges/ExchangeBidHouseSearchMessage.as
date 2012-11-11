package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeBidHouseSearchMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var type:uint = 0;
        public var genId:uint = 0;
        public static const protocolId:uint = 5806;

        public function ExchangeBidHouseSearchMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5806;
        }// end function

        public function initExchangeBidHouseSearchMessage(param1:uint = 0, param2:uint = 0) : ExchangeBidHouseSearchMessage
        {
            this.type = param1;
            this.genId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.type = 0;
            this.genId = 0;
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
            this.serializeAs_ExchangeBidHouseSearchMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeBidHouseSearchMessage(param1:IDataOutput) : void
        {
            if (this.type < 0)
            {
                throw new Error("Forbidden value (" + this.type + ") on element type.");
            }
            param1.writeInt(this.type);
            if (this.genId < 0)
            {
                throw new Error("Forbidden value (" + this.genId + ") on element genId.");
            }
            param1.writeInt(this.genId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeBidHouseSearchMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeBidHouseSearchMessage(param1:IDataInput) : void
        {
            this.type = param1.readInt();
            if (this.type < 0)
            {
                throw new Error("Forbidden value (" + this.type + ") on element of ExchangeBidHouseSearchMessage.type.");
            }
            this.genId = param1.readInt();
            if (this.genId < 0)
            {
                throw new Error("Forbidden value (" + this.genId + ") on element of ExchangeBidHouseSearchMessage.genId.");
            }
            return;
        }// end function

    }
}
