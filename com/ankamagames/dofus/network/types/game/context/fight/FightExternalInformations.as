package com.ankamagames.dofus.network.types.game.context.fight
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightExternalInformations extends Object implements INetworkType
    {
        public var fightId:int = 0;
        public var fightStart:uint = 0;
        public var fightSpectatorLocked:Boolean = false;
        public var fightTeams:Vector.<FightTeamLightInformations>;
        public var fightTeamsOptions:Vector.<FightOptionsInformations>;
        public static const protocolId:uint = 117;

        public function FightExternalInformations()
        {
            this.fightTeams = new Vector.<FightTeamLightInformations>(2, true);
            this.fightTeamsOptions = new Vector.<FightOptionsInformations>(2, true);
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 117;
        }// end function

        public function initFightExternalInformations(param1:int = 0, param2:uint = 0, param3:Boolean = false, param4:Vector.<FightTeamLightInformations> = null, param5:Vector.<FightOptionsInformations> = null) : FightExternalInformations
        {
            this.fightId = param1;
            this.fightStart = param2;
            this.fightSpectatorLocked = param3;
            this.fightTeams = param4;
            this.fightTeamsOptions = param5;
            return this;
        }// end function

        public function reset() : void
        {
            this.fightId = 0;
            this.fightStart = 0;
            this.fightSpectatorLocked = false;
            this.fightTeams = new Vector.<FightTeamLightInformations>(2, true);
            this.fightTeamsOptions = new Vector.<FightOptionsInformations>(2, true);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightExternalInformations(param1);
            return;
        }// end function

        public function serializeAs_FightExternalInformations(param1:IDataOutput) : void
        {
            param1.writeInt(this.fightId);
            if (this.fightStart < 0)
            {
                throw new Error("Forbidden value (" + this.fightStart + ") on element fightStart.");
            }
            param1.writeInt(this.fightStart);
            param1.writeBoolean(this.fightSpectatorLocked);
            var _loc_2:uint = 0;
            while (_loc_2 < 2)
            {
                
                this.fightTeams[_loc_2].serializeAs_FightTeamLightInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            var _loc_3:uint = 0;
            while (_loc_3 < 2)
            {
                
                this.fightTeamsOptions[_loc_3].serializeAs_FightOptionsInformations(param1);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightExternalInformations(param1);
            return;
        }// end function

        public function deserializeAs_FightExternalInformations(param1:IDataInput) : void
        {
            this.fightId = param1.readInt();
            this.fightStart = param1.readInt();
            if (this.fightStart < 0)
            {
                throw new Error("Forbidden value (" + this.fightStart + ") on element of FightExternalInformations.fightStart.");
            }
            this.fightSpectatorLocked = param1.readBoolean();
            var _loc_2:uint = 0;
            while (_loc_2 < 2)
            {
                
                this.fightTeams[_loc_2] = new FightTeamLightInformations();
                this.fightTeams[_loc_2].deserialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            var _loc_3:uint = 0;
            while (_loc_3 < 2)
            {
                
                this.fightTeamsOptions[_loc_3] = new FightOptionsInformations();
                this.fightTeamsOptions[_loc_3].deserialize(param1);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
