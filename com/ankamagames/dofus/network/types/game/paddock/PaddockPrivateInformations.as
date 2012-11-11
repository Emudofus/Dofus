package com.ankamagames.dofus.network.types.game.paddock
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PaddockPrivateInformations extends PaddockAbandonnedInformations implements INetworkType
    {
        public var guildInfo:GuildInformations;
        public static const protocolId:uint = 131;

        public function PaddockPrivateInformations()
        {
            this.guildInfo = new GuildInformations();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 131;
        }// end function

        public function initPaddockPrivateInformations(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:Boolean = false, param5:int = 0, param6:GuildInformations = null) : PaddockPrivateInformations
        {
            super.initPaddockAbandonnedInformations(param1, param2, param3, param4, param5);
            this.guildInfo = param6;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.guildInfo = new GuildInformations();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PaddockPrivateInformations(param1);
            return;
        }// end function

        public function serializeAs_PaddockPrivateInformations(param1:IDataOutput) : void
        {
            super.serializeAs_PaddockAbandonnedInformations(param1);
            this.guildInfo.serializeAs_GuildInformations(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PaddockPrivateInformations(param1);
            return;
        }// end function

        public function deserializeAs_PaddockPrivateInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.guildInfo = new GuildInformations();
            this.guildInfo.deserialize(param1);
            return;
        }// end function

    }
}
