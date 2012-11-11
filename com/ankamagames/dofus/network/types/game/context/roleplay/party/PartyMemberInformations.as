package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
    import com.ankamagames.dofus.network.types.game.character.choice.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyMemberInformations extends CharacterBaseInformations implements INetworkType
    {
        public var lifePoints:uint = 0;
        public var maxLifePoints:uint = 0;
        public var prospecting:uint = 0;
        public var regenRate:uint = 0;
        public var initiative:uint = 0;
        public var pvpEnabled:Boolean = false;
        public var alignmentSide:int = 0;
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var mapId:int = 0;
        public var subAreaId:uint = 0;
        public static const protocolId:uint = 90;

        public function PartyMemberInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 90;
        }// end function

        public function initPartyMemberInformations(param1:uint = 0, param2:uint = 0, param3:String = "", param4:EntityLook = null, param5:int = 0, param6:Boolean = false, param7:uint = 0, param8:uint = 0, param9:uint = 0, param10:uint = 0, param11:uint = 0, param12:Boolean = false, param13:int = 0, param14:int = 0, param15:int = 0, param16:int = 0, param17:uint = 0) : PartyMemberInformations
        {
            super.initCharacterBaseInformations(param1, param2, param3, param4, param5, param6);
            this.lifePoints = param7;
            this.maxLifePoints = param8;
            this.prospecting = param9;
            this.regenRate = param10;
            this.initiative = param11;
            this.pvpEnabled = param12;
            this.alignmentSide = param13;
            this.worldX = param14;
            this.worldY = param15;
            this.mapId = param16;
            this.subAreaId = param17;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.lifePoints = 0;
            this.maxLifePoints = 0;
            this.prospecting = 0;
            this.regenRate = 0;
            this.initiative = 0;
            this.pvpEnabled = false;
            this.alignmentSide = 0;
            this.worldX = 0;
            this.worldY = 0;
            this.mapId = 0;
            this.subAreaId = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PartyMemberInformations(param1);
            return;
        }// end function

        public function serializeAs_PartyMemberInformations(param1:IDataOutput) : void
        {
            super.serializeAs_CharacterBaseInformations(param1);
            if (this.lifePoints < 0)
            {
                throw new Error("Forbidden value (" + this.lifePoints + ") on element lifePoints.");
            }
            param1.writeInt(this.lifePoints);
            if (this.maxLifePoints < 0)
            {
                throw new Error("Forbidden value (" + this.maxLifePoints + ") on element maxLifePoints.");
            }
            param1.writeInt(this.maxLifePoints);
            if (this.prospecting < 0)
            {
                throw new Error("Forbidden value (" + this.prospecting + ") on element prospecting.");
            }
            param1.writeShort(this.prospecting);
            if (this.regenRate < 0 || this.regenRate > 255)
            {
                throw new Error("Forbidden value (" + this.regenRate + ") on element regenRate.");
            }
            param1.writeByte(this.regenRate);
            if (this.initiative < 0)
            {
                throw new Error("Forbidden value (" + this.initiative + ") on element initiative.");
            }
            param1.writeShort(this.initiative);
            param1.writeBoolean(this.pvpEnabled);
            param1.writeByte(this.alignmentSide);
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
            this.deserializeAs_PartyMemberInformations(param1);
            return;
        }// end function

        public function deserializeAs_PartyMemberInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.lifePoints = param1.readInt();
            if (this.lifePoints < 0)
            {
                throw new Error("Forbidden value (" + this.lifePoints + ") on element of PartyMemberInformations.lifePoints.");
            }
            this.maxLifePoints = param1.readInt();
            if (this.maxLifePoints < 0)
            {
                throw new Error("Forbidden value (" + this.maxLifePoints + ") on element of PartyMemberInformations.maxLifePoints.");
            }
            this.prospecting = param1.readShort();
            if (this.prospecting < 0)
            {
                throw new Error("Forbidden value (" + this.prospecting + ") on element of PartyMemberInformations.prospecting.");
            }
            this.regenRate = param1.readUnsignedByte();
            if (this.regenRate < 0 || this.regenRate > 255)
            {
                throw new Error("Forbidden value (" + this.regenRate + ") on element of PartyMemberInformations.regenRate.");
            }
            this.initiative = param1.readShort();
            if (this.initiative < 0)
            {
                throw new Error("Forbidden value (" + this.initiative + ") on element of PartyMemberInformations.initiative.");
            }
            this.pvpEnabled = param1.readBoolean();
            this.alignmentSide = param1.readByte();
            this.worldX = param1.readShort();
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element of PartyMemberInformations.worldX.");
            }
            this.worldY = param1.readShort();
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element of PartyMemberInformations.worldY.");
            }
            this.mapId = param1.readInt();
            this.subAreaId = param1.readShort();
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element of PartyMemberInformations.subAreaId.");
            }
            return;
        }// end function

    }
}
