package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyMemberGeoPosition extends Object implements INetworkType
    {
        public var memberId:uint = 0;
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var mapId:int = 0;
        public var subAreaId:uint = 0;
        public static const protocolId:uint = 378;

        public function PartyMemberGeoPosition()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 378;
        }// end function

        public function initPartyMemberGeoPosition(param1:uint = 0, param2:int = 0, param3:int = 0, param4:int = 0, param5:uint = 0) : PartyMemberGeoPosition
        {
            this.memberId = param1;
            this.worldX = param2;
            this.worldY = param3;
            this.mapId = param4;
            this.subAreaId = param5;
            return this;
        }// end function

        public function reset() : void
        {
            this.memberId = 0;
            this.worldX = 0;
            this.worldY = 0;
            this.mapId = 0;
            this.subAreaId = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PartyMemberGeoPosition(param1);
            return;
        }// end function

        public function serializeAs_PartyMemberGeoPosition(param1:IDataOutput) : void
        {
            if (this.memberId < 0)
            {
                throw new Error("Forbidden value (" + this.memberId + ") on element memberId.");
            }
            param1.writeInt(this.memberId);
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
            param1.writeInt(this.mapId);
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
            }
            param1.writeShort(this.subAreaId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyMemberGeoPosition(param1);
            return;
        }// end function

        public function deserializeAs_PartyMemberGeoPosition(param1:IDataInput) : void
        {
            this.memberId = param1.readInt();
            if (this.memberId < 0)
            {
                throw new Error("Forbidden value (" + this.memberId + ") on element of PartyMemberGeoPosition.memberId.");
            }
            this.worldX = param1.readShort();
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element of PartyMemberGeoPosition.worldX.");
            }
            this.worldY = param1.readShort();
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element of PartyMemberGeoPosition.worldY.");
            }
            this.mapId = param1.readInt();
            this.subAreaId = param1.readShort();
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element of PartyMemberGeoPosition.subAreaId.");
            }
            return;
        }// end function

    }
}
