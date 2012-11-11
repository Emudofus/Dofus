package com.ankamagames.dofus.network.messages.queues
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class LoginQueueStatusMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var position:uint = 0;
        public var total:uint = 0;
        public static const protocolId:uint = 10;

        public function LoginQueueStatusMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 10;
        }// end function

        public function initLoginQueueStatusMessage(param1:uint = 0, param2:uint = 0) : LoginQueueStatusMessage
        {
            this.position = param1;
            this.total = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.position = 0;
            this.total = 0;
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
            this.serializeAs_LoginQueueStatusMessage(param1);
            return;
        }// end function

        public function serializeAs_LoginQueueStatusMessage(param1:IDataOutput) : void
        {
            if (this.position < 0 || this.position > 65535)
            {
                throw new Error("Forbidden value (" + this.position + ") on element position.");
            }
            param1.writeShort(this.position);
            if (this.total < 0 || this.total > 65535)
            {
                throw new Error("Forbidden value (" + this.total + ") on element total.");
            }
            param1.writeShort(this.total);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_LoginQueueStatusMessage(param1);
            return;
        }// end function

        public function deserializeAs_LoginQueueStatusMessage(param1:IDataInput) : void
        {
            this.position = param1.readUnsignedShort();
            if (this.position < 0 || this.position > 65535)
            {
                throw new Error("Forbidden value (" + this.position + ") on element of LoginQueueStatusMessage.position.");
            }
            this.total = param1.readUnsignedShort();
            if (this.total < 0 || this.total > 65535)
            {
                throw new Error("Forbidden value (" + this.total + ") on element of LoginQueueStatusMessage.total.");
            }
            return;
        }// end function

    }
}
