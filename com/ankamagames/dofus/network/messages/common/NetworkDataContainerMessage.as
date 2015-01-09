package com.ankamagames.dofus.network.messages.common
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.jerakine.network.INetworkDataContainerMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class NetworkDataContainerMessage extends NetworkMessage implements INetworkMessage, INetworkDataContainerMessage 
    {

        public static const protocolId:uint = 2;

        private var _content:ByteArray;
        private var _isInitialized:Boolean = false;


        public function get content():ByteArray
        {
            return (this._content);
        }

        public function set content(value:ByteArray):void
        {
            this._content = value;
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (2);
        }

        public function initNetworkDataContainerMessage(content:ByteArray=null):NetworkDataContainerMessage
        {
            this.content = content;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.content = new ByteArray();
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
            this.serializeAs_NetworkDataContainerMessage(output);
        }

        public function serializeAs_NetworkDataContainerMessage(output:ICustomDataOutput):void
        {
            output.writeBytes(this.content);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_NetworkDataContainerMessage(input);
        }

        public function deserializeAs_NetworkDataContainerMessage(input:ICustomDataInput):void
        {
            var _contentLen:uint = input.readUnsignedShort();
            var tmpBuffer:ByteArray = new ByteArray();
            input.readBytes(tmpBuffer, 0, _contentLen);
            tmpBuffer.uncompress();
            this.content = tmpBuffer;
        }


    }
}//package com.ankamagames.dofus.network.messages.common

