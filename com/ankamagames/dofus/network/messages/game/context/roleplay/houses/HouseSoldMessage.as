package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HouseSoldMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var houseId:uint = 0;
        public var realPrice:uint = 0;
        public var buyerName:String = "";
        public static const protocolId:uint = 5737;

        public function HouseSoldMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5737;
        }// end function

        public function initHouseSoldMessage(param1:uint = 0, param2:uint = 0, param3:String = "") : HouseSoldMessage
        {
            this.houseId = param1;
            this.realPrice = param2;
            this.buyerName = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.houseId = 0;
            this.realPrice = 0;
            this.buyerName = "";
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
            this.serializeAs_HouseSoldMessage(param1);
            return;
        }// end function

        public function serializeAs_HouseSoldMessage(param1:IDataOutput) : void
        {
            if (this.houseId < 0)
            {
                throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
            }
            param1.writeInt(this.houseId);
            if (this.realPrice < 0)
            {
                throw new Error("Forbidden value (" + this.realPrice + ") on element realPrice.");
            }
            param1.writeInt(this.realPrice);
            param1.writeUTF(this.buyerName);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HouseSoldMessage(param1);
            return;
        }// end function

        public function deserializeAs_HouseSoldMessage(param1:IDataInput) : void
        {
            this.houseId = param1.readInt();
            if (this.houseId < 0)
            {
                throw new Error("Forbidden value (" + this.houseId + ") on element of HouseSoldMessage.houseId.");
            }
            this.realPrice = param1.readInt();
            if (this.realPrice < 0)
            {
                throw new Error("Forbidden value (" + this.realPrice + ") on element of HouseSoldMessage.realPrice.");
            }
            this.buyerName = param1.readUTF();
            return;
        }// end function

    }
}
