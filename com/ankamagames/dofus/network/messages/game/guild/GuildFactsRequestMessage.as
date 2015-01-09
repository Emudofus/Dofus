package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildFactsRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6404;

        private var _isInitialized:Boolean = false;
        public var guildId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6404);
        }

        public function initGuildFactsRequestMessage(guildId:uint=0):GuildFactsRequestMessage
        {
            this.guildId = guildId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.guildId = 0;
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
            this.serializeAs_GuildFactsRequestMessage(output);
        }

        public function serializeAs_GuildFactsRequestMessage(output:ICustomDataOutput):void
        {
            if (this.guildId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guildId) + ") on element guildId.")));
            };
            output.writeVarInt(this.guildId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildFactsRequestMessage(input);
        }

        public function deserializeAs_GuildFactsRequestMessage(input:ICustomDataInput):void
        {
            this.guildId = input.readVarUhInt();
            if (this.guildId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guildId) + ") on element of GuildFactsRequestMessage.guildId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

