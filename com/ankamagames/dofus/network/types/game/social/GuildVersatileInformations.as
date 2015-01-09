package com.ankamagames.dofus.network.types.game.social
{
    import com.ankamagames.jerakine.network.INetworkType;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class GuildVersatileInformations implements INetworkType 
    {

        public static const protocolId:uint = 435;

        public var guildId:uint = 0;
        public var leaderId:uint = 0;
        public var guildLevel:uint = 0;
        public var nbMembers:uint = 0;


        public function getTypeId():uint
        {
            return (435);
        }

        public function initGuildVersatileInformations(guildId:uint=0, leaderId:uint=0, guildLevel:uint=0, nbMembers:uint=0):GuildVersatileInformations
        {
            this.guildId = guildId;
            this.leaderId = leaderId;
            this.guildLevel = guildLevel;
            this.nbMembers = nbMembers;
            return (this);
        }

        public function reset():void
        {
            this.guildId = 0;
            this.leaderId = 0;
            this.guildLevel = 0;
            this.nbMembers = 0;
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_GuildVersatileInformations(output);
        }

        public function serializeAs_GuildVersatileInformations(output:IDataOutput):void
        {
            if (this.guildId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guildId) + ") on element guildId.")));
            };
            output.writeInt(this.guildId);
            if (this.leaderId < 0)
            {
                throw (new Error((("Forbidden value (" + this.leaderId) + ") on element leaderId.")));
            };
            output.writeInt(this.leaderId);
            if ((((this.guildLevel < 0)) || ((this.guildLevel > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.guildLevel) + ") on element guildLevel.")));
            };
            output.writeShort(this.guildLevel);
            if ((((this.nbMembers < 0)) || ((this.nbMembers > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.nbMembers) + ") on element nbMembers.")));
            };
            output.writeShort(this.nbMembers);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GuildVersatileInformations(input);
        }

        public function deserializeAs_GuildVersatileInformations(input:IDataInput):void
        {
            this.guildId = input.readInt();
            if (this.guildId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guildId) + ") on element of GuildVersatileInformations.guildId.")));
            };
            this.leaderId = input.readInt();
            if (this.leaderId < 0)
            {
                throw (new Error((("Forbidden value (" + this.leaderId) + ") on element of GuildVersatileInformations.leaderId.")));
            };
            this.guildLevel = input.readUnsignedShort();
            if ((((this.guildLevel < 0)) || ((this.guildLevel > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.guildLevel) + ") on element of GuildVersatileInformations.guildLevel.")));
            };
            this.nbMembers = input.readUnsignedShort();
            if ((((this.nbMembers < 0)) || ((this.nbMembers > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.nbMembers) + ") on element of GuildVersatileInformations.nbMembers.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.social

