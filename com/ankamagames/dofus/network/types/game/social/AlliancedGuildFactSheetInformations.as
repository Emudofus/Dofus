package com.ankamagames.dofus.network.types.game.social
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
    import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AlliancedGuildFactSheetInformations extends GuildInformations implements INetworkType 
    {

        public static const protocolId:uint = 422;

        public var allianceInfos:BasicNamedAllianceInformations;

        public function AlliancedGuildFactSheetInformations()
        {
            this.allianceInfos = new BasicNamedAllianceInformations();
            super();
        }

        override public function getTypeId():uint
        {
            return (422);
        }

        public function initAlliancedGuildFactSheetInformations(guildId:uint=0, guildName:String="", guildEmblem:GuildEmblem=null, allianceInfos:BasicNamedAllianceInformations=null):AlliancedGuildFactSheetInformations
        {
            super.initGuildInformations(guildId, guildName, guildEmblem);
            this.allianceInfos = allianceInfos;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.allianceInfos = new BasicNamedAllianceInformations();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_AlliancedGuildFactSheetInformations(output);
        }

        public function serializeAs_AlliancedGuildFactSheetInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GuildInformations(output);
            this.allianceInfos.serializeAs_BasicNamedAllianceInformations(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AlliancedGuildFactSheetInformations(input);
        }

        public function deserializeAs_AlliancedGuildFactSheetInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.allianceInfos = new BasicNamedAllianceInformations();
            this.allianceInfos.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.social

