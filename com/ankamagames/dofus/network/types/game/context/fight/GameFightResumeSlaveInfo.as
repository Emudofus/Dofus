package com.ankamagames.dofus.network.types.game.context.fight
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightResumeSlaveInfo extends Object implements INetworkType
    {
        public var slaveId:int = 0;
        public var spellCooldowns:Vector.<GameFightSpellCooldown>;
        public var summonCount:uint = 0;
        public var bombCount:uint = 0;
        public static const protocolId:uint = 364;

        public function GameFightResumeSlaveInfo()
        {
            this.spellCooldowns = new Vector.<GameFightSpellCooldown>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 364;
        }// end function

        public function initGameFightResumeSlaveInfo(param1:int = 0, param2:Vector.<GameFightSpellCooldown> = null, param3:uint = 0, param4:uint = 0) : GameFightResumeSlaveInfo
        {
            this.slaveId = param1;
            this.spellCooldowns = param2;
            this.summonCount = param3;
            this.bombCount = param4;
            return this;
        }// end function

        public function reset() : void
        {
            this.slaveId = 0;
            this.spellCooldowns = new Vector.<GameFightSpellCooldown>;
            this.summonCount = 0;
            this.bombCount = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameFightResumeSlaveInfo(param1);
            return;
        }// end function

        public function serializeAs_GameFightResumeSlaveInfo(param1:IDataOutput) : void
        {
            param1.writeInt(this.slaveId);
            param1.writeShort(this.spellCooldowns.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.spellCooldowns.length)
            {
                
                (this.spellCooldowns[_loc_2] as GameFightSpellCooldown).serializeAs_GameFightSpellCooldown(param1);
                _loc_2 = _loc_2 + 1;
            }
            if (this.summonCount < 0)
            {
                throw new Error("Forbidden value (" + this.summonCount + ") on element summonCount.");
            }
            param1.writeByte(this.summonCount);
            if (this.bombCount < 0)
            {
                throw new Error("Forbidden value (" + this.bombCount + ") on element bombCount.");
            }
            param1.writeByte(this.bombCount);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightResumeSlaveInfo(param1);
            return;
        }// end function

        public function deserializeAs_GameFightResumeSlaveInfo(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            this.slaveId = param1.readInt();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new GameFightSpellCooldown();
                _loc_4.deserialize(param1);
                this.spellCooldowns.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            this.summonCount = param1.readByte();
            if (this.summonCount < 0)
            {
                throw new Error("Forbidden value (" + this.summonCount + ") on element of GameFightResumeSlaveInfo.summonCount.");
            }
            this.bombCount = param1.readByte();
            if (this.bombCount < 0)
            {
                throw new Error("Forbidden value (" + this.bombCount + ") on element of GameFightResumeSlaveInfo.bombCount.");
            }
            return;
        }// end function

    }
}
