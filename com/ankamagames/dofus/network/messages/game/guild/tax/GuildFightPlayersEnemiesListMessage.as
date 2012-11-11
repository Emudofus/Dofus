package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.character.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildFightPlayersEnemiesListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fightId:Number = 0;
        public var playerInfo:Vector.<CharacterMinimalPlusLookInformations>;
        public static const protocolId:uint = 5928;

        public function GuildFightPlayersEnemiesListMessage()
        {
            this.playerInfo = new Vector.<CharacterMinimalPlusLookInformations>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5928;
        }// end function

        public function initGuildFightPlayersEnemiesListMessage(param1:Number = 0, param2:Vector.<CharacterMinimalPlusLookInformations> = null) : GuildFightPlayersEnemiesListMessage
        {
            this.fightId = param1;
            this.playerInfo = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fightId = 0;
            this.playerInfo = new Vector.<CharacterMinimalPlusLookInformations>;
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
            this.serializeAs_GuildFightPlayersEnemiesListMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildFightPlayersEnemiesListMessage(param1:IDataOutput) : void
        {
            if (this.fightId < 0)
            {
                throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
            }
            param1.writeDouble(this.fightId);
            param1.writeShort(this.playerInfo.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.playerInfo.length)
            {
                
                (this.playerInfo[_loc_2] as CharacterMinimalPlusLookInformations).serializeAs_CharacterMinimalPlusLookInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildFightPlayersEnemiesListMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildFightPlayersEnemiesListMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            this.fightId = param1.readDouble();
            if (this.fightId < 0)
            {
                throw new Error("Forbidden value (" + this.fightId + ") on element of GuildFightPlayersEnemiesListMessage.fightId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new CharacterMinimalPlusLookInformations();
                _loc_4.deserialize(param1);
                this.playerInfo.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
