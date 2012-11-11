package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildFightPlayersEnemyRemoveMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fightId:Number = 0;
        public var playerId:uint = 0;
        public static const protocolId:uint = 5929;

        public function GuildFightPlayersEnemyRemoveMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5929;
        }// end function

        public function initGuildFightPlayersEnemyRemoveMessage(param1:Number = 0, param2:uint = 0) : GuildFightPlayersEnemyRemoveMessage
        {
            this.fightId = param1;
            this.playerId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fightId = 0;
            this.playerId = 0;
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
            this.serializeAs_GuildFightPlayersEnemyRemoveMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildFightPlayersEnemyRemoveMessage(param1:IDataOutput) : void
        {
            if (this.fightId < 0)
            {
                throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
            }
            param1.writeDouble(this.fightId);
            if (this.playerId < 0)
            {
                throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            param1.writeInt(this.playerId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildFightPlayersEnemyRemoveMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildFightPlayersEnemyRemoveMessage(param1:IDataInput) : void
        {
            this.fightId = param1.readDouble();
            if (this.fightId < 0)
            {
                throw new Error("Forbidden value (" + this.fightId + ") on element of GuildFightPlayersEnemyRemoveMessage.fightId.");
            }
            this.playerId = param1.readInt();
            if (this.playerId < 0)
            {
                throw new Error("Forbidden value (" + this.playerId + ") on element of GuildFightPlayersEnemyRemoveMessage.playerId.");
            }
            return;
        }// end function

    }
}
