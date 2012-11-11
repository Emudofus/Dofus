package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightResultTaxCollectorListEntry extends FightResultFighterListEntry implements INetworkType
    {
        public var level:uint = 0;
        public var guildInfo:BasicGuildInformations;
        public var experienceForGuild:int = 0;
        public static const protocolId:uint = 84;

        public function FightResultTaxCollectorListEntry()
        {
            this.guildInfo = new BasicGuildInformations();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 84;
        }// end function

        public function initFightResultTaxCollectorListEntry(param1:uint = 0, param2:FightLoot = null, param3:int = 0, param4:Boolean = false, param5:uint = 0, param6:BasicGuildInformations = null, param7:int = 0) : FightResultTaxCollectorListEntry
        {
            super.initFightResultFighterListEntry(param1, param2, param3, param4);
            this.level = param5;
            this.guildInfo = param6;
            this.experienceForGuild = param7;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.level = 0;
            this.guildInfo = new BasicGuildInformations();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightResultTaxCollectorListEntry(param1);
            return;
        }// end function

        public function serializeAs_FightResultTaxCollectorListEntry(param1:IDataOutput) : void
        {
            super.serializeAs_FightResultFighterListEntry(param1);
            if (this.level < 1 || this.level > 200)
            {
                throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            param1.writeByte(this.level);
            this.guildInfo.serializeAs_BasicGuildInformations(param1);
            param1.writeInt(this.experienceForGuild);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightResultTaxCollectorListEntry(param1);
            return;
        }// end function

        public function deserializeAs_FightResultTaxCollectorListEntry(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.level = param1.readUnsignedByte();
            if (this.level < 1 || this.level > 200)
            {
                throw new Error("Forbidden value (" + this.level + ") on element of FightResultTaxCollectorListEntry.level.");
            }
            this.guildInfo = new BasicGuildInformations();
            this.guildInfo.deserialize(param1);
            this.experienceForGuild = param1.readInt();
            return;
        }// end function

    }
}
