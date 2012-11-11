package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightRemoveTeamMemberMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fightId:uint = 0;
        public var teamId:uint = 2;
        public var charId:int = 0;
        public static const protocolId:uint = 711;

        public function GameFightRemoveTeamMemberMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 711;
        }// end function

        public function initGameFightRemoveTeamMemberMessage(param1:uint = 0, param2:uint = 2, param3:int = 0) : GameFightRemoveTeamMemberMessage
        {
            this.fightId = param1;
            this.teamId = param2;
            this.charId = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fightId = 0;
            this.teamId = 2;
            this.charId = 0;
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
            this.serializeAs_GameFightRemoveTeamMemberMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightRemoveTeamMemberMessage(param1:IDataOutput) : void
        {
            if (this.fightId < 0)
            {
                throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
            }
            param1.writeShort(this.fightId);
            param1.writeByte(this.teamId);
            param1.writeInt(this.charId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightRemoveTeamMemberMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightRemoveTeamMemberMessage(param1:IDataInput) : void
        {
            this.fightId = param1.readShort();
            if (this.fightId < 0)
            {
                throw new Error("Forbidden value (" + this.fightId + ") on element of GameFightRemoveTeamMemberMessage.fightId.");
            }
            this.teamId = param1.readByte();
            if (this.teamId < 0)
            {
                throw new Error("Forbidden value (" + this.teamId + ") on element of GameFightRemoveTeamMemberMessage.teamId.");
            }
            this.charId = param1.readInt();
            return;
        }// end function

    }
}
