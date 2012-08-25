package com.ankamagames.dofus.network.messages.connection
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HelloConnectMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var salt:String = "";
        public var key:Vector.<int>;
        public static const protocolId:uint = 3;

        public function HelloConnectMessage()
        {
            this.key = new Vector.<int>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 3;
        }// end function

        public function initHelloConnectMessage(param1:String = "", param2:Vector.<int> = null) : HelloConnectMessage
        {
            this.salt = param1;
            this.key = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.salt = "";
            this.key = new Vector.<int>;
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

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_HelloConnectMessage(param1);
            return;
        }// end function

        public function serializeAs_HelloConnectMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.salt);
            param1.writeShort(this.key.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.key.length)
            {
                
                param1.writeByte(this.key[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HelloConnectMessage(param1);
            return;
        }// end function

        public function deserializeAs_HelloConnectMessage(param1:IDataInput) : void
        {
            var _loc_4:int = 0;
            this.salt = param1.readUTF();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readByte();
                this.key.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
