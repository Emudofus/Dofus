package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightTeamMemberTaxCollectorInformations extends FightTeamMemberInformations implements INetworkType
    {
        public var firstNameId:uint = 0;
        public var lastNameId:uint = 0;
        public var level:uint = 0;
        public var guildId:uint = 0;
        public var uid:uint = 0;
        public static const protocolId:uint = 177;

        public function FightTeamMemberTaxCollectorInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 177;
        }// end function

        public function initFightTeamMemberTaxCollectorInformations(param1:int = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:uint = 0) : FightTeamMemberTaxCollectorInformations
        {
            super.initFightTeamMemberInformations(param1);
            this.firstNameId = param2;
            this.lastNameId = param3;
            this.level = param4;
            this.guildId = param5;
            this.uid = param6;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.firstNameId = 0;
            this.lastNameId = 0;
            this.level = 0;
            this.guildId = 0;
            this.uid = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightTeamMemberTaxCollectorInformations(param1);
            return;
        }// end function

        public function serializeAs_FightTeamMemberTaxCollectorInformations(param1:IDataOutput) : void
        {
            super.serializeAs_FightTeamMemberInformations(param1);
            if (this.firstNameId < 0)
            {
                throw new Error("Forbidden value (" + this.firstNameId + ") on element firstNameId.");
            }
            param1.writeShort(this.firstNameId);
            if (this.lastNameId < 0)
            {
                throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
            }
            param1.writeShort(this.lastNameId);
            if (this.level < 1 || this.level > 200)
            {
                throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            param1.writeByte(this.level);
            if (this.guildId < 0)
            {
                throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
            }
            param1.writeInt(this.guildId);
            if (this.uid < 0)
            {
                throw new Error("Forbidden value (" + this.uid + ") on element uid.");
            }
            param1.writeInt(this.uid);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightTeamMemberTaxCollectorInformations(param1);
            return;
        }// end function

        public function deserializeAs_FightTeamMemberTaxCollectorInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.firstNameId = param1.readShort();
            if (this.firstNameId < 0)
            {
                throw new Error("Forbidden value (" + this.firstNameId + ") on element of FightTeamMemberTaxCollectorInformations.firstNameId.");
            }
            this.lastNameId = param1.readShort();
            if (this.lastNameId < 0)
            {
                throw new Error("Forbidden value (" + this.lastNameId + ") on element of FightTeamMemberTaxCollectorInformations.lastNameId.");
            }
            this.level = param1.readUnsignedByte();
            if (this.level < 1 || this.level > 200)
            {
                throw new Error("Forbidden value (" + this.level + ") on element of FightTeamMemberTaxCollectorInformations.level.");
            }
            this.guildId = param1.readInt();
            if (this.guildId < 0)
            {
                throw new Error("Forbidden value (" + this.guildId + ") on element of FightTeamMemberTaxCollectorInformations.guildId.");
            }
            this.uid = param1.readInt();
            if (this.uid < 0)
            {
                throw new Error("Forbidden value (" + this.uid + ") on element of FightTeamMemberTaxCollectorInformations.uid.");
            }
            return;
        }// end function

    }
}
