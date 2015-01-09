package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class GuildFightPlayersHelpersJoinMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5720;

        private var _isInitialized:Boolean = false;
        public var fightId:Number = 0;
        public var playerInfo:CharacterMinimalPlusLookInformations;

        public function GuildFightPlayersHelpersJoinMessage()
        {
            this.playerInfo = new CharacterMinimalPlusLookInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5720);
        }

        public function initGuildFightPlayersHelpersJoinMessage(fightId:Number=0, playerInfo:CharacterMinimalPlusLookInformations=null):GuildFightPlayersHelpersJoinMessage
        {
            this.fightId = fightId;
            this.playerInfo = playerInfo;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.fightId = 0;
            this.playerInfo = new CharacterMinimalPlusLookInformations();
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_GuildFightPlayersHelpersJoinMessage(output);
        }

        public function serializeAs_GuildFightPlayersHelpersJoinMessage(output:IDataOutput):void
        {
            if ((((this.fightId < 0)) || ((this.fightId > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element fightId.")));
            };
            output.writeDouble(this.fightId);
            this.playerInfo.serializeAs_CharacterMinimalPlusLookInformations(output);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GuildFightPlayersHelpersJoinMessage(input);
        }

        public function deserializeAs_GuildFightPlayersHelpersJoinMessage(input:IDataInput):void
        {
            this.fightId = input.readDouble();
            if ((((this.fightId < 0)) || ((this.fightId > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element of GuildFightPlayersHelpersJoinMessage.fightId.")));
            };
            this.playerInfo = new CharacterMinimalPlusLookInformations();
            this.playerInfo.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild.tax

