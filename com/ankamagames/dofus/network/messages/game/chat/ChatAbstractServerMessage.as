package com.ankamagames.dofus.network.messages.game.chat
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ChatAbstractServerMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 880;

        private var _isInitialized:Boolean = false;
        public var channel:uint = 0;
        [Transient]
        public var content:String = "";
        public var timestamp:uint = 0;
        public var fingerprint:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (880);
        }

        public function initChatAbstractServerMessage(channel:uint=0, content:String="", timestamp:uint=0, fingerprint:String=""):ChatAbstractServerMessage
        {
            this.channel = channel;
            this.content = content;
            this.timestamp = timestamp;
            this.fingerprint = fingerprint;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.channel = 0;
            this.content = "";
            this.timestamp = 0;
            this.fingerprint = "";
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

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ChatAbstractServerMessage(output);
        }

        public function serializeAs_ChatAbstractServerMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.channel);
            output.writeUTF(this.content);
            if (this.timestamp < 0)
            {
                throw (new Error((("Forbidden value (" + this.timestamp) + ") on element timestamp.")));
            };
            output.writeInt(this.timestamp);
            output.writeUTF(this.fingerprint);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ChatAbstractServerMessage(input);
        }

        public function deserializeAs_ChatAbstractServerMessage(input:ICustomDataInput):void
        {
            this.channel = input.readByte();
            if (this.channel < 0)
            {
                throw (new Error((("Forbidden value (" + this.channel) + ") on element of ChatAbstractServerMessage.channel.")));
            };
            this.content = input.readUTF();
            this.timestamp = input.readInt();
            if (this.timestamp < 0)
            {
                throw (new Error((("Forbidden value (" + this.timestamp) + ") on element of ChatAbstractServerMessage.timestamp.")));
            };
            this.fingerprint = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.chat

