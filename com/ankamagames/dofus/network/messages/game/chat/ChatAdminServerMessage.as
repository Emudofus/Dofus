package com.ankamagames.dofus.network.messages.game.chat
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ChatAdminServerMessage extends ChatServerMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6135;

        private var _isInitialized:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6135);
        }

        public function initChatAdminServerMessage(channel:uint=0, content:String="", timestamp:uint=0, fingerprint:String="", senderId:int=0, senderName:String="", senderAccountId:uint=0):ChatAdminServerMessage
        {
            super.initChatServerMessage(channel, content, timestamp, fingerprint, senderId, senderName, senderAccountId);
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
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
            this.serializeAs_ChatAdminServerMessage(output);
        }

        public function serializeAs_ChatAdminServerMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ChatServerMessage(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ChatAdminServerMessage(input);
        }

        public function deserializeAs_ChatAdminServerMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.chat

