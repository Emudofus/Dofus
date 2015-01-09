package com.ankamagames.dofus.network.types.game.house
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class HouseInformationsForGuild implements INetworkType 
    {

        public static const protocolId:uint = 170;

        public var houseId:uint = 0;
        public var modelId:uint = 0;
        public var ownerName:String = "";
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var mapId:int = 0;
        public var subAreaId:uint = 0;
        public var skillListIds:Vector.<int>;
        public var guildshareParams:uint = 0;

        public function HouseInformationsForGuild()
        {
            this.skillListIds = new Vector.<int>();
            super();
        }

        public function getTypeId():uint
        {
            return (170);
        }

        public function initHouseInformationsForGuild(houseId:uint=0, modelId:uint=0, ownerName:String="", worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0, skillListIds:Vector.<int>=null, guildshareParams:uint=0):HouseInformationsForGuild
        {
            this.houseId = houseId;
            this.modelId = modelId;
            this.ownerName = ownerName;
            this.worldX = worldX;
            this.worldY = worldY;
            this.mapId = mapId;
            this.subAreaId = subAreaId;
            this.skillListIds = skillListIds;
            this.guildshareParams = guildshareParams;
            return (this);
        }

        public function reset():void
        {
            this.houseId = 0;
            this.modelId = 0;
            this.ownerName = "";
            this.worldX = 0;
            this.worldY = 0;
            this.mapId = 0;
            this.subAreaId = 0;
            this.skillListIds = new Vector.<int>();
            this.guildshareParams = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_HouseInformationsForGuild(output);
        }

        public function serializeAs_HouseInformationsForGuild(output:ICustomDataOutput):void
        {
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element houseId.")));
            };
            output.writeInt(this.houseId);
            if (this.modelId < 0)
            {
                throw (new Error((("Forbidden value (" + this.modelId) + ") on element modelId.")));
            };
            output.writeVarInt(this.modelId);
            output.writeUTF(this.ownerName);
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element worldX.")));
            };
            output.writeShort(this.worldX);
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element worldY.")));
            };
            output.writeShort(this.worldY);
            output.writeInt(this.mapId);
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element subAreaId.")));
            };
            output.writeVarShort(this.subAreaId);
            output.writeShort(this.skillListIds.length);
            var _i8:uint;
            while (_i8 < this.skillListIds.length)
            {
                output.writeInt(this.skillListIds[_i8]);
                _i8++;
            };
            if (this.guildshareParams < 0)
            {
                throw (new Error((("Forbidden value (" + this.guildshareParams) + ") on element guildshareParams.")));
            };
            output.writeVarInt(this.guildshareParams);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HouseInformationsForGuild(input);
        }

        public function deserializeAs_HouseInformationsForGuild(input:ICustomDataInput):void
        {
            var _val8:int;
            this.houseId = input.readInt();
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element of HouseInformationsForGuild.houseId.")));
            };
            this.modelId = input.readVarUhInt();
            if (this.modelId < 0)
            {
                throw (new Error((("Forbidden value (" + this.modelId) + ") on element of HouseInformationsForGuild.modelId.")));
            };
            this.ownerName = input.readUTF();
            this.worldX = input.readShort();
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element of HouseInformationsForGuild.worldX.")));
            };
            this.worldY = input.readShort();
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element of HouseInformationsForGuild.worldY.")));
            };
            this.mapId = input.readInt();
            this.subAreaId = input.readVarUhShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of HouseInformationsForGuild.subAreaId.")));
            };
            var _skillListIdsLen:uint = input.readUnsignedShort();
            var _i8:uint;
            while (_i8 < _skillListIdsLen)
            {
                _val8 = input.readInt();
                this.skillListIds.push(_val8);
                _i8++;
            };
            this.guildshareParams = input.readVarUhInt();
            if (this.guildshareParams < 0)
            {
                throw (new Error((("Forbidden value (" + this.guildshareParams) + ") on element of HouseInformationsForGuild.guildshareParams.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.house

