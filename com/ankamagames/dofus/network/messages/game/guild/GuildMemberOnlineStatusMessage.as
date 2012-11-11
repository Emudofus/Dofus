package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildMemberOnlineStatusMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var memberId:uint = 0;
        public var online:Boolean = false;
        public static const protocolId:uint = 6061;

        public function GuildMemberOnlineStatusMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6061;
        }// end function

        public function initGuildMemberOnlineStatusMessage(param1:uint = 0, param2:Boolean = false) : GuildMemberOnlineStatusMessage
        {
            this.memberId = param1;
            this.online = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.memberId = 0;
            this.online = false;
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
            this.serializeAs_GuildMemberOnlineStatusMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildMemberOnlineStatusMessage(param1:IDataOutput) : void
        {
            if (this.memberId < 0)
            {
                throw new Error("Forbidden value (" + this.memberId + ") on element memberId.");
            }
            param1.writeInt(this.memberId);
            param1.writeBoolean(this.online);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildMemberOnlineStatusMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildMemberOnlineStatusMessage(param1:IDataInput) : void
        {
            this.memberId = param1.readInt();
            if (this.memberId < 0)
            {
                throw new Error("Forbidden value (" + this.memberId + ") on element of GuildMemberOnlineStatusMessage.memberId.");
            }
            this.online = param1.readBoolean();
            return;
        }// end function

    }
}
