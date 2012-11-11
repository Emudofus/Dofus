package com.ankamagames.dofus.network.messages.game.chat
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ChatServerCopyMessage extends ChatAbstractServerMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var receiverId:uint = 0;
        public var receiverName:String = "";
        public static const protocolId:uint = 882;

        public function ChatServerCopyMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 882;
        }// end function

        public function initChatServerCopyMessage(param1:uint = 0, param2:String = "", param3:uint = 0, param4:String = "", param5:uint = 0, param6:String = "") : ChatServerCopyMessage
        {
            super.initChatAbstractServerMessage(param1, param2, param3, param4);
            this.receiverId = param5;
            this.receiverName = param6;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.receiverId = 0;
            this.receiverName = "";
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
            this.serializeAs_ChatServerCopyMessage(param1);
            return;
        }// end function

        public function serializeAs_ChatServerCopyMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ChatAbstractServerMessage(param1);
            if (this.receiverId < 0)
            {
                throw new Error("Forbidden value (" + this.receiverId + ") on element receiverId.");
            }
            param1.writeInt(this.receiverId);
            param1.writeUTF(this.receiverName);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ChatServerCopyMessage(param1);
            return;
        }// end function

        public function deserializeAs_ChatServerCopyMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.receiverId = param1.readInt();
            if (this.receiverId < 0)
            {
                throw new Error("Forbidden value (" + this.receiverId + ") on element of ChatServerCopyMessage.receiverId.");
            }
            this.receiverName = param1.readUTF();
            return;
        }// end function

    }
}
