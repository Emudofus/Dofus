package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.dofus.network.types.game.guild.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildCreationValidMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var guildName:String = "";
        public var guildEmblem:GuildEmblem;
        public static const protocolId:uint = 5546;

        public function GuildCreationValidMessage()
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
            return 5546;
        }// end function

        public function initGuildCreationValidMessage(param1:String = "", param2:GuildEmblem = null) : GuildCreationValidMessage
        {
            this.guildName = param1;
            this.guildEmblem = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.guildName = "";
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
            this.serializeAs_GuildCreationValidMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildCreationValidMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.guildName);
            this.guildEmblem.serializeAs_GuildEmblem(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildCreationValidMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildCreationValidMessage(param1:IDataInput) : void
        {
            this.guildName = param1.readUTF();
            this.guildEmblem = new GuildEmblem();
            this.guildEmblem.deserialize(param1);
            return;
        }// end function

    }
}
