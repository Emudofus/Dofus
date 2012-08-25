package com.ankamagames.dofus.network.types.game.context.fight
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightTeamInformations extends AbstractFightTeamInformations implements INetworkType
    {
        public var teamMembers:Vector.<FightTeamMemberInformations>;
        public static const protocolId:uint = 33;

        public function FightTeamInformations()
        {
            this.teamMembers = new Vector.<FightTeamMemberInformations>;
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 33;
        }// end function

        public function initFightTeamInformations(param1:uint = 2, param2:int = 0, param3:int = 0, param4:uint = 0, param5:Vector.<FightTeamMemberInformations> = null) : FightTeamInformations
        {
            super.initAbstractFightTeamInformations(param1, param2, param3, param4);
            this.teamMembers = param5;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.teamMembers = new Vector.<FightTeamMemberInformations>;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightTeamInformations(param1);
            return;
        }// end function

        public function serializeAs_FightTeamInformations(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractFightTeamInformations(param1);
            param1.writeShort(this.teamMembers.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.teamMembers.length)
            {
                
                param1.writeShort((this.teamMembers[_loc_2] as FightTeamMemberInformations).getTypeId());
                (this.teamMembers[_loc_2] as FightTeamMemberInformations).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightTeamInformations(param1);
            return;
        }// end function

        public function deserializeAs_FightTeamInformations(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            var _loc_5:FightTeamMemberInformations = null;
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUnsignedShort();
                _loc_5 = ProtocolTypeManager.getInstance(FightTeamMemberInformations, _loc_4);
                _loc_5.deserialize(param1);
                this.teamMembers.push(_loc_5);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
