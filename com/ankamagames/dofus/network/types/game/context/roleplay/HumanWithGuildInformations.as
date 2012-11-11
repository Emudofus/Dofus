package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.character.restriction.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HumanWithGuildInformations extends HumanInformations implements INetworkType
    {
        public var guildInformations:GuildInformations;
        public static const protocolId:uint = 153;

        public function HumanWithGuildInformations()
        {
            this.guildInformations = new GuildInformations();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 153;
        }// end function

        public function initHumanWithGuildInformations(param1:Vector.<EntityLook> = null, param2:int = 0, param3:Number = 0, param4:ActorRestrictionsInformations = null, param5:uint = 0, param6:String = "", param7:GuildInformations = null) : HumanWithGuildInformations
        {
            super.initHumanInformations(param1, param2, param3, param4, param5, param6);
            this.guildInformations = param7;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.guildInformations = new GuildInformations();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_HumanWithGuildInformations(param1);
            return;
        }// end function

        public function serializeAs_HumanWithGuildInformations(param1:IDataOutput) : void
        {
            super.serializeAs_HumanInformations(param1);
            this.guildInformations.serializeAs_GuildInformations(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HumanWithGuildInformations(param1);
            return;
        }// end function

        public function deserializeAs_HumanWithGuildInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.guildInformations = new GuildInformations();
            this.guildInformations.deserialize(param1);
            return;
        }// end function

    }
}
