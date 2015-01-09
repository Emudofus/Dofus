package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildFightPlayersHelpersLeaveMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5719;

        private var _isInitialized:Boolean = false;
        public var fightId:uint = 0;
        public var playerId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5719);
        }

        public function initGuildFightPlayersHelpersLeaveMessage(fightId:uint=0, playerId:uint=0):GuildFightPlayersHelpersLeaveMessage
        {
            this.fightId = fightId;
            this.playerId = playerId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.fightId = 0;
            this.playerId = 0;
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
            this.serializeAs_GuildFightPlayersHelpersLeaveMessage(output);
        }

        public function serializeAs_GuildFightPlayersHelpersLeaveMessage(output:ICustomDataOutput):void
        {
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element fightId.")));
            };
            output.writeInt(this.fightId);
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeVarInt(this.playerId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildFightPlayersHelpersLeaveMessage(input);
        }

        public function deserializeAs_GuildFightPlayersHelpersLeaveMessage(input:ICustomDataInput):void
        {
            this.fightId = input.readInt();
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element of GuildFightPlayersHelpersLeaveMessage.fightId.")));
            };
            this.playerId = input.readVarUhInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of GuildFightPlayersHelpersLeaveMessage.playerId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild.tax

