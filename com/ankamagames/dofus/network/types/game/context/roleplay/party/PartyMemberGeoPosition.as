package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PartyMemberGeoPosition implements INetworkType 
    {

        public static const protocolId:uint = 378;

        public var memberId:uint = 0;
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var mapId:int = 0;
        public var subAreaId:uint = 0;


        public function getTypeId():uint
        {
            return (378);
        }

        public function initPartyMemberGeoPosition(memberId:uint=0, worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0):PartyMemberGeoPosition
        {
            this.memberId = memberId;
            this.worldX = worldX;
            this.worldY = worldY;
            this.mapId = mapId;
            this.subAreaId = subAreaId;
            return (this);
        }

        public function reset():void
        {
            this.memberId = 0;
            this.worldX = 0;
            this.worldY = 0;
            this.mapId = 0;
            this.subAreaId = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PartyMemberGeoPosition(output);
        }

        public function serializeAs_PartyMemberGeoPosition(output:ICustomDataOutput):void
        {
            if (this.memberId < 0)
            {
                throw (new Error((("Forbidden value (" + this.memberId) + ") on element memberId.")));
            };
            output.writeInt(this.memberId);
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
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyMemberGeoPosition(input);
        }

        public function deserializeAs_PartyMemberGeoPosition(input:ICustomDataInput):void
        {
            this.memberId = input.readInt();
            if (this.memberId < 0)
            {
                throw (new Error((("Forbidden value (" + this.memberId) + ") on element of PartyMemberGeoPosition.memberId.")));
            };
            this.worldX = input.readShort();
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element of PartyMemberGeoPosition.worldX.")));
            };
            this.worldY = input.readShort();
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element of PartyMemberGeoPosition.worldY.")));
            };
            this.mapId = input.readInt();
            this.subAreaId = input.readVarUhShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of PartyMemberGeoPosition.subAreaId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.party

