package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightUpdateTeamMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fightId:uint = 0;
        public var team:FightTeamInformations;
        public static const protocolId:uint = 5572;

        public function GameFightUpdateTeamMessage()
        {
            this.team = new FightTeamInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5572;
        }// end function

        public function initGameFightUpdateTeamMessage(param1:uint = 0, param2:FightTeamInformations = null) : GameFightUpdateTeamMessage
        {
            this.fightId = param1;
            this.team = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fightId = 0;
            this.team = new FightTeamInformations();
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
            this.serializeAs_GameFightUpdateTeamMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightUpdateTeamMessage(param1:IDataOutput) : void
        {
            if (this.fightId < 0)
            {
                throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
            }
            param1.writeShort(this.fightId);
            this.team.serializeAs_FightTeamInformations(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightUpdateTeamMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightUpdateTeamMessage(param1:IDataInput) : void
        {
            this.fightId = param1.readShort();
            if (this.fightId < 0)
            {
                throw new Error("Forbidden value (" + this.fightId + ") on element of GameFightUpdateTeamMessage.fightId.");
            }
            this.team = new FightTeamInformations();
            this.team.deserialize(param1);
            return;
        }// end function

    }
}
