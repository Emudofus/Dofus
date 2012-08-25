package com.ankamagames.dofus.network.messages.security
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class RawDataMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var content:ByteArray;
        public static const protocolId:uint = 6253;

        public function RawDataMessage()
        {
            this.content = new ByteArray();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6253;
        }// end function

        public function initRawDataMessage(param1:ByteArray = null) : RawDataMessage
        {
            this.content = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.content = new ByteArray();
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
            this.serializeAs_RawDataMessage(param1);
            return;
        }// end function

        public function serializeAs_RawDataMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.content.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.content.length)
            {
                
                param1.writeByte(this.content[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_RawDataMessage(param1);
            return;
        }// end function

        public function deserializeAs_RawDataMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readUnsignedShort();
            param1.readBytes(this.content);
            return;
        }// end function

    }
}
