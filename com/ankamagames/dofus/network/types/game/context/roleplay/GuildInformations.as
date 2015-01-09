package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class GuildInformations extends BasicGuildInformations implements INetworkType 
    {

        public static const protocolId:uint = 127;

        public var guildEmblem:GuildEmblem;

        public function GuildInformations()
        {
            this.guildEmblem = new GuildEmblem();
            super();
        }

        override public function getTypeId():uint
        {
            return (127);
        }

        public function initGuildInformations(guildId:uint=0, guildName:String="", guildEmblem:GuildEmblem=null):GuildInformations
        {
            super.initBasicGuildInformations(guildId, guildName);
            this.guildEmblem = guildEmblem;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.guildEmblem = new GuildEmblem();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GuildInformations(output);
        }

        public function serializeAs_GuildInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_BasicGuildInformations(output);
            this.guildEmblem.serializeAs_GuildEmblem(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildInformations(input);
        }

        public function deserializeAs_GuildInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.guildEmblem = new GuildEmblem();
            this.guildEmblem.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

