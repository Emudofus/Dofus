package com.ankamagames.dofus.network.types.game.context
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayTaxCollectorInformations extends GameRolePlayActorInformations implements INetworkType
    {
        public var firstNameId:uint = 0;
        public var lastNameId:uint = 0;
        public var guildIdentity:GuildInformations;
        public var guildLevel:uint = 0;
        public var taxCollectorAttack:int = 0;
        public static const protocolId:uint = 148;

        public function GameRolePlayTaxCollectorInformations()
        {
            this.guildIdentity = new GuildInformations();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 148;
        }// end function

        public function initGameRolePlayTaxCollectorInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:uint = 0, param5:uint = 0, param6:GuildInformations = null, param7:uint = 0, param8:int = 0) : GameRolePlayTaxCollectorInformations
        {
            super.initGameRolePlayActorInformations(param1, param2, param3);
            this.firstNameId = param4;
            this.lastNameId = param5;
            this.guildIdentity = param6;
            this.guildLevel = param7;
            this.taxCollectorAttack = param8;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.firstNameId = 0;
            this.lastNameId = 0;
            this.guildIdentity = new GuildInformations();
            this.taxCollectorAttack = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameRolePlayTaxCollectorInformations(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayTaxCollectorInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameRolePlayActorInformations(param1);
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
            this.guildIdentity.serializeAs_GuildInformations(param1);
            if (this.guildLevel < 0 || this.guildLevel > 255)
            {
                throw new Error("Forbidden value (" + this.guildLevel + ") on element guildLevel.");
            }
            param1.writeByte(this.guildLevel);
            param1.writeInt(this.taxCollectorAttack);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayTaxCollectorInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayTaxCollectorInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.firstNameId = param1.readShort();
            if (this.firstNameId < 0)
            {
                throw new Error("Forbidden value (" + this.firstNameId + ") on element of GameRolePlayTaxCollectorInformations.firstNameId.");
            }
            this.lastNameId = param1.readShort();
            if (this.lastNameId < 0)
            {
                throw new Error("Forbidden value (" + this.lastNameId + ") on element of GameRolePlayTaxCollectorInformations.lastNameId.");
            }
            this.guildIdentity = new GuildInformations();
            this.guildIdentity.deserialize(param1);
            this.guildLevel = param1.readUnsignedByte();
            if (this.guildLevel < 0 || this.guildLevel > 255)
            {
                throw new Error("Forbidden value (" + this.guildLevel + ") on element of GameRolePlayTaxCollectorInformations.guildLevel.");
            }
            this.taxCollectorAttack = param1.readInt();
            return;
        }// end function

    }
}
