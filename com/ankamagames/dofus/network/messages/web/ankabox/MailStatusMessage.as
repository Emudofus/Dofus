package com.ankamagames.dofus.network.messages.web.ankabox
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MailStatusMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var unread:uint = 0;
        public var total:uint = 0;
        public static const protocolId:uint = 6275;

        public function MailStatusMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6275;
        }// end function

        public function initMailStatusMessage(param1:uint = 0, param2:uint = 0) : MailStatusMessage
        {
            this.unread = param1;
            this.total = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.unread = 0;
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
            this.serializeAs_MailStatusMessage(param1);
            return;
        }// end function

        public function serializeAs_MailStatusMessage(param1:IDataOutput) : void
        {
            if (this.unread < 0)
            {
                throw new Error("Forbidden value (" + this.unread + ") on element unread.");
            }
            param1.writeShort(this.unread);
            if (this.total < 0)
            {
                throw new Error("Forbidden value (" + this.total + ") on element total.");
            }
            param1.writeShort(this.total);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MailStatusMessage(param1);
            return;
        }// end function

        public function deserializeAs_MailStatusMessage(param1:IDataInput) : void
        {
            this.unread = param1.readShort();
            if (this.unread < 0)
            {
                throw new Error("Forbidden value (" + this.unread + ") on element of MailStatusMessage.unread.");
            }
            this.total = param1.readShort();
            if (this.total < 0)
            {
                throw new Error("Forbidden value (" + this.total + ") on element of MailStatusMessage.total.");
            }
            return;
        }// end function

    }
}
