package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildJoinedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var guildInfo:GuildInformations;
        public var memberRights:uint = 0;
        public var enabled:Boolean = false;
        public static const protocolId:uint = 5564;

        public function GuildJoinedMessage()
        {
            this.guildInfo = new GuildInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5564;
        }// end function

        public function initGuildJoinedMessage(param1:GuildInformations = null, param2:uint = 0, param3:Boolean = false) : GuildJoinedMessage
        {
            this.guildInfo = param1;
            this.memberRights = param2;
            this.enabled = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.guildInfo = new GuildInformations();
            this.enabled = false;
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
            this.serializeAs_GuildJoinedMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildJoinedMessage(param1:IDataOutput) : void
        {
            this.guildInfo.serializeAs_GuildInformations(param1);
            if (this.memberRights < 0 || this.memberRights > 4294967295)
            {
                throw new Error("Forbidden value (" + this.memberRights + ") on element memberRights.");
            }
            param1.writeUnsignedInt(this.memberRights);
            param1.writeBoolean(this.enabled);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildJoinedMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildJoinedMessage(param1:IDataInput) : void
        {
            this.guildInfo = new GuildInformations();
            this.guildInfo.deserialize(param1);
            this.memberRights = param1.readUnsignedInt();
            if (this.memberRights < 0 || this.memberRights > 4294967295)
            {
                throw new Error("Forbidden value (" + this.memberRights + ") on element of GuildJoinedMessage.memberRights.");
            }
            this.enabled = param1.readBoolean();
            return;
        }// end function

    }
}
