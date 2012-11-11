package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HouseBuyResultMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var houseId:uint = 0;
        public var bought:Boolean = false;
        public var realPrice:uint = 0;
        public static const protocolId:uint = 5735;

        public function HouseBuyResultMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5735;
        }// end function

        public function initHouseBuyResultMessage(param1:uint = 0, param2:Boolean = false, param3:uint = 0) : HouseBuyResultMessage
        {
            this.houseId = param1;
            this.bought = param2;
            this.realPrice = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.houseId = 0;
            this.bought = false;
            this.realPrice = 0;
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
            this.serializeAs_HouseBuyResultMessage(param1);
            return;
        }// end function

        public function serializeAs_HouseBuyResultMessage(param1:IDataOutput) : void
        {
            if (this.houseId < 0)
            {
                throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
            }
            param1.writeInt(this.houseId);
            param1.writeBoolean(this.bought);
            if (this.realPrice < 0)
            {
                throw new Error("Forbidden value (" + this.realPrice + ") on element realPrice.");
            }
            param1.writeInt(this.realPrice);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HouseBuyResultMessage(param1);
            return;
        }// end function

        public function deserializeAs_HouseBuyResultMessage(param1:IDataInput) : void
        {
            this.houseId = param1.readInt();
            if (this.houseId < 0)
            {
                throw new Error("Forbidden value (" + this.houseId + ") on element of HouseBuyResultMessage.houseId.");
            }
            this.bought = param1.readBoolean();
            this.realPrice = param1.readInt();
            if (this.realPrice < 0)
            {
                throw new Error("Forbidden value (" + this.realPrice + ") on element of HouseBuyResultMessage.realPrice.");
            }
            return;
        }// end function

    }
}
