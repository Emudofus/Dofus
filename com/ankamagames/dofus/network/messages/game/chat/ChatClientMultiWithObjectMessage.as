package com.ankamagames.dofus.network.messages.game.chat
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ChatClientMultiWithObjectMessage extends ChatClientMultiMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var objects:Vector.<ObjectItem>;
        public static const protocolId:uint = 862;

        public function ChatClientMultiWithObjectMessage()
        {
            this.objects = new Vector.<ObjectItem>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 862;
        }// end function

        public function initChatClientMultiWithObjectMessage(param1:String = "", param2:uint = 0, param3:Vector.<ObjectItem> = null) : ChatClientMultiWithObjectMessage
        {
            super.initChatClientMultiMessage(param1, param2);
            this.objects = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.objects = new Vector.<ObjectItem>;
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
            this.serializeAs_ChatClientMultiWithObjectMessage(param1);
            return;
        }// end function

        public function serializeAs_ChatClientMultiWithObjectMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ChatClientMultiMessage(param1);
            param1.writeShort(this.objects.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.objects.length)
            {
                
                (this.objects[_loc_2] as ObjectItem).serializeAs_ObjectItem(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ChatClientMultiWithObjectMessage(param1);
            return;
        }// end function

        public function deserializeAs_ChatClientMultiWithObjectMessage(param1:IDataInput) : void
        {
            var _loc_4:ObjectItem = null;
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new ObjectItem();
                _loc_4.deserialize(param1);
                this.objects.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
