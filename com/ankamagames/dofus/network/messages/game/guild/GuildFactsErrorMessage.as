package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildFactsErrorMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6424;

        private var _isInitialized:Boolean = false;
        public var guildId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6424);
        }

        public function initGuildFactsErrorMessage(guildId:uint=0):GuildFactsErrorMessage
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
            this.serializeAs_GuildFactsErrorMessage(output);
        }

        public function serializeAs_GuildFactsErrorMessage(output:ICustomDataOutput):void
        {
            if (this.guildId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guildId) + ") on element guildId.")));
            };
            output.writeVarInt(this.guildId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildFactsErrorMessage(input);
        }

        public function deserializeAs_GuildFactsErrorMessage(input:ICustomDataInput):void
        {
            this.guildId = input.readVarUhInt();
            if (this.guildId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guildId) + ") on element of GuildFactsErrorMessage.guildId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

