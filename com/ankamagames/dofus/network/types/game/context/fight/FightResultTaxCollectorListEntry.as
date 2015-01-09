package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class FightResultTaxCollectorListEntry extends FightResultFighterListEntry implements INetworkType 
    {

        public static const protocolId:uint = 84;

        public var level:uint = 0;
        public var guildInfo:BasicGuildInformations;
        public var experienceForGuild:int = 0;

        public function FightResultTaxCollectorListEntry()
        {
            this.guildInfo = new BasicGuildInformations();
            super();
        }

        override public function getTypeId():uint
        {
            return (84);
        }

        public function initFightResultTaxCollectorListEntry(outcome:uint=0, wave:uint=0, rewards:FightLoot=null, id:int=0, alive:Boolean=false, level:uint=0, guildInfo:BasicGuildInformations=null, experienceForGuild:int=0):FightResultTaxCollectorListEntry
        {
            super.initFightResultFighterListEntry(outcome, wave, rewards, id, alive);
            this.level = level;
            this.guildInfo = guildInfo;
            this.experienceForGuild = experienceForGuild;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.level = 0;
            this.guildInfo = new BasicGuildInformations();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_FightResultTaxCollectorListEntry(output);
        }

        public function serializeAs_FightResultTaxCollectorListEntry(output:ICustomDataOutput):void
        {
            super.serializeAs_FightResultFighterListEntry(output);
            if ((((this.level < 1)) || ((this.level > 200))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element level.")));
            };
            output.writeByte(this.level);
            this.guildInfo.serializeAs_BasicGuildInformations(output);
            output.writeInt(this.experienceForGuild);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FightResultTaxCollectorListEntry(input);
        }

        public function deserializeAs_FightResultTaxCollectorListEntry(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.level = input.readUnsignedByte();
            if ((((this.level < 1)) || ((this.level > 200))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element of FightResultTaxCollectorListEntry.level.")));
            };
            this.guildInfo = new BasicGuildInformations();
            this.guildInfo.deserialize(input);
            this.experienceForGuild = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

