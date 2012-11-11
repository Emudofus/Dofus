package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightTeamMemberCharacterInformations extends FightTeamMemberInformations implements INetworkType
    {
        public var name:String = "";
        public var level:uint = 0;
        public static const protocolId:uint = 13;

        public function FightTeamMemberCharacterInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 13;
        }// end function

        public function initFightTeamMemberCharacterInformations(param1:int = 0, param2:String = "", param3:uint = 0) : FightTeamMemberCharacterInformations
        {
            super.initFightTeamMemberInformations(param1);
            this.name = param2;
            this.level = param3;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.name = "";
            this.level = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightTeamMemberCharacterInformations(param1);
            return;
        }// end function

        public function serializeAs_FightTeamMemberCharacterInformations(param1:IDataOutput) : void
        {
            super.serializeAs_FightTeamMemberInformations(param1);
            param1.writeUTF(this.name);
            if (this.level < 0)
            {
                throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            param1.writeShort(this.level);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightTeamMemberCharacterInformations(param1);
            return;
        }// end function

        public function deserializeAs_FightTeamMemberCharacterInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.name = param1.readUTF();
            this.level = param1.readShort();
            if (this.level < 0)
            {
                throw new Error("Forbidden value (" + this.level + ") on element of FightTeamMemberCharacterInformations.level.");
            }
            return;
        }// end function

    }
}
