package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildModificationNameValidMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var guildName:String = "";
        public static const protocolId:uint = 6327;

        public function GuildModificationNameValidMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6327;
        }// end function

        public function initGuildModificationNameValidMessage(param1:String = "") : GuildModificationNameValidMessage
        {
            this.guildName = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.guildName = "";
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
            this.serializeAs_GuildModificationNameValidMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildModificationNameValidMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.guildName);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildModificationNameValidMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildModificationNameValidMessage(param1:IDataInput) : void
        {
            this.guildName = param1.readUTF();
            return;
        }// end function

    }
}
