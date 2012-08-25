package com.ankamagames.dofus.network.messages.game.context.fight
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightResumeMessage extends GameFightSpectateMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var spellCooldowns:Vector.<GameFightSpellCooldown>;
        public var summonCount:uint = 0;
        public var bombCount:uint = 0;
        public static const protocolId:uint = 6067;

        public function GameFightResumeMessage()
        {
            this.spellCooldowns = new Vector.<GameFightSpellCooldown>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6067;
        }// end function

        public function initGameFightResumeMessage(param1:Vector.<FightDispellableEffectExtendedInformations> = null, param2:Vector.<GameActionMark> = null, param3:uint = 0, param4:Vector.<GameFightSpellCooldown> = null, param5:uint = 0, param6:uint = 0) : GameFightResumeMessage
        {
            super.initGameFightSpectateMessage(param1, param2, param3);
            this.spellCooldowns = param4;
            this.summonCount = param5;
            this.bombCount = param6;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.spellCooldowns = new Vector.<GameFightSpellCooldown>;
            this.summonCount = 0;
            this.bombCount = 0;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameFightResumeMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightResumeMessage(param1:IDataOutput) : void
        {
            super.serializeAs_GameFightSpectateMessage(param1);
            param1.writeShort(this.spellCooldowns.length);
            var _loc_2:uint = 0;
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

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightResumeMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightResumeMessage(param1:IDataInput) : void
        {
            var _loc_4:GameFightSpellCooldown = null;
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
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
                throw new Error("Forbidden value (" + this.summonCount + ") on element of GameFightResumeMessage.summonCount.");
            }
            this.bombCount = param1.readByte();
            if (this.bombCount < 0)
            {
                throw new Error("Forbidden value (" + this.bombCount + ") on element of GameFightResumeMessage.bombCount.");
            }
            return;
        }// end function

    }
}
