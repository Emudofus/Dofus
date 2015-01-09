package com.ankamagames.dofus.network.types.game.social
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildInAllianceVersatileInformations extends GuildVersatileInformations implements INetworkType 
    {

        public static const protocolId:uint = 437;

        public var allianceId:uint = 0;


        override public function getTypeId():uint
        {
            return (437);
        }

        public function initGuildInAllianceVersatileInformations(guildId:uint=0, leaderId:uint=0, guildLevel:uint=0, nbMembers:uint=0, allianceId:uint=0):GuildInAllianceVersatileInformations
        {
            super.initGuildVersatileInformations(guildId, leaderId, guildLevel, nbMembers);
            this.allianceId = allianceId;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.allianceId = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GuildInAllianceVersatileInformations(output);
        }

        public function serializeAs_GuildInAllianceVersatileInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GuildVersatileInformations(output);
            if (this.allianceId < 0)
            {
                throw (new Error((("Forbidden value (" + this.allianceId) + ") on element allianceId.")));
            };
            output.writeVarInt(this.allianceId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildInAllianceVersatileInformations(input);
        }

        public function deserializeAs_GuildInAllianceVersatileInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.allianceId = input.readVarUhInt();
            if (this.allianceId < 0)
            {
                throw (new Error((("Forbidden value (" + this.allianceId) + ") on element of GuildInAllianceVersatileInformations.allianceId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.social

