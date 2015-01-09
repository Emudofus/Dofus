package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class AbstractFightTeamInformations implements INetworkType 
    {

        public static const protocolId:uint = 116;

        public var teamId:uint = 2;
        public var leaderId:int = 0;
        public var teamSide:int = 0;
        public var teamTypeId:uint = 0;
        public var nbWaves:uint = 0;


        public function getTypeId():uint
        {
            return (116);
        }

        public function initAbstractFightTeamInformations(teamId:uint=2, leaderId:int=0, teamSide:int=0, teamTypeId:uint=0, nbWaves:uint=0):AbstractFightTeamInformations
        {
            this.teamId = teamId;
            this.leaderId = leaderId;
            this.teamSide = teamSide;
            this.teamTypeId = teamTypeId;
            this.nbWaves = nbWaves;
            return (this);
        }

        public function reset():void
        {
            this.teamId = 2;
            this.leaderId = 0;
            this.teamSide = 0;
            this.teamTypeId = 0;
            this.nbWaves = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_AbstractFightTeamInformations(output);
        }

        public function serializeAs_AbstractFightTeamInformations(output:ICustomDataOutput):void
        {
            output.writeByte(this.teamId);
            output.writeInt(this.leaderId);
            output.writeByte(this.teamSide);
            output.writeByte(this.teamTypeId);
            if (this.nbWaves < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbWaves) + ") on element nbWaves.")));
            };
            output.writeByte(this.nbWaves);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AbstractFightTeamInformations(input);
        }

        public function deserializeAs_AbstractFightTeamInformations(input:ICustomDataInput):void
        {
            this.teamId = input.readByte();
            if (this.teamId < 0)
            {
                throw (new Error((("Forbidden value (" + this.teamId) + ") on element of AbstractFightTeamInformations.teamId.")));
            };
            this.leaderId = input.readInt();
            this.teamSide = input.readByte();
            this.teamTypeId = input.readByte();
            if (this.teamTypeId < 0)
            {
                throw (new Error((("Forbidden value (" + this.teamTypeId) + ") on element of AbstractFightTeamInformations.teamTypeId.")));
            };
            this.nbWaves = input.readByte();
            if (this.nbWaves < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbWaves) + ") on element of AbstractFightTeamInformations.nbWaves.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

