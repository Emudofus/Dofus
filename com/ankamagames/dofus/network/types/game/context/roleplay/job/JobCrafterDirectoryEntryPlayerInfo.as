﻿package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.enums.PlayableBreedEnum;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    public class JobCrafterDirectoryEntryPlayerInfo implements INetworkType 
    {

        public static const protocolId:uint = 194;

        public var playerId:uint = 0;
        public var playerName:String = "";
        public var alignmentSide:int = 0;
        public var breed:int = 0;
        public var sex:Boolean = false;
        public var isInWorkshop:Boolean = false;
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var mapId:int = 0;
        public var subAreaId:uint = 0;
        public var status:PlayerStatus;

        public function JobCrafterDirectoryEntryPlayerInfo()
        {
            this.status = new PlayerStatus();
            super();
        }

        public function getTypeId():uint
        {
            return (194);
        }

        public function initJobCrafterDirectoryEntryPlayerInfo(playerId:uint=0, playerName:String="", alignmentSide:int=0, breed:int=0, sex:Boolean=false, isInWorkshop:Boolean=false, worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0, status:PlayerStatus=null):JobCrafterDirectoryEntryPlayerInfo
        {
            this.playerId = playerId;
            this.playerName = playerName;
            this.alignmentSide = alignmentSide;
            this.breed = breed;
            this.sex = sex;
            this.isInWorkshop = isInWorkshop;
            this.worldX = worldX;
            this.worldY = worldY;
            this.mapId = mapId;
            this.subAreaId = subAreaId;
            this.status = status;
            return (this);
        }

        public function reset():void
        {
            this.playerId = 0;
            this.playerName = "";
            this.alignmentSide = 0;
            this.breed = 0;
            this.sex = false;
            this.isInWorkshop = false;
            this.worldX = 0;
            this.worldY = 0;
            this.mapId = 0;
            this.subAreaId = 0;
            this.status = new PlayerStatus();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_JobCrafterDirectoryEntryPlayerInfo(output);
        }

        public function serializeAs_JobCrafterDirectoryEntryPlayerInfo(output:ICustomDataOutput):void
        {
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeVarInt(this.playerId);
            output.writeUTF(this.playerName);
            output.writeByte(this.alignmentSide);
            output.writeByte(this.breed);
            output.writeBoolean(this.sex);
            output.writeBoolean(this.isInWorkshop);
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
            output.writeShort(this.status.getTypeId());
            this.status.serialize(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_JobCrafterDirectoryEntryPlayerInfo(input);
        }

        public function deserializeAs_JobCrafterDirectoryEntryPlayerInfo(input:ICustomDataInput):void
        {
            this.playerId = input.readVarUhInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of JobCrafterDirectoryEntryPlayerInfo.playerId.")));
            };
            this.playerName = input.readUTF();
            this.alignmentSide = input.readByte();
            this.breed = input.readByte();
            if ((((this.breed < PlayableBreedEnum.Feca)) || ((this.breed > PlayableBreedEnum.Eliatrope))))
            {
                throw (new Error((("Forbidden value (" + this.breed) + ") on element of JobCrafterDirectoryEntryPlayerInfo.breed.")));
            };
            this.sex = input.readBoolean();
            this.isInWorkshop = input.readBoolean();
            this.worldX = input.readShort();
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element of JobCrafterDirectoryEntryPlayerInfo.worldX.")));
            };
            this.worldY = input.readShort();
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element of JobCrafterDirectoryEntryPlayerInfo.worldY.")));
            };
            this.mapId = input.readInt();
            this.subAreaId = input.readVarUhShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of JobCrafterDirectoryEntryPlayerInfo.subAreaId.")));
            };
            var _id11:uint = input.readUnsignedShort();
            this.status = ProtocolTypeManager.getInstance(PlayerStatus, _id11);
            this.status.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.job

