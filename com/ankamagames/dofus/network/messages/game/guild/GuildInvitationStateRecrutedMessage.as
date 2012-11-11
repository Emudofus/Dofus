package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildInvitationStateRecrutedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var invitationState:uint = 0;
        public static const protocolId:uint = 5548;

        public function GuildInvitationStateRecrutedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5548;
        }// end function

        public function initGuildInvitationStateRecrutedMessage(param1:uint = 0) : GuildInvitationStateRecrutedMessage
        {
            this.invitationState = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.invitationState = 0;
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
            this.serializeAs_GuildInvitationStateRecrutedMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildInvitationStateRecrutedMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.invitationState);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildInvitationStateRecrutedMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildInvitationStateRecrutedMessage(param1:IDataInput) : void
        {
            this.invitationState = param1.readByte();
            if (this.invitationState < 0)
            {
                throw new Error("Forbidden value (" + this.invitationState + ") on element of GuildInvitationStateRecrutedMessage.invitationState.");
            }
            return;
        }// end function

    }
}
