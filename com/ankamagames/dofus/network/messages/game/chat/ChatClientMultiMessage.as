package com.ankamagames.dofus.network.messages.game.chat
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ChatClientMultiMessage extends ChatAbstractClientMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 861;

        private var _isInitialized:Boolean = false;
        public var channel:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (861);
        }

        public function initChatClientMultiMessage(content:String="", channel:uint=0):ChatClientMultiMessage
        {
            super.initChatAbstractClientMessage(content);
            this.channel = channel;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.channel = 0;
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            if (HASH_FUNCTION != null)
            {
                HASH_FUNCTION(data);
            };
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ChatClientMultiMessage(output);
        }

        public function serializeAs_ChatClientMultiMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ChatAbstractClientMessage(output);
            output.writeByte(this.channel);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ChatClientMultiMessage(input);
        }

        public function deserializeAs_ChatClientMultiMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.channel = input.readByte();
            if (this.channel < 0)
            {
                throw (new Error((("Forbidden value (" + this.channel) + ") on element of ChatClientMultiMessage.channel.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.chat

