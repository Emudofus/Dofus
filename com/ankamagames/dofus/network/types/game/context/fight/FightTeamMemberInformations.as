package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightTeamMemberInformations extends Object implements INetworkType
    {
        public var id:int = 0;
        public static const protocolId:uint = 44;

        public function FightTeamMemberInformations()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 44;
        }// end function

        public function initFightTeamMemberInformations(param1:int = 0) : FightTeamMemberInformations
        {
            this.id = param1;
            return this;
        }// end function

        public function reset() : void
        {
            this.id = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightTeamMemberInformations(param1);
            return;
        }// end function

        public function serializeAs_FightTeamMemberInformations(param1:IDataOutput) : void
        {
            param1.writeInt(this.id);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightTeamMemberInformations(param1);
            return;
        }// end function

        public function deserializeAs_FightTeamMemberInformations(param1:IDataInput) : void
        {
            this.id = param1.readInt();
            return;
        }// end function

    }
}
