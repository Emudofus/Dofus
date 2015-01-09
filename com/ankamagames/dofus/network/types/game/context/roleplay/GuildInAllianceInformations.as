package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class GuildInAllianceInformations extends GuildInformations implements INetworkType 
    {

        public static const protocolId:uint = 420;

        public var guildLevel:uint = 0;
        public var nbMembers:uint = 0;
        public var enabled:Boolean = false;


        override public function getTypeId():uint
        {
            return (420);
        }

        public function initGuildInAllianceInformations(guildId:uint=0, guildName:String="", guildEmblem:GuildEmblem=null, guildLevel:uint=0, nbMembers:uint=0, enabled:Boolean=false):GuildInAllianceInformations
        {
            super.initGuildInformations(guildId, guildName, guildEmblem);
            this.guildLevel = guildLevel;
            this.nbMembers = nbMembers;
            this.enabled = enabled;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.guildLevel = 0;
            this.nbMembers = 0;
            this.enabled = false;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GuildInAllianceInformations(output);
        }

        public function serializeAs_GuildInAllianceInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GuildInformations(output);
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
            output.writeBoolean(this.enabled);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildInAllianceInformations(input);
        }

        public function deserializeAs_GuildInAllianceInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.guildLevel = input.readUnsignedByte();
            if ((((this.guildLevel < 1)) || ((this.guildLevel > 200))))
            {
                throw (new Error((("Forbidden value (" + this.guildLevel) + ") on element of GuildInAllianceInformations.guildLevel.")));
            };
            this.nbMembers = input.readUnsignedByte();
            if ((((this.nbMembers < 1)) || ((this.nbMembers > 240))))
            {
                throw (new Error((("Forbidden value (" + this.nbMembers) + ") on element of GuildInAllianceInformations.nbMembers.")));
            };
            this.enabled = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

