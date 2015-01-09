package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildFightPlayersHelpersJoinMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5720;

        private var _isInitialized:Boolean = false;
        public var fightId:uint = 0;
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

        public function initGuildFightPlayersHelpersJoinMessage(fightId:uint=0, playerInfo:CharacterMinimalPlusLookInformations=null):GuildFightPlayersHelpersJoinMessage
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
            this.serializeAs_GuildFightPlayersHelpersJoinMessage(output);
        }

        public function serializeAs_GuildFightPlayersHelpersJoinMessage(output:ICustomDataOutput):void
        {
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element fightId.")));
            };
            output.writeInt(this.fightId);
            this.playerInfo.serializeAs_CharacterMinimalPlusLookInformations(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildFightPlayersHelpersJoinMessage(input);
        }

        public function deserializeAs_GuildFightPlayersHelpersJoinMessage(input:ICustomDataInput):void
        {
            this.fightId = input.readInt();
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element of GuildFightPlayersHelpersJoinMessage.fightId.")));
            };
            this.playerInfo = new CharacterMinimalPlusLookInformations();
            this.playerInfo.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild.tax

