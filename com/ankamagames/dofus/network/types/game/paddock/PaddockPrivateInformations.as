package com.ankamagames.dofus.network.types.game.paddock
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class PaddockPrivateInformations extends PaddockAbandonnedInformations implements INetworkType 
    {

        public static const protocolId:uint = 131;

        public var guildInfo:GuildInformations;

        public function PaddockPrivateInformations()
        {
            this.guildInfo = new GuildInformations();
            super();
        }

        override public function getTypeId():uint
        {
            return (131);
        }

        public function initPaddockPrivateInformations(maxOutdoorMount:uint=0, maxItems:uint=0, price:uint=0, locked:Boolean=false, guildId:int=0, guildInfo:GuildInformations=null):PaddockPrivateInformations
        {
            super.initPaddockAbandonnedInformations(maxOutdoorMount, maxItems, price, locked, guildId);
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
            this.serializeAs_PaddockPrivateInformations(output);
        }

        public function serializeAs_PaddockPrivateInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_PaddockAbandonnedInformations(output);
            this.guildInfo.serializeAs_GuildInformations(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PaddockPrivateInformations(input);
        }

        public function deserializeAs_PaddockPrivateInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.guildInfo = new GuildInformations();
            this.guildInfo.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.paddock

