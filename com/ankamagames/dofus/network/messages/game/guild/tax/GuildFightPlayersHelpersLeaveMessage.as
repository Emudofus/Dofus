package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class GuildFightPlayersHelpersLeaveMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5719;

        private var _isInitialized:Boolean = false;
        public var fightId:Number = 0;
        public var playerId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5719);
        }

        public function initGuildFightPlayersHelpersLeaveMessage(fightId:Number=0, playerId:uint=0):GuildFightPlayersHelpersLeaveMessage
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
            this.serializeAs_GuildFightPlayersHelpersLeaveMessage(output);
        }

        public function serializeAs_GuildFightPlayersHelpersLeaveMessage(output:IDataOutput):void
        {
            if ((((this.fightId < 0)) || ((this.fightId > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element fightId.")));
            };
            output.writeDouble(this.fightId);
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeInt(this.playerId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GuildFightPlayersHelpersLeaveMessage(input);
        }

        public function deserializeAs_GuildFightPlayersHelpersLeaveMessage(input:IDataInput):void
        {
            this.fightId = input.readDouble();
            if ((((this.fightId < 0)) || ((this.fightId > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element of GuildFightPlayersHelpersLeaveMessage.fightId.")));
            };
            this.playerId = input.readInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of GuildFightPlayersHelpersLeaveMessage.playerId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild.tax

