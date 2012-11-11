package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildInvitationAnswerMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var accept:Boolean = false;
        public static const protocolId:uint = 5556;

        public function GuildInvitationAnswerMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5556;
        }// end function

        public function initGuildInvitationAnswerMessage(param1:Boolean = false) : GuildInvitationAnswerMessage
        {
            this.accept = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.accept = false;
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
            this.serializeAs_GuildInvitationAnswerMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildInvitationAnswerMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.accept);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildInvitationAnswerMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildInvitationAnswerMessage(param1:IDataInput) : void
        {
            this.accept = param1.readBoolean();
            return;
        }// end function

    }
}
