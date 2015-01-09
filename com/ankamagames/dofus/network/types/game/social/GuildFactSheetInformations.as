package com.ankamagames.dofus.network.types.game.social
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildFactSheetInformations extends GuildInformations implements INetworkType 
    {

        public static const protocolId:uint = 424;

        public var leaderId:uint = 0;
        public var guildLevel:uint = 0;
        public var nbMembers:uint = 0;


        override public function getTypeId():uint
        {
            return (424);
        }

        public function initGuildFactSheetInformations(guildId:uint=0, guildName:String="", guildEmblem:GuildEmblem=null, leaderId:uint=0, guildLevel:uint=0, nbMembers:uint=0):GuildFactSheetInformations
        {
            super.initGuildInformations(guildId, guildName, guildEmblem);
            this.leaderId = leaderId;
            this.guildLevel = guildLevel;
            this.nbMembers = nbMembers;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.leaderId = 0;
            this.guildLevel = 0;
            this.nbMembers = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GuildFactSheetInformations(output);
        }

        public function serializeAs_GuildFactSheetInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GuildInformations(output);
            if (this.leaderId < 0)
            {
                throw (new Error((("Forbidden value (" + this.leaderId) + ") on element leaderId.")));
            };
            output.writeVarInt(this.leaderId);
            if ((((this.guildLevel < 0)) || ((this.guildLevel > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.guildLevel) + ") on element guildLevel.")));
            };
            output.writeByte(this.guildLevel);
            if (this.nbMembers < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbMembers) + ") on element nbMembers.")));
            };
            output.writeVarShort(this.nbMembers);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildFactSheetInformations(input);
        }

        public function deserializeAs_GuildFactSheetInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.leaderId = input.readVarUhInt();
            if (this.leaderId < 0)
            {
                throw (new Error((("Forbidden value (" + this.leaderId) + ") on element of GuildFactSheetInformations.leaderId.")));
            };
            this.guildLevel = input.readUnsignedByte();
            if ((((this.guildLevel < 0)) || ((this.guildLevel > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.guildLevel) + ") on element of GuildFactSheetInformations.guildLevel.")));
            };
            this.nbMembers = input.readVarUhShort();
            if (this.nbMembers < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbMembers) + ") on element of GuildFactSheetInformations.nbMembers.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.social

