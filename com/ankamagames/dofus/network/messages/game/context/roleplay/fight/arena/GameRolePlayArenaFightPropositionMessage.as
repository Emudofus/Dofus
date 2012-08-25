package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayArenaFightPropositionMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fightId:uint = 0;
        public var alliesId:Vector.<uint>;
        public var duration:uint = 0;
        public static const protocolId:uint = 6276;

        public function GameRolePlayArenaFightPropositionMessage()
        {
            this.alliesId = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6276;
        }// end function

        public function initGameRolePlayArenaFightPropositionMessage(param1:uint = 0, param2:Vector.<uint> = null, param3:uint = 0) : GameRolePlayArenaFightPropositionMessage
        {
            this.fightId = param1;
            this.alliesId = param2;
            this.duration = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fightId = 0;
            this.alliesId = new Vector.<uint>;
            this.duration = 0;
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

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameRolePlayArenaFightPropositionMessage(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayArenaFightPropositionMessage(param1:IDataOutput) : void
        {
            if (this.fightId < 0)
            {
                throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
            }
            param1.writeInt(this.fightId);
            param1.writeShort(this.alliesId.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.alliesId.length)
            {
                
                if (this.alliesId[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.alliesId[_loc_2] + ") on element 2 (starting at 1) of alliesId.");
                }
                param1.writeInt(this.alliesId[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            if (this.duration < 0)
            {
                throw new Error("Forbidden value (" + this.duration + ") on element duration.");
            }
            param1.writeShort(this.duration);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayArenaFightPropositionMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayArenaFightPropositionMessage(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            this.fightId = param1.readInt();
            if (this.fightId < 0)
            {
                throw new Error("Forbidden value (" + this.fightId + ") on element of GameRolePlayArenaFightPropositionMessage.fightId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readInt();
                if (_loc_4 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_4 + ") on elements of alliesId.");
                }
                this.alliesId.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            this.duration = param1.readShort();
            if (this.duration < 0)
            {
                throw new Error("Forbidden value (" + this.duration + ") on element of GameRolePlayArenaFightPropositionMessage.duration.");
            }
            return;
        }// end function

    }
}
