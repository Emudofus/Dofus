package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HouseBuyRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var proposedPrice:uint = 0;
        public static const protocolId:uint = 5738;

        public function HouseBuyRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5738;
        }// end function

        public function initHouseBuyRequestMessage(param1:uint = 0) : HouseBuyRequestMessage
        {
            this.proposedPrice = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.proposedPrice = 0;
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
            this.serializeAs_HouseBuyRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_HouseBuyRequestMessage(param1:IDataOutput) : void
        {
            if (this.proposedPrice < 0)
            {
                throw new Error("Forbidden value (" + this.proposedPrice + ") on element proposedPrice.");
            }
            param1.writeInt(this.proposedPrice);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HouseBuyRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_HouseBuyRequestMessage(param1:IDataInput) : void
        {
            this.proposedPrice = param1.readInt();
            if (this.proposedPrice < 0)
            {
                throw new Error("Forbidden value (" + this.proposedPrice + ") on element of HouseBuyRequestMessage.proposedPrice.");
            }
            return;
        }// end function

    }
}
