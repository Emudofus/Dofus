package com.ankamagames.dofus.network.messages.game.chat
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ChatAdminServerMessage extends ChatServerMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public static const protocolId:uint = 6135;

        public function ChatAdminServerMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6135;
        }// end function

        public function initChatAdminServerMessage(param1:uint = 0, param2:String = "", param3:uint = 0, param4:String = "", param5:int = 0, param6:String = "", param7:int = 0) : ChatAdminServerMessage
        {
            super.initChatServerMessage(param1, param2, param3, param4, param5, param6, param7);
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
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
            this.serializeAs_ChatAdminServerMessage(param1);
            return;
        }// end function

        public function serializeAs_ChatAdminServerMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ChatServerMessage(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ChatAdminServerMessage(param1);
            return;
        }// end function

        public function deserializeAs_ChatAdminServerMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            return;
        }// end function

    }
}
