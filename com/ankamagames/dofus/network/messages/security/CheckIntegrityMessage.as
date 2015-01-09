package com.ankamagames.dofus.network.messages.security
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class CheckIntegrityMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6372;

        private var _isInitialized:Boolean = false;
        public var data:Vector.<int>;

        public function CheckIntegrityMessage()
        {
            this.data = new Vector.<int>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6372);
        }

        public function initCheckIntegrityMessage(data:Vector.<int>=null):CheckIntegrityMessage
        {
            this.data = data;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.data = new Vector.<int>();
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
            this.serializeAs_CheckIntegrityMessage(output);
        }

        public function serializeAs_CheckIntegrityMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.data.length);
            var _i1:uint;
            while (_i1 < this.data.length)
            {
                output.writeByte(this.data[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CheckIntegrityMessage(input);
        }

        public function deserializeAs_CheckIntegrityMessage(input:ICustomDataInput):void
        {
            var _val1:int;
            var _dataLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _dataLen)
            {
                _val1 = input.readByte();
                this.data.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.security

