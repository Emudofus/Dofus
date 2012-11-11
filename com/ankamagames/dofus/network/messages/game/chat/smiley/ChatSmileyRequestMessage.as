package com.ankamagames.dofus.network.messages.game.chat.smiley
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ChatSmileyRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var smileyId:uint = 0;
        public static const protocolId:uint = 800;

        public function ChatSmileyRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 800;
        }// end function

        public function initChatSmileyRequestMessage(param1:uint = 0) : ChatSmileyRequestMessage
        {
            this.smileyId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.smileyId = 0;
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
            this.serializeAs_ChatSmileyRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_ChatSmileyRequestMessage(param1:IDataOutput) : void
        {
            if (this.smileyId < 0)
            {
                throw new Error("Forbidden value (" + this.smileyId + ") on element smileyId.");
            }
            param1.writeByte(this.smileyId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ChatSmileyRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_ChatSmileyRequestMessage(param1:IDataInput) : void
        {
            this.smileyId = param1.readByte();
            if (this.smileyId < 0)
            {
                throw new Error("Forbidden value (" + this.smileyId + ") on element of ChatSmileyRequestMessage.smileyId.");
            }
            return;
        }// end function

    }
}
