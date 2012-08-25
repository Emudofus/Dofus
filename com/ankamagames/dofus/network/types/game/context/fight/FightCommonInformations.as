package com.ankamagames.dofus.network.types.game.context.fight
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightCommonInformations extends Object implements INetworkType
    {
        public var fightId:int = 0;
        public var fightType:uint = 0;
        public var fightTeams:Vector.<FightTeamInformations>;
        public var fightTeamsPositions:Vector.<uint>;
        public var fightTeamsOptions:Vector.<FightOptionsInformations>;
        public static const protocolId:uint = 43;

        public function FightCommonInformations()
        {
            this.fightTeams = new Vector.<FightTeamInformations>;
            this.fightTeamsPositions = new Vector.<uint>;
            this.fightTeamsOptions = new Vector.<FightOptionsInformations>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 43;
        }// end function

        public function initFightCommonInformations(param1:int = 0, param2:uint = 0, param3:Vector.<FightTeamInformations> = null, param4:Vector.<uint> = null, param5:Vector.<FightOptionsInformations> = null) : FightCommonInformations
        {
            this.fightId = param1;
            this.fightType = param2;
            this.fightTeams = param3;
            this.fightTeamsPositions = param4;
            this.fightTeamsOptions = param5;
            return this;
        }// end function

        public function reset() : void
        {
            this.fightId = 0;
            this.fightType = 0;
            this.fightTeams = new Vector.<FightTeamInformations>;
            this.fightTeamsPositions = new Vector.<uint>;
            this.fightTeamsOptions = new Vector.<FightOptionsInformations>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightCommonInformations(param1);
            return;
        }// end function

        public function serializeAs_FightCommonInformations(param1:IDataOutput) : void
        {
            param1.writeInt(this.fightId);
            param1.writeByte(this.fightType);
            param1.writeShort(this.fightTeams.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.fightTeams.length)
            {
                
                (this.fightTeams[_loc_2] as FightTeamInformations).serializeAs_FightTeamInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.fightTeamsPositions.length);
            var _loc_3:uint = 0;
            while (_loc_3 < this.fightTeamsPositions.length)
            {
                
                if (this.fightTeamsPositions[_loc_3] < 0 || this.fightTeamsPositions[_loc_3] > 559)
                {
                    throw new Error("Forbidden value (" + this.fightTeamsPositions[_loc_3] + ") on element 4 (starting at 1) of fightTeamsPositions.");
                }
                param1.writeShort(this.fightTeamsPositions[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            param1.writeShort(this.fightTeamsOptions.length);
            var _loc_4:uint = 0;
            while (_loc_4 < this.fightTeamsOptions.length)
            {
                
                (this.fightTeamsOptions[_loc_4] as FightOptionsInformations).serializeAs_FightOptionsInformations(param1);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightCommonInformations(param1);
            return;
        }// end function

        public function deserializeAs_FightCommonInformations(param1:IDataInput) : void
        {
            var _loc_8:FightTeamInformations = null;
            var _loc_9:uint = 0;
            var _loc_10:FightOptionsInformations = null;
            this.fightId = param1.readInt();
            this.fightType = param1.readByte();
            if (this.fightType < 0)
            {
                throw new Error("Forbidden value (" + this.fightType + ") on element of FightCommonInformations.fightType.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_8 = new FightTeamInformations();
                _loc_8.deserialize(param1);
                this.fightTeams.push(_loc_8);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_9 = param1.readShort();
                if (_loc_9 < 0 || _loc_9 > 559)
                {
                    throw new Error("Forbidden value (" + _loc_9 + ") on elements of fightTeamsPositions.");
                }
                this.fightTeamsPositions.push(_loc_9);
                _loc_5 = _loc_5 + 1;
            }
            var _loc_6:* = param1.readUnsignedShort();
            var _loc_7:uint = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_10 = new FightOptionsInformations();
                _loc_10.deserialize(param1);
                this.fightTeamsOptions.push(_loc_10);
                _loc_7 = _loc_7 + 1;
            }
            return;
        }// end function

    }
}
