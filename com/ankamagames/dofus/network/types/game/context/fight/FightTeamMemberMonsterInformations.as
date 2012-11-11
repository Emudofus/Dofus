package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightTeamMemberMonsterInformations extends FightTeamMemberInformations implements INetworkType
    {
        public var monsterId:int = 0;
        public var grade:uint = 0;
        public static const protocolId:uint = 6;

        public function FightTeamMemberMonsterInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 6;
        }// end function

        public function initFightTeamMemberMonsterInformations(param1:int = 0, param2:int = 0, param3:uint = 0) : FightTeamMemberMonsterInformations
        {
            super.initFightTeamMemberInformations(param1);
            this.monsterId = param2;
            this.grade = param3;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.monsterId = 0;
            this.grade = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightTeamMemberMonsterInformations(param1);
            return;
        }// end function

        public function serializeAs_FightTeamMemberMonsterInformations(param1:IDataOutput) : void
        {
            super.serializeAs_FightTeamMemberInformations(param1);
            param1.writeInt(this.monsterId);
            if (this.grade < 0)
            {
                throw new Error("Forbidden value (" + this.grade + ") on element grade.");
            }
            param1.writeByte(this.grade);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightTeamMemberMonsterInformations(param1);
            return;
        }// end function

        public function deserializeAs_FightTeamMemberMonsterInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.monsterId = param1.readInt();
            this.grade = param1.readByte();
            if (this.grade < 0)
            {
                throw new Error("Forbidden value (" + this.grade + ") on element of FightTeamMemberMonsterInformations.grade.");
            }
            return;
        }// end function

    }
}
