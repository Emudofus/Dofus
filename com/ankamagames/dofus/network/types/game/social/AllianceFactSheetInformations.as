package com.ankamagames.dofus.network.types.game.social
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AllianceFactSheetInformations extends AllianceInformations implements INetworkType 
    {

        public static const protocolId:uint = 421;

        public var creationDate:uint = 0;


        override public function getTypeId():uint
        {
            return (421);
        }

        public function initAllianceFactSheetInformations(allianceId:uint=0, allianceTag:String="", allianceName:String="", allianceEmblem:GuildEmblem=null, creationDate:uint=0):AllianceFactSheetInformations
        {
            super.initAllianceInformations(allianceId, allianceTag, allianceName, allianceEmblem);
            this.creationDate = creationDate;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.creationDate = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_AllianceFactSheetInformations(output);
        }

        public function serializeAs_AllianceFactSheetInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_AllianceInformations(output);
            if (this.creationDate < 0)
            {
                throw (new Error((("Forbidden value (" + this.creationDate) + ") on element creationDate.")));
            };
            output.writeInt(this.creationDate);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceFactSheetInformations(input);
        }

        public function deserializeAs_AllianceFactSheetInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.creationDate = input.readInt();
            if (this.creationDate < 0)
            {
                throw (new Error((("Forbidden value (" + this.creationDate) + ") on element of AllianceFactSheetInformations.creationDate.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.social

