package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class HelloConnectMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 3;

        private var _isInitialized:Boolean = false;
        [Transient]
        public var salt:String = "";
        public var key:Vector.<int>;

        public function HelloConnectMessage()
        {
            this.key = new Vector.<int>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (3);
        }

        public function initHelloConnectMessage(salt:String="", key:Vector.<int>=null):HelloConnectMessage
        {
            this.salt = salt;
            this.key = key;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.salt = "";
            this.key = new Vector.<int>();
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_HelloConnectMessage(output);
        }

        public function serializeAs_HelloConnectMessage(output:IDataOutput):void
        {
            output.writeUTF(this.salt);
            output.writeShort(this.key.length);
            var _i2:uint;
            while (_i2 < this.key.length)
            {
                output.writeByte(this.key[_i2]);
                _i2++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_HelloConnectMessage(input);
        }

        public function deserializeAs_HelloConnectMessage(input:IDataInput):void
        {
            var _val2:int;
            this.salt = input.readUTF();
            var _keyLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _keyLen)
            {
                _val2 = input.readByte();
                this.key.push(_val2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.connection

