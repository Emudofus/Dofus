package com.ankamagames.dofus.network.types.game.house
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HouseInformationsForGuild extends Object implements INetworkType
    {
        public var houseId:uint = 0;
        public var modelId:uint = 0;
        public var ownerName:String = "";
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var skillListIds:Vector.<int>;
        public var guildshareParams:uint = 0;
        public static const protocolId:uint = 170;

        public function HouseInformationsForGuild()
        {
            this.skillListIds = new Vector.<int>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 170;
        }// end function

        public function initHouseInformationsForGuild(param1:uint = 0, param2:uint = 0, param3:String = "", param4:int = 0, param5:int = 0, param6:Vector.<int> = null, param7:uint = 0) : HouseInformationsForGuild
        {
            this.houseId = param1;
            this.modelId = param2;
            this.ownerName = param3;
            this.worldX = param4;
            this.worldY = param5;
            this.skillListIds = param6;
            this.guildshareParams = param7;
            return this;
        }// end function

        public function reset() : void
        {
            this.houseId = 0;
            this.modelId = 0;
            this.ownerName = "";
            this.worldX = 0;
            this.worldY = 0;
            this.skillListIds = new Vector.<int>;
            this.guildshareParams = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_HouseInformationsForGuild(param1);
            return;
        }// end function

        public function serializeAs_HouseInformationsForGuild(param1:IDataOutput) : void
        {
            if (this.houseId < 0)
            {
                throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
            }
            param1.writeInt(this.houseId);
            if (this.modelId < 0)
            {
                throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
            }
            param1.writeInt(this.modelId);
            param1.writeUTF(this.ownerName);
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
            param1.writeShort(this.skillListIds.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.skillListIds.length)
            {
                
                param1.writeInt(this.skillListIds[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            if (this.guildshareParams < 0 || this.guildshareParams > 4294967295)
            {
                throw new Error("Forbidden value (" + this.guildshareParams + ") on element guildshareParams.");
            }
            param1.writeUnsignedInt(this.guildshareParams);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HouseInformationsForGuild(param1);
            return;
        }// end function

        public function deserializeAs_HouseInformationsForGuild(param1:IDataInput) : void
        {
            var _loc_4:int = 0;
            this.houseId = param1.readInt();
            if (this.houseId < 0)
            {
                throw new Error("Forbidden value (" + this.houseId + ") on element of HouseInformationsForGuild.houseId.");
            }
            this.modelId = param1.readInt();
            if (this.modelId < 0)
            {
                throw new Error("Forbidden value (" + this.modelId + ") on element of HouseInformationsForGuild.modelId.");
            }
            this.ownerName = param1.readUTF();
            this.worldX = param1.readShort();
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element of HouseInformationsForGuild.worldX.");
            }
            this.worldY = param1.readShort();
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element of HouseInformationsForGuild.worldY.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readInt();
                this.skillListIds.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            this.guildshareParams = param1.readUnsignedInt();
            if (this.guildshareParams < 0 || this.guildshareParams > 4294967295)
            {
                throw new Error("Forbidden value (" + this.guildshareParams + ") on element of HouseInformationsForGuild.guildshareParams.");
            }
            return;
        }// end function

    }
}
