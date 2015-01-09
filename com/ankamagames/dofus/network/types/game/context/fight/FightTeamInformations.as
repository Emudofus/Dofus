package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class FightTeamInformations extends AbstractFightTeamInformations implements INetworkType 
    {

        public static const protocolId:uint = 33;

        public var teamMembers:Vector.<FightTeamMemberInformations>;

        public function FightTeamInformations()
        {
            this.teamMembers = new Vector.<FightTeamMemberInformations>();
            super();
        }

        override public function getTypeId():uint
        {
            return (33);
        }

        public function initFightTeamInformations(teamId:uint=2, leaderId:int=0, teamSide:int=0, teamTypeId:uint=0, nbWaves:uint=0, teamMembers:Vector.<FightTeamMemberInformations>=null):FightTeamInformations
        {
            super.initAbstractFightTeamInformations(teamId, leaderId, teamSide, teamTypeId, nbWaves);
            this.teamMembers = teamMembers;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.teamMembers = new Vector.<FightTeamMemberInformations>();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_FightTeamInformations(output);
        }

        public function serializeAs_FightTeamInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractFightTeamInformations(output);
            output.writeShort(this.teamMembers.length);
            var _i1:uint;
            while (_i1 < this.teamMembers.length)
            {
                output.writeShort((this.teamMembers[_i1] as FightTeamMemberInformations).getTypeId());
                (this.teamMembers[_i1] as FightTeamMemberInformations).serialize(output);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FightTeamInformations(input);
        }

        public function deserializeAs_FightTeamInformations(input:ICustomDataInput):void
        {
            var _id1:uint;
            var _item1:FightTeamMemberInformations;
            super.deserialize(input);
            var _teamMembersLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _teamMembersLen)
            {
                _id1 = input.readUnsignedShort();
                _item1 = ProtocolTypeManager.getInstance(FightTeamMemberInformations, _id1);
                _item1.deserialize(input);
                this.teamMembers.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

