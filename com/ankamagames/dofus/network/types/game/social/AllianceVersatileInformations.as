package com.ankamagames.dofus.network.types.game.social
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AllianceVersatileInformations implements INetworkType 
    {

        public static const protocolId:uint = 432;

        public var allianceId:uint = 0;
        public var nbGuilds:uint = 0;
        public var nbMembers:uint = 0;
        public var nbSubarea:uint = 0;


        public function getTypeId():uint
        {
            return (432);
        }

        public function initAllianceVersatileInformations(allianceId:uint=0, nbGuilds:uint=0, nbMembers:uint=0, nbSubarea:uint=0):AllianceVersatileInformations
        {
            this.allianceId = allianceId;
            this.nbGuilds = nbGuilds;
            this.nbMembers = nbMembers;
            this.nbSubarea = nbSubarea;
            return (this);
        }

        public function reset():void
        {
            this.allianceId = 0;
            this.nbGuilds = 0;
            this.nbMembers = 0;
            this.nbSubarea = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_AllianceVersatileInformations(output);
        }

        public function serializeAs_AllianceVersatileInformations(output:ICustomDataOutput):void
        {
            if (this.allianceId < 0)
            {
                throw (new Error((("Forbidden value (" + this.allianceId) + ") on element allianceId.")));
            };
            output.writeVarInt(this.allianceId);
            if (this.nbGuilds < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbGuilds) + ") on element nbGuilds.")));
            };
            output.writeVarShort(this.nbGuilds);
            if (this.nbMembers < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbMembers) + ") on element nbMembers.")));
            };
            output.writeVarShort(this.nbMembers);
            if (this.nbSubarea < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbSubarea) + ") on element nbSubarea.")));
            };
            output.writeVarShort(this.nbSubarea);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceVersatileInformations(input);
        }

        public function deserializeAs_AllianceVersatileInformations(input:ICustomDataInput):void
        {
            this.allianceId = input.readVarUhInt();
            if (this.allianceId < 0)
            {
                throw (new Error((("Forbidden value (" + this.allianceId) + ") on element of AllianceVersatileInformations.allianceId.")));
            };
            this.nbGuilds = input.readVarUhShort();
            if (this.nbGuilds < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbGuilds) + ") on element of AllianceVersatileInformations.nbGuilds.")));
            };
            this.nbMembers = input.readVarUhShort();
            if (this.nbMembers < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbMembers) + ") on element of AllianceVersatileInformations.nbMembers.")));
            };
            this.nbSubarea = input.readVarUhShort();
            if (this.nbSubarea < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbSubarea) + ") on element of AllianceVersatileInformations.nbSubarea.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.social

