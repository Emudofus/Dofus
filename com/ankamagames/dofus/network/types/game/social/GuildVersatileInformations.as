package com.ankamagames.dofus.network.types.game.social
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

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

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GuildVersatileInformations(output);
        }

        public function serializeAs_GuildVersatileInformations(output:ICustomDataOutput):void
        {
            if (this.guildId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guildId) + ") on element guildId.")));
            };
            output.writeVarInt(this.guildId);
            if (this.leaderId < 0)
            {
                throw (new Error((("Forbidden value (" + this.leaderId) + ") on element leaderId.")));
            };
            output.writeVarInt(this.leaderId);
            if ((((this.guildLevel < 1)) || ((this.guildLevel > 200))))
            {
                throw (new Error((("Forbidden value (" + this.guildLevel) + ") on element guildLevel.")));
            };
            output.writeByte(this.guildLevel);
            if ((((this.nbMembers < 1)) || ((this.nbMembers > 240))))
            {
                throw (new Error((("Forbidden value (" + this.nbMembers) + ") on element nbMembers.")));
            };
            output.writeByte(this.nbMembers);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildVersatileInformations(input);
        }

        public function deserializeAs_GuildVersatileInformations(input:ICustomDataInput):void
        {
            this.guildId = input.readVarUhInt();
            if (this.guildId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guildId) + ") on element of GuildVersatileInformations.guildId.")));
            };
            this.leaderId = input.readVarUhInt();
            if (this.leaderId < 0)
            {
                throw (new Error((("Forbidden value (" + this.leaderId) + ") on element of GuildVersatileInformations.leaderId.")));
            };
            this.guildLevel = input.readUnsignedByte();
            if ((((this.guildLevel < 1)) || ((this.guildLevel > 200))))
            {
                throw (new Error((("Forbidden value (" + this.guildLevel) + ") on element of GuildVersatileInformations.guildLevel.")));
            };
            this.nbMembers = input.readUnsignedByte();
            if ((((this.nbMembers < 1)) || ((this.nbMembers > 240))))
            {
                throw (new Error((("Forbidden value (" + this.nbMembers) + ") on element of GuildVersatileInformations.nbMembers.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.social

