package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
    import com.ankamagames.dofus.network.types.game.character.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyMemberInformations extends CharacterMinimalPlusLookInformations implements INetworkType
    {
        public var lifePoints:uint = 0;
        public var maxLifePoints:uint = 0;
        public var prospecting:uint = 0;
        public var regenRate:uint = 0;
        public var initiative:uint = 0;
        public var pvpEnabled:Boolean = false;
        public var alignmentSide:int = 0;
        public static const protocolId:uint = 90;

        public function PartyMemberInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 90;
        }// end function

        public function initPartyMemberInformations(param1:uint = 0, param2:uint = 0, param3:String = "", param4:EntityLook = null, param5:uint = 0, param6:uint = 0, param7:uint = 0, param8:uint = 0, param9:uint = 0, param10:Boolean = false, param11:int = 0) : PartyMemberInformations
        {
            super.initCharacterMinimalPlusLookInformations(param1, param2, param3, param4);
            this.lifePoints = param5;
            this.maxLifePoints = param6;
            this.prospecting = param7;
            this.regenRate = param8;
            this.initiative = param9;
            this.pvpEnabled = param10;
            this.alignmentSide = param11;
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
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PartyMemberInformations(param1);
            return;
        }// end function

        public function serializeAs_PartyMemberInformations(param1:IDataOutput) : void
        {
            super.serializeAs_CharacterMinimalPlusLookInformations(param1);
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
            return;
        }// end function

    }
}
