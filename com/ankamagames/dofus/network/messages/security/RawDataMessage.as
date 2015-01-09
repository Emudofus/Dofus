package com.ankamagames.dofus.network.messages.security
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class RawDataMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6253;

        private var _isInitialized:Boolean = false;
        public var content:ByteArray;

        public function RawDataMessage()
        {
            this.content = new ByteArray();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6253);
        }

        public function initRawDataMessage(content:ByteArray=null):RawDataMessage
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
            this.serializeAs_RawDataMessage(output);
        }

        public function serializeAs_RawDataMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.content.length);
            var _i1:uint;
            while (_i1 < this.content.length)
            {
                output.writeByte(this.content[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_RawDataMessage(input);
        }

        public function deserializeAs_RawDataMessage(input:ICustomDataInput):void
        {
            var _contentLen:uint = input.readUnsignedShort();
            input.readBytes(this.content, 0, _contentLen);
        }


    }
}//package com.ankamagames.dofus.network.messages.security

