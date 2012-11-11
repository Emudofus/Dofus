package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
    import com.ankamagames.dofus.network.types.game.character.choice.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyInvitationMemberInformations extends CharacterBaseInformations implements INetworkType
    {
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var mapId:int = 0;
        public var subAreaId:uint = 0;
        public static const protocolId:uint = 376;

        public function PartyInvitationMemberInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 376;
        }// end function

        public function initPartyInvitationMemberInformations(param1:uint = 0, param2:uint = 0, param3:String = "", param4:EntityLook = null, param5:int = 0, param6:Boolean = false, param7:int = 0, param8:int = 0, param9:int = 0, param10:uint = 0) : PartyInvitationMemberInformations
        {
            super.initCharacterBaseInformations(param1, param2, param3, param4, param5, param6);
            this.worldX = param7;
            this.worldY = param8;
            this.mapId = param9;
            this.subAreaId = param10;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.worldX = 0;
            this.worldY = 0;
            this.mapId = 0;
            this.subAreaId = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PartyInvitationMemberInformations(param1);
            return;
        }// end function

        public function serializeAs_PartyInvitationMemberInformations(param1:IDataOutput) : void
        {
            super.serializeAs_CharacterBaseInformations(param1);
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

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyInvitationMemberInformations(param1);
            return;
        }// end function

        public function deserializeAs_PartyInvitationMemberInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.worldX = param1.readShort();
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element of PartyInvitationMemberInformations.worldX.");
            }
            this.worldY = param1.readShort();
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element of PartyInvitationMemberInformations.worldY.");
            }
            this.mapId = param1.readInt();
            this.subAreaId = param1.readShort();
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element of PartyInvitationMemberInformations.subAreaId.");
            }
            return;
        }// end function

    }
}
