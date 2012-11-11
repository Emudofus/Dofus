package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildInvitedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var recruterId:uint = 0;
        public var recruterName:String = "";
        public var guildInfo:BasicGuildInformations;
        public static const protocolId:uint = 5552;

        public function GuildInvitedMessage()
        {
            this.guildInfo = new BasicGuildInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5552;
        }// end function

        public function initGuildInvitedMessage(param1:uint = 0, param2:String = "", param3:BasicGuildInformations = null) : GuildInvitedMessage
        {
            this.recruterId = param1;
            this.recruterName = param2;
            this.guildInfo = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.recruterId = 0;
            this.recruterName = "";
            this.guildInfo = new BasicGuildInformations();
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
            this.serializeAs_GuildInvitedMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildInvitedMessage(param1:IDataOutput) : void
        {
            if (this.recruterId < 0)
            {
                throw new Error("Forbidden value (" + this.recruterId + ") on element recruterId.");
            }
            param1.writeInt(this.recruterId);
            param1.writeUTF(this.recruterName);
            this.guildInfo.serializeAs_BasicGuildInformations(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildInvitedMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildInvitedMessage(param1:IDataInput) : void
        {
            this.recruterId = param1.readInt();
            if (this.recruterId < 0)
            {
                throw new Error("Forbidden value (" + this.recruterId + ") on element of GuildInvitedMessage.recruterId.");
            }
            this.recruterName = param1.readUTF();
            this.guildInfo = new BasicGuildInformations();
            this.guildInfo.deserialize(param1);
            return;
        }// end function

    }
}
