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
    public class GuildModificationValidMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6323;

        private var _isInitialized:Boolean = false;
        public var guildName:String = "";
        public var guildEmblem:GuildEmblem;

        public function GuildModificationValidMessage()
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
            return (6323);
        }

        public function initGuildModificationValidMessage(guildName:String="", guildEmblem:GuildEmblem=null):GuildModificationValidMessage
        {
            this.guildName = guildName;
            this.guildEmblem = guildEmblem;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.guildName = "";
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
            this.serializeAs_GuildModificationValidMessage(output);
        }

        public function serializeAs_GuildModificationValidMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.guildName);
            this.guildEmblem.serializeAs_GuildEmblem(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildModificationValidMessage(input);
        }

        public function deserializeAs_GuildModificationValidMessage(input:ICustomDataInput):void
        {
            this.guildName = input.readUTF();
            this.guildEmblem = new GuildEmblem();
            this.guildEmblem.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

