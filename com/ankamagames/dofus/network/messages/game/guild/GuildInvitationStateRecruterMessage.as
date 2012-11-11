package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildInvitationStateRecruterMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var recrutedName:String = "";
        public var invitationState:uint = 0;
        public static const protocolId:uint = 5563;

        public function GuildInvitationStateRecruterMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5563;
        }// end function

        public function initGuildInvitationStateRecruterMessage(param1:String = "", param2:uint = 0) : GuildInvitationStateRecruterMessage
        {
            this.recrutedName = param1;
            this.invitationState = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.recrutedName = "";
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
            this.serializeAs_GuildInvitationStateRecruterMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildInvitationStateRecruterMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.recrutedName);
            param1.writeByte(this.invitationState);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildInvitationStateRecruterMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildInvitationStateRecruterMessage(param1:IDataInput) : void
        {
            this.recrutedName = param1.readUTF();
            this.invitationState = param1.readByte();
            if (this.invitationState < 0)
            {
                throw new Error("Forbidden value (" + this.invitationState + ") on element of GuildInvitationStateRecruterMessage.invitationState.");
            }
            return;
        }// end function

    }
}
