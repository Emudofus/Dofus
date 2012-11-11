package com.ankamagames.dofus.network.types.game.house
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HouseInformationsForSell extends Object implements INetworkType
    {
        public var modelId:uint = 0;
        public var ownerName:String = "";
        public var ownerConnected:Boolean = false;
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var subAreaId:uint = 0;
        public var nbRoom:int = 0;
        public var nbChest:int = 0;
        public var skillListIds:Vector.<int>;
        public var isLocked:Boolean = false;
        public var price:uint = 0;
        public static const protocolId:uint = 221;

        public function HouseInformationsForSell()
        {
            this.skillListIds = new Vector.<int>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 221;
        }// end function

        public function initHouseInformationsForSell(param1:uint = 0, param2:String = "", param3:Boolean = false, param4:int = 0, param5:int = 0, param6:uint = 0, param7:int = 0, param8:int = 0, param9:Vector.<int> = null, param10:Boolean = false, param11:uint = 0) : HouseInformationsForSell
        {
            this.modelId = param1;
            this.ownerName = param2;
            this.ownerConnected = param3;
            this.worldX = param4;
            this.worldY = param5;
            this.subAreaId = param6;
            this.nbRoom = param7;
            this.nbChest = param8;
            this.skillListIds = param9;
            this.isLocked = param10;
            this.price = param11;
            return this;
        }// end function

        public function reset() : void
        {
            this.modelId = 0;
            this.ownerName = "";
            this.ownerConnected = false;
            this.worldX = 0;
            this.worldY = 0;
            this.subAreaId = 0;
            this.nbRoom = 0;
            this.nbChest = 0;
            this.skillListIds = new Vector.<int>;
            this.isLocked = false;
            this.price = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_HouseInformationsForSell(param1);
            return;
        }// end function

        public function serializeAs_HouseInformationsForSell(param1:IDataOutput) : void
        {
            if (this.modelId < 0)
            {
                throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
            }
            param1.writeInt(this.modelId);
            param1.writeUTF(this.ownerName);
            param1.writeBoolean(this.ownerConnected);
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
            }
            param1.writeShort(this.worldX);
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
            }
            param1.writeShort(this.worldY);
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
            }
            param1.writeShort(this.subAreaId);
            param1.writeByte(this.nbRoom);
            param1.writeByte(this.nbChest);
            param1.writeShort(this.skillListIds.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.skillListIds.length)
            {
                
                param1.writeInt(this.skillListIds[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeBoolean(this.isLocked);
            if (this.price < 0)
            {
                throw new Error("Forbidden value (" + this.price + ") on element price.");
            }
            param1.writeInt(this.price);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HouseInformationsForSell(param1);
            return;
        }// end function

        public function deserializeAs_HouseInformationsForSell(param1:IDataInput) : void
        {
            var _loc_4:* = 0;
            this.modelId = param1.readInt();
            if (this.modelId < 0)
            {
                throw new Error("Forbidden value (" + this.modelId + ") on element of HouseInformationsForSell.modelId.");
            }
            this.ownerName = param1.readUTF();
            this.ownerConnected = param1.readBoolean();
            this.worldX = param1.readShort();
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element of HouseInformationsForSell.worldX.");
            }
            this.worldY = param1.readShort();
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element of HouseInformationsForSell.worldY.");
            }
            this.subAreaId = param1.readShort();
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element of HouseInformationsForSell.subAreaId.");
            }
            this.nbRoom = param1.readByte();
            this.nbChest = param1.readByte();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readInt();
                this.skillListIds.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            this.isLocked = param1.readBoolean();
            this.price = param1.readInt();
            if (this.price < 0)
            {
                throw new Error("Forbidden value (" + this.price + ") on element of HouseInformationsForSell.price.");
            }
            return;
        }// end function

    }
}
