package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.dofus.network.types.game.guild.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildModificationEmblemValidMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var guildEmblem:GuildEmblem;
        public static const protocolId:uint = 6328;

        public function GuildModificationEmblemValidMessage()
        {
            this.guildEmblem = new GuildEmblem();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6328;
        }// end function

        public function initGuildModificationEmblemValidMessage(param1:GuildEmblem = null) : GuildModificationEmblemValidMessage
        {
            this.guildEmblem = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.guildEmblem = new GuildEmblem();
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
            this.serializeAs_GuildModificationEmblemValidMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildModificationEmblemValidMessage(param1:IDataOutput) : void
        {
            this.guildEmblem.serializeAs_GuildEmblem(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildModificationEmblemValidMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildModificationEmblemValidMessage(param1:IDataInput) : void
        {
            this.guildEmblem = new GuildEmblem();
            this.guildEmblem.deserialize(param1);
            return;
        }// end function

    }
}
