package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PaddockSellRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var price:uint = 0;
        public static const protocolId:uint = 5953;

        public function PaddockSellRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5953;
        }// end function

        public function initPaddockSellRequestMessage(param1:uint = 0) : PaddockSellRequestMessage
        {
            this.price = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
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
            this.serializeAs_PaddockSellRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_PaddockSellRequestMessage(param1:IDataOutput) : void
        {
            if (this.price < 0)
            {
                throw new Error("Forbidden value (" + this.price + ") on element price.");
            }
            param1.writeInt(this.price);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PaddockSellRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_PaddockSellRequestMessage(param1:IDataInput) : void
        {
            this.price = param1.readInt();
            if (this.price < 0)
            {
                throw new Error("Forbidden value (" + this.price + ") on element of PaddockSellRequestMessage.price.");
            }
            return;
        }// end function

    }
}
