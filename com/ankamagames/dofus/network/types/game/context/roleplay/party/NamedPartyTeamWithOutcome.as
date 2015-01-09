package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class NamedPartyTeamWithOutcome implements INetworkType 
    {

        public static const protocolId:uint = 470;

        public var team:NamedPartyTeam;
        public var outcome:uint = 0;

        public function NamedPartyTeamWithOutcome()
        {
            this.team = new NamedPartyTeam();
            super();
        }

        public function getTypeId():uint
        {
            return (470);
        }

        public function initNamedPartyTeamWithOutcome(team:NamedPartyTeam=null, outcome:uint=0):NamedPartyTeamWithOutcome
        {
            this.team = team;
            this.outcome = outcome;
            return (this);
        }

        public function reset():void
        {
            this.team = new NamedPartyTeam();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_NamedPartyTeamWithOutcome(output);
        }

        public function serializeAs_NamedPartyTeamWithOutcome(output:ICustomDataOutput):void
        {
            this.team.serializeAs_NamedPartyTeam(output);
            output.writeVarShort(this.outcome);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_NamedPartyTeamWithOutcome(input);
        }

        public function deserializeAs_NamedPartyTeamWithOutcome(input:ICustomDataInput):void
        {
            this.team = new NamedPartyTeam();
            this.team.deserialize(input);
            this.outcome = input.readVarUhShort();
            if (this.outcome < 0)
            {
                throw (new Error((("Forbidden value (" + this.outcome) + ") on element of NamedPartyTeamWithOutcome.outcome.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.party

