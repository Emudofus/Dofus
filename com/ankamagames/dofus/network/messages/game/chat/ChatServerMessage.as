package com.ankamagames.dofus.network.messages.game.chat
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ChatServerMessage extends ChatAbstractServerMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var senderId:int = 0;
        public var senderName:String = "";
        public var senderAccountId:int = 0;
        public static const protocolId:uint = 881;

        public function ChatServerMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 881;
        }// end function

        public function initChatServerMessage(param1:uint = 0, param2:String = "", param3:uint = 0, param4:String = "", param5:int = 0, param6:String = "", param7:int = 0) : ChatServerMessage
        {
            super.initChatAbstractServerMessage(param1, param2, param3, param4);
            this.senderId = param5;
            this.senderName = param6;
            this.senderAccountId = param7;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.senderId = 0;
            this.senderName = "";
            this.senderAccountId = 0;
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
            this.serializeAs_ChatServerMessage(param1);
            return;
        }// end function

        public function serializeAs_ChatServerMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ChatAbstractServerMessage(param1);
            param1.writeInt(this.senderId);
            param1.writeUTF(this.senderName);
            param1.writeInt(this.senderAccountId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ChatServerMessage(param1);
            return;
        }// end function

        public function deserializeAs_ChatServerMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.senderId = param1.readInt();
            this.senderName = param1.readUTF();
            this.senderAccountId = param1.readInt();
            return;
        }// end function

    }
}
