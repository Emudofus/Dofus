package com.ankamagames.dofus.network.messages.game.chat.smiley
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ChatSmileyMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var entityId:int = 0;
        public var smileyId:uint = 0;
        public var accountId:uint = 0;
        public static const protocolId:uint = 801;

        public function ChatSmileyMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 801;
        }// end function

        public function initChatSmileyMessage(param1:int = 0, param2:uint = 0, param3:uint = 0) : ChatSmileyMessage
        {
            this.entityId = param1;
            this.smileyId = param2;
            this.accountId = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.entityId = 0;
            this.smileyId = 0;
            this.accountId = 0;
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
            this.serializeAs_ChatSmileyMessage(param1);
            return;
        }// end function

        public function serializeAs_ChatSmileyMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.entityId);
            if (this.smileyId < 0)
            {
                throw new Error("Forbidden value (" + this.smileyId + ") on element smileyId.");
            }
            param1.writeByte(this.smileyId);
            if (this.accountId < 0)
            {
                throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
            }
            param1.writeInt(this.accountId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ChatSmileyMessage(param1);
            return;
        }// end function

        public function deserializeAs_ChatSmileyMessage(param1:IDataInput) : void
        {
            this.entityId = param1.readInt();
            this.smileyId = param1.readByte();
            if (this.smileyId < 0)
            {
                throw new Error("Forbidden value (" + this.smileyId + ") on element of ChatSmileyMessage.smileyId.");
            }
            this.accountId = param1.readInt();
            if (this.accountId < 0)
            {
                throw new Error("Forbidden value (" + this.accountId + ") on element of ChatSmileyMessage.accountId.");
            }
            return;
        }// end function

    }
}
