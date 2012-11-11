package com.ankamagames.dofus.network.messages.game.chat.report
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ChatMessageReportMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var senderName:String = "";
        public var content:String = "";
        public var timestamp:uint = 0;
        public var channel:uint = 0;
        public var fingerprint:String = "";
        public var reason:uint = 0;
        public static const protocolId:uint = 821;

        public function ChatMessageReportMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 821;
        }// end function

        public function initChatMessageReportMessage(param1:String = "", param2:String = "", param3:uint = 0, param4:uint = 0, param5:String = "", param6:uint = 0) : ChatMessageReportMessage
        {
            this.senderName = param1;
            this.content = param2;
            this.timestamp = param3;
            this.channel = param4;
            this.fingerprint = param5;
            this.reason = param6;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.senderName = "";
            this.content = "";
            this.timestamp = 0;
            this.channel = 0;
            this.fingerprint = "";
            this.reason = 0;
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
            this.serializeAs_ChatMessageReportMessage(param1);
            return;
        }// end function

        public function serializeAs_ChatMessageReportMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.senderName);
            param1.writeUTF(this.content);
            if (this.timestamp < 0)
            {
                throw new Error("Forbidden value (" + this.timestamp + ") on element timestamp.");
            }
            param1.writeInt(this.timestamp);
            param1.writeByte(this.channel);
            param1.writeUTF(this.fingerprint);
            if (this.reason < 0)
            {
                throw new Error("Forbidden value (" + this.reason + ") on element reason.");
            }
            param1.writeByte(this.reason);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ChatMessageReportMessage(param1);
            return;
        }// end function

        public function deserializeAs_ChatMessageReportMessage(param1:IDataInput) : void
        {
            this.senderName = param1.readUTF();
            this.content = param1.readUTF();
            this.timestamp = param1.readInt();
            if (this.timestamp < 0)
            {
                throw new Error("Forbidden value (" + this.timestamp + ") on element of ChatMessageReportMessage.timestamp.");
            }
            this.channel = param1.readByte();
            if (this.channel < 0)
            {
                throw new Error("Forbidden value (" + this.channel + ") on element of ChatMessageReportMessage.channel.");
            }
            this.fingerprint = param1.readUTF();
            this.reason = param1.readByte();
            if (this.reason < 0)
            {
                throw new Error("Forbidden value (" + this.reason + ") on element of ChatMessageReportMessage.reason.");
            }
            return;
        }// end function

    }
}
