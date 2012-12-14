package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HumanOptionGuild extends HumanOption implements INetworkType
    {
        public var guildInformations:GuildInformations;
        public static const protocolId:uint = 409;

        public function HumanOptionGuild()
        {
            this.guildInformations = new GuildInformations();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 409;
        }// end function

        public function initHumanOptionGuild(param1:GuildInformations = null) : HumanOptionGuild
        {
            this.guildInformations = param1;
            return this;
        }// end function

        override public function reset() : void
        {
            this.guildInformations = new GuildInformations();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_HumanOptionGuild(param1);
            return;
        }// end function

        public function serializeAs_HumanOptionGuild(param1:IDataOutput) : void
        {
            super.serializeAs_HumanOption(param1);
            this.guildInformations.serializeAs_GuildInformations(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HumanOptionGuild(param1);
            return;
        }// end function

        public function deserializeAs_HumanOptionGuild(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.guildInformations = new GuildInformations();
            this.guildInformations.deserialize(param1);
            return;
        }// end function

    }
}
