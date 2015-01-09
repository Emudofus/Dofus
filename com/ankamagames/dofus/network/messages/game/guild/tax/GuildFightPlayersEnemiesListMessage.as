package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class GuildFightPlayersEnemiesListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5928;

        private var _isInitialized:Boolean = false;
        public var fightId:uint = 0;
        public var playerInfo:Vector.<CharacterMinimalPlusLookInformations>;

        public function GuildFightPlayersEnemiesListMessage()
        {
            this.playerInfo = new Vector.<CharacterMinimalPlusLookInformations>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5928);
        }

        public function initGuildFightPlayersEnemiesListMessage(fightId:uint=0, playerInfo:Vector.<CharacterMinimalPlusLookInformations>=null):GuildFightPlayersEnemiesListMessage
        {
            this.fightId = fightId;
            this.playerInfo = playerInfo;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.fightId = 0;
            this.playerInfo = new Vector.<CharacterMinimalPlusLookInformations>();
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GuildFightPlayersEnemiesListMessage(output);
        }

        public function serializeAs_GuildFightPlayersEnemiesListMessage(output:ICustomDataOutput):void
        {
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element fightId.")));
            };
            output.writeInt(this.fightId);
            output.writeShort(this.playerInfo.length);
            var _i2:uint;
            while (_i2 < this.playerInfo.length)
            {
                (this.playerInfo[_i2] as CharacterMinimalPlusLookInformations).serializeAs_CharacterMinimalPlusLookInformations(output);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildFightPlayersEnemiesListMessage(input);
        }

        public function deserializeAs_GuildFightPlayersEnemiesListMessage(input:ICustomDataInput):void
        {
            var _item2:CharacterMinimalPlusLookInformations;
            this.fightId = input.readInt();
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element of GuildFightPlayersEnemiesListMessage.fightId.")));
            };
            var _playerInfoLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _playerInfoLen)
            {
                _item2 = new CharacterMinimalPlusLookInformations();
                _item2.deserialize(input);
                this.playerInfo.push(_item2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild.tax

