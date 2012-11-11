package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AbstractFightTeamInformations extends Object implements INetworkType
    {
        public var teamId:uint = 2;
        public var leaderId:int = 0;
        public var teamSide:int = 0;
        public var teamTypeId:uint = 0;
        public static const protocolId:uint = 116;

        public function AbstractFightTeamInformations()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 116;
        }// end function

        public function initAbstractFightTeamInformations(param1:uint = 2, param2:int = 0, param3:int = 0, param4:uint = 0) : AbstractFightTeamInformations
        {
            this.teamId = param1;
            this.leaderId = param2;
            this.teamSide = param3;
            this.teamTypeId = param4;
            return this;
        }// end function

        public function reset() : void
        {
            this.teamId = 2;
            this.leaderId = 0;
            this.teamSide = 0;
            this.teamTypeId = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AbstractFightTeamInformations(param1);
            return;
        }// end function

        public function serializeAs_AbstractFightTeamInformations(param1:IDataOutput) : void
        {
            param1.writeByte(this.teamId);
            param1.writeInt(this.leaderId);
            param1.writeByte(this.teamSide);
            param1.writeByte(this.teamTypeId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AbstractFightTeamInformations(param1);
            return;
        }// end function

        public function deserializeAs_AbstractFightTeamInformations(param1:IDataInput) : void
        {
            this.teamId = param1.readByte();
            if (this.teamId < 0)
            {
                throw new Error("Forbidden value (" + this.teamId + ") on element of AbstractFightTeamInformations.teamId.");
            }
            this.leaderId = param1.readInt();
            this.teamSide = param1.readByte();
            this.teamTypeId = param1.readByte();
            if (this.teamTypeId < 0)
            {
                throw new Error("Forbidden value (" + this.teamTypeId + ") on element of AbstractFightTeamInformations.teamTypeId.");
            }
            return;
        }// end function

    }
}
