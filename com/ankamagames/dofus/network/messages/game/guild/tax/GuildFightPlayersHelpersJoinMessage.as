package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.dofus.network.types.game.character.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildFightPlayersHelpersJoinMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fightId:Number = 0;
        public var playerInfo:CharacterMinimalPlusLookInformations;
        public static const protocolId:uint = 5720;

        public function GuildFightPlayersHelpersJoinMessage()
        {
            this.playerInfo = new CharacterMinimalPlusLookInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5720;
        }// end function

        public function initGuildFightPlayersHelpersJoinMessage(param1:Number = 0, param2:CharacterMinimalPlusLookInformations = null) : GuildFightPlayersHelpersJoinMessage
        {
            this.fightId = param1;
            this.playerInfo = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fightId = 0;
            this.playerInfo = new CharacterMinimalPlusLookInformations();
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
            this.serializeAs_GuildFightPlayersHelpersJoinMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildFightPlayersHelpersJoinMessage(param1:IDataOutput) : void
        {
            if (this.fightId < 0)
            {
                throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
            }
            param1.writeDouble(this.fightId);
            this.playerInfo.serializeAs_CharacterMinimalPlusLookInformations(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildFightPlayersHelpersJoinMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildFightPlayersHelpersJoinMessage(param1:IDataInput) : void
        {
            this.fightId = param1.readDouble();
            if (this.fightId < 0)
            {
                throw new Error("Forbidden value (" + this.fightId + ") on element of GuildFightPlayersHelpersJoinMessage.fightId.");
            }
            this.playerInfo = new CharacterMinimalPlusLookInformations();
            this.playerInfo.deserialize(param1);
            return;
        }// end function

    }
}
