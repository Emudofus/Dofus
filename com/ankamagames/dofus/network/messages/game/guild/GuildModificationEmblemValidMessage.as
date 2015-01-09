package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildModificationEmblemValidMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6328;

        private var _isInitialized:Boolean = false;
        public var guildEmblem:GuildEmblem;

        public function GuildModificationEmblemValidMessage()
        {
            this.guildEmblem = new GuildEmblem();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6328);
        }

        public function initGuildModificationEmblemValidMessage(guildEmblem:GuildEmblem=null):GuildModificationEmblemValidMessage
        {
            this.guildEmblem = guildEmblem;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.guildEmblem = new GuildEmblem();
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
            this.serializeAs_GuildModificationEmblemValidMessage(output);
        }

        public function serializeAs_GuildModificationEmblemValidMessage(output:ICustomDataOutput):void
        {
            this.guildEmblem.serializeAs_GuildEmblem(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildModificationEmblemValidMessage(input);
        }

        public function deserializeAs_GuildModificationEmblemValidMessage(input:ICustomDataInput):void
        {
            this.guildEmblem = new GuildEmblem();
            this.guildEmblem.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

