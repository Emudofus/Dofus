package com.ankamagames.dofus.network.messages.game.chat
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class ChatServerCopyWithObjectMessage extends ChatServerCopyMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 884;

        private var _isInitialized:Boolean = false;
        public var objects:Vector.<ObjectItem>;

        public function ChatServerCopyWithObjectMessage()
        {
            this.objects = new Vector.<ObjectItem>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (884);
        }

        public function initChatServerCopyWithObjectMessage(channel:uint=0, content:String="", timestamp:uint=0, fingerprint:String="", receiverId:uint=0, receiverName:String="", objects:Vector.<ObjectItem>=null):ChatServerCopyWithObjectMessage
        {
            super.initChatServerCopyMessage(channel, content, timestamp, fingerprint, receiverId, receiverName);
            this.objects = objects;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.objects = new Vector.<ObjectItem>();
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ChatServerCopyWithObjectMessage(output);
        }

        public function serializeAs_ChatServerCopyWithObjectMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ChatServerCopyMessage(output);
            output.writeShort(this.objects.length);
            var _i1:uint;
            while (_i1 < this.objects.length)
            {
                (this.objects[_i1] as ObjectItem).serializeAs_ObjectItem(output);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ChatServerCopyWithObjectMessage(input);
        }

        public function deserializeAs_ChatServerCopyWithObjectMessage(input:ICustomDataInput):void
        {
            var _item1:ObjectItem;
            super.deserialize(input);
            var _objectsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _objectsLen)
            {
                _item1 = new ObjectItem();
                _item1.deserialize(input);
                this.objects.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.chat

