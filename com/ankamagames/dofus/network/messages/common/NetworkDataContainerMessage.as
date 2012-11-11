package com.ankamagames.dofus.network.messages.common
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class NetworkDataContainerMessage extends NetworkMessage implements INetworkMessage, INetworkDataContainerMessage
    {
        private var _content:ByteArray;
        private var _isInitialized:Boolean = false;
        public static const protocolId:uint = 2;

        public function NetworkDataContainerMessage()
        {
            return;
        }// end function

        public function get content() : ByteArray
        {
            return this._content;
        }// end function

        public function set content(param1:ByteArray) : void
        {
            this._content = param1;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 2;
        }// end function

        public function initNetworkDataContainerMessage(param1:ByteArray = null) : NetworkDataContainerMessage
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
            this.serializeAs_NetworkDataContainerMessage(param1);
            return;
        }// end function

        public function serializeAs_NetworkDataContainerMessage(param1:IDataOutput) : void
        {
            param1.writeBytes(this.content);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_NetworkDataContainerMessage(param1);
            return;
        }// end function

        public function deserializeAs_NetworkDataContainerMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = new ByteArray();
            param1.readBytes(_loc_3);
            _loc_3.uncompress();
            this.content = _loc_3;
            return;
        }// end function

    }
}
