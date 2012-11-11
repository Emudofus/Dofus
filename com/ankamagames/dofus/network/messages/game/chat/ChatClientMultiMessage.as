package com.ankamagames.dofus.network.messages.game.chat
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ChatClientMultiMessage extends ChatAbstractClientMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var channel:uint = 0;
        public static const protocolId:uint = 861;

        public function ChatClientMultiMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 861;
        }// end function

        public function initChatClientMultiMessage(param1:String = "", param2:uint = 0) : ChatClientMultiMessage
        {
            super.initChatAbstractClientMessage(param1);
            this.channel = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.channel = 0;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ChatClientMultiMessage(param1);
            return;
        }// end function

        public function serializeAs_ChatClientMultiMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ChatAbstractClientMessage(param1);
            param1.writeByte(this.channel);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ChatClientMultiMessage(param1);
            return;
        }// end function

        public function deserializeAs_ChatClientMultiMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.channel = param1.readByte();
            if (this.channel < 0)
            {
                throw new Error("Forbidden value (" + this.channel + ") on element of ChatClientMultiMessage.channel.");
            }
            return;
        }// end function

    }
}
