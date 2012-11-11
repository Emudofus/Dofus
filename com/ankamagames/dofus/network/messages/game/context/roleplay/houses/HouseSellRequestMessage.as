package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HouseSellRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var amount:uint = 0;
        public static const protocolId:uint = 5697;

        public function HouseSellRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5697;
        }// end function

        public function initHouseSellRequestMessage(param1:uint = 0) : HouseSellRequestMessage
        {
            this.amount = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.amount = 0;
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
            this.serializeAs_HouseSellRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_HouseSellRequestMessage(param1:IDataOutput) : void
        {
            if (this.amount < 0)
            {
                throw new Error("Forbidden value (" + this.amount + ") on element amount.");
            }
            param1.writeInt(this.amount);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HouseSellRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_HouseSellRequestMessage(param1:IDataInput) : void
        {
            this.amount = param1.readInt();
            if (this.amount < 0)
            {
                throw new Error("Forbidden value (" + this.amount + ") on element of HouseSellRequestMessage.amount.");
            }
            return;
        }// end function

    }
}
