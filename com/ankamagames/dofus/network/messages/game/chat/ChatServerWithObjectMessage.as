package com.ankamagames.dofus.network.messages.game.chat
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ChatServerWithObjectMessage extends ChatServerMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var objects:Vector.<ObjectItem>;
        public static const protocolId:uint = 883;

        public function ChatServerWithObjectMessage()
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
            return 883;
        }// end function

        public function initChatServerWithObjectMessage(param1:uint = 0, param2:String = "", param3:uint = 0, param4:String = "", param5:int = 0, param6:String = "", param7:int = 0, param8:Vector.<ObjectItem> = null) : ChatServerWithObjectMessage
        {
            super.initChatServerMessage(param1, param2, param3, param4, param5, param6, param7);
            this.objects = param8;
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
            this.serializeAs_ChatServerWithObjectMessage(param1);
            return;
        }// end function

        public function serializeAs_ChatServerWithObjectMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ChatServerMessage(param1);
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
            this.deserializeAs_ChatServerWithObjectMessage(param1);
            return;
        }// end function

        public function deserializeAs_ChatServerWithObjectMessage(param1:IDataInput) : void
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
