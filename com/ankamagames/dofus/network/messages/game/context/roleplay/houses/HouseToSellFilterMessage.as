package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HouseToSellFilterMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var areaId:int = 0;
        public var atLeastNbRoom:uint = 0;
        public var atLeastNbChest:uint = 0;
        public var skillRequested:uint = 0;
        public var maxPrice:uint = 0;
        public static const protocolId:uint = 6137;

        public function HouseToSellFilterMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6137;
        }// end function

        public function initHouseToSellFilterMessage(param1:int = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0) : HouseToSellFilterMessage
        {
            this.areaId = param1;
            this.atLeastNbRoom = param2;
            this.atLeastNbChest = param3;
            this.skillRequested = param4;
            this.maxPrice = param5;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.areaId = 0;
            this.atLeastNbRoom = 0;
            this.atLeastNbChest = 0;
            this.skillRequested = 0;
            this.maxPrice = 0;
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
            this.serializeAs_HouseToSellFilterMessage(param1);
            return;
        }// end function

        public function serializeAs_HouseToSellFilterMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.areaId);
            if (this.atLeastNbRoom < 0)
            {
                throw new Error("Forbidden value (" + this.atLeastNbRoom + ") on element atLeastNbRoom.");
            }
            param1.writeByte(this.atLeastNbRoom);
            if (this.atLeastNbChest < 0)
            {
                throw new Error("Forbidden value (" + this.atLeastNbChest + ") on element atLeastNbChest.");
            }
            param1.writeByte(this.atLeastNbChest);
            if (this.skillRequested < 0)
            {
                throw new Error("Forbidden value (" + this.skillRequested + ") on element skillRequested.");
            }
            param1.writeShort(this.skillRequested);
            if (this.maxPrice < 0)
            {
                throw new Error("Forbidden value (" + this.maxPrice + ") on element maxPrice.");
            }
            param1.writeInt(this.maxPrice);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HouseToSellFilterMessage(param1);
            return;
        }// end function

        public function deserializeAs_HouseToSellFilterMessage(param1:IDataInput) : void
        {
            this.areaId = param1.readInt();
            this.atLeastNbRoom = param1.readByte();
            if (this.atLeastNbRoom < 0)
            {
                throw new Error("Forbidden value (" + this.atLeastNbRoom + ") on element of HouseToSellFilterMessage.atLeastNbRoom.");
            }
            this.atLeastNbChest = param1.readByte();
            if (this.atLeastNbChest < 0)
            {
                throw new Error("Forbidden value (" + this.atLeastNbChest + ") on element of HouseToSellFilterMessage.atLeastNbChest.");
            }
            this.skillRequested = param1.readShort();
            if (this.skillRequested < 0)
            {
                throw new Error("Forbidden value (" + this.skillRequested + ") on element of HouseToSellFilterMessage.skillRequested.");
            }
            this.maxPrice = param1.readInt();
            if (this.maxPrice < 0)
            {
                throw new Error("Forbidden value (" + this.maxPrice + ") on element of HouseToSellFilterMessage.maxPrice.");
            }
            return;
        }// end function

    }
}
