package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayArenaUpdatePlayerInfosMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var rank:uint = 0;
        public var bestDailyRank:uint = 0;
        public var bestRank:uint = 0;
        public var victoryCount:uint = 0;
        public var arenaFightcount:uint = 0;
        public static const protocolId:uint = 6301;

        public function GameRolePlayArenaUpdatePlayerInfosMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6301;
        }// end function

        public function initGameRolePlayArenaUpdatePlayerInfosMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0) : GameRolePlayArenaUpdatePlayerInfosMessage
        {
            this.rank = param1;
            this.bestDailyRank = param2;
            this.bestRank = param3;
            this.victoryCount = param4;
            this.arenaFightcount = param5;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.rank = 0;
            this.bestDailyRank = 0;
            this.bestRank = 0;
            this.victoryCount = 0;
            this.arenaFightcount = 0;
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
            this.serializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(param1:IDataOutput) : void
        {
            if (this.rank < 0 || this.rank > 2300)
            {
                throw new Error("Forbidden value (" + this.rank + ") on element rank.");
            }
            param1.writeShort(this.rank);
            if (this.bestDailyRank < 0 || this.bestDailyRank > 2300)
            {
                throw new Error("Forbidden value (" + this.bestDailyRank + ") on element bestDailyRank.");
            }
            param1.writeShort(this.bestDailyRank);
            if (this.bestRank < 0 || this.bestRank > 2300)
            {
                throw new Error("Forbidden value (" + this.bestRank + ") on element bestRank.");
            }
            param1.writeShort(this.bestRank);
            if (this.victoryCount < 0)
            {
                throw new Error("Forbidden value (" + this.victoryCount + ") on element victoryCount.");
            }
            param1.writeShort(this.victoryCount);
            if (this.arenaFightcount < 0)
            {
                throw new Error("Forbidden value (" + this.arenaFightcount + ") on element arenaFightcount.");
            }
            param1.writeShort(this.arenaFightcount);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(param1:IDataInput) : void
        {
            this.rank = param1.readShort();
            if (this.rank < 0 || this.rank > 2300)
            {
                throw new Error("Forbidden value (" + this.rank + ") on element of GameRolePlayArenaUpdatePlayerInfosMessage.rank.");
            }
            this.bestDailyRank = param1.readShort();
            if (this.bestDailyRank < 0 || this.bestDailyRank > 2300)
            {
                throw new Error("Forbidden value (" + this.bestDailyRank + ") on element of GameRolePlayArenaUpdatePlayerInfosMessage.bestDailyRank.");
            }
            this.bestRank = param1.readShort();
            if (this.bestRank < 0 || this.bestRank > 2300)
            {
                throw new Error("Forbidden value (" + this.bestRank + ") on element of GameRolePlayArenaUpdatePlayerInfosMessage.bestRank.");
            }
            this.victoryCount = param1.readShort();
            if (this.victoryCount < 0)
            {
                throw new Error("Forbidden value (" + this.victoryCount + ") on element of GameRolePlayArenaUpdatePlayerInfosMessage.victoryCount.");
            }
            this.arenaFightcount = param1.readShort();
            if (this.arenaFightcount < 0)
            {
                throw new Error("Forbidden value (" + this.arenaFightcount + ") on element of GameRolePlayArenaUpdatePlayerInfosMessage.arenaFightcount.");
            }
            return;
        }// end function

    }
}
