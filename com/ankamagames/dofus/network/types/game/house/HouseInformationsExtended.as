package com.ankamagames.dofus.network.types.game.house
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class HouseInformationsExtended extends HouseInformations implements INetworkType 
    {

        public static const protocolId:uint = 112;

        public var guildInfo:GuildInformations;

        public function HouseInformationsExtended()
        {
            this.guildInfo = new GuildInformations();
            super();
        }

        override public function getTypeId():uint
        {
            return (112);
        }

        public function initHouseInformationsExtended(houseId:uint=0, doorsOnMap:Vector.<uint>=null, ownerName:String="", isOnSale:Boolean=false, isSaleLocked:Boolean=false, modelId:uint=0, guildInfo:GuildInformations=null):HouseInformationsExtended
        {
            super.initHouseInformations(houseId, doorsOnMap, ownerName, isOnSale, isSaleLocked, modelId);
            this.guildInfo = guildInfo;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.guildInfo = new GuildInformations();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_HouseInformationsExtended(output);
        }

        public function serializeAs_HouseInformationsExtended(output:ICustomDataOutput):void
        {
            super.serializeAs_HouseInformations(output);
            this.guildInfo.serializeAs_GuildInformations(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HouseInformationsExtended(input);
        }

        public function deserializeAs_HouseInformationsExtended(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.guildInfo = new GuildInformations();
            this.guildInfo.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.house

