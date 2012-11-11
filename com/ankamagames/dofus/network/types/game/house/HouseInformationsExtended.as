package com.ankamagames.dofus.network.types.game.house
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HouseInformationsExtended extends HouseInformations implements INetworkType
    {
        public var guildInfo:GuildInformations;
        public static const protocolId:uint = 112;

        public function HouseInformationsExtended()
        {
            this.guildInfo = new GuildInformations();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 112;
        }// end function

        public function initHouseInformationsExtended(param1:uint = 0, param2:Vector.<uint> = null, param3:String = "", param4:Boolean = false, param5:Boolean = false, param6:uint = 0, param7:GuildInformations = null) : HouseInformationsExtended
        {
            super.initHouseInformations(param1, param2, param3, param4, param5, param6);
            this.guildInfo = param7;
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
            this.serializeAs_HouseInformationsExtended(param1);
            return;
        }// end function

        public function serializeAs_HouseInformationsExtended(param1:IDataOutput) : void
        {
            super.serializeAs_HouseInformations(param1);
            this.guildInfo.serializeAs_GuildInformations(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HouseInformationsExtended(param1);
            return;
        }// end function

        public function deserializeAs_HouseInformationsExtended(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.guildInfo = new GuildInformations();
            this.guildInfo.deserialize(param1);
            return;
        }// end function

    }
}
