package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.dofus.network.types.game.guild.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildInformations extends BasicGuildInformations implements INetworkType
    {
        public var guildEmblem:GuildEmblem;
        public static const protocolId:uint = 127;

        public function GuildInformations()
        {
            this.guildEmblem = new GuildEmblem();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 127;
        }// end function

        public function initGuildInformations(param1:uint = 0, param2:String = "", param3:GuildEmblem = null) : GuildInformations
        {
            super.initBasicGuildInformations(param1, param2);
            this.guildEmblem = param3;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.guildEmblem = new GuildEmblem();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GuildInformations(param1);
            return;
        }// end function

        public function serializeAs_GuildInformations(param1:IDataOutput) : void
        {
            super.serializeAs_BasicGuildInformations(param1);
            this.guildEmblem.serializeAs_GuildEmblem(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildInformations(param1);
            return;
        }// end function

        public function deserializeAs_GuildInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.guildEmblem = new GuildEmblem();
            this.guildEmblem.deserialize(param1);
            return;
        }// end function

    }
}
