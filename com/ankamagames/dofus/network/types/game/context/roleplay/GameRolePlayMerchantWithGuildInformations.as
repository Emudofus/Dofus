package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayMerchantWithGuildInformations extends GameRolePlayMerchantInformations implements INetworkType
    {
        public var guildInformations:GuildInformations;
        public static const protocolId:uint = 146;

        public function GameRolePlayMerchantWithGuildInformations()
        {
            this.guildInformations = new GuildInformations();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 146;
        }// end function

        public function initGameRolePlayMerchantWithGuildInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:String = "", param5:uint = 0, param6:GuildInformations = null) : GameRolePlayMerchantWithGuildInformations
        {
            super.initGameRolePlayMerchantInformations(param1, param2, param3, param4, param5);
            this.guildInformations = param6;
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
            this.serializeAs_GameRolePlayMerchantWithGuildInformations(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayMerchantWithGuildInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameRolePlayMerchantInformations(param1);
            this.guildInformations.serializeAs_GuildInformations(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayMerchantWithGuildInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayMerchantWithGuildInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.guildInformations = new GuildInformations();
            this.guildInformations.deserialize(param1);
            return;
        }// end function

    }
}
