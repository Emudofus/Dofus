package com.ankamagames.dofus.network.messages.security
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ClientKeyMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var key:String = "";
        public static const protocolId:uint = 5607;

        public function ClientKeyMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5607;
        }// end function

        public function initClientKeyMessage(param1:String = "") : ClientKeyMessage
        {
            this.key = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.key = "";
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
            this.serializeAs_ClientKeyMessage(param1);
            return;
        }// end function

        public function serializeAs_ClientKeyMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.key);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ClientKeyMessage(param1);
            return;
        }// end function

        public function deserializeAs_ClientKeyMessage(param1:IDataInput) : void
        {
            this.key = param1.readUTF();
            return;
        }// end function

    }
}
