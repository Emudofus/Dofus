package com.ankamagames.dofus.network.messages.game.chat
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ChatClientPrivateMessage extends ChatAbstractClientMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 851;

        private var _isInitialized:Boolean = false;
        [Transient]
        public var receiver:String = "";


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (851);
        }

        public function initChatClientPrivateMessage(content:String="", receiver:String=""):ChatClientPrivateMessage
        {
            super.initChatAbstractClientMessage(content);
            this.receiver = receiver;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.receiver = "";
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
            this.serializeAs_ChatClientPrivateMessage(output);
        }

        public function serializeAs_ChatClientPrivateMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ChatAbstractClientMessage(output);
            output.writeUTF(this.receiver);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ChatClientPrivateMessage(input);
        }

        public function deserializeAs_ChatClientPrivateMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.receiver = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.chat

