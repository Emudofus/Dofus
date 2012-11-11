package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class IdentificationFailedBannedMessage extends IdentificationFailedMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var banEndDate:Number = 0;
        public static const protocolId:uint = 6174;

        public function IdentificationFailedBannedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6174;
        }// end function

        public function initIdentificationFailedBannedMessage(param1:uint = 99, param2:Number = 0) : IdentificationFailedBannedMessage
        {
            super.initIdentificationFailedMessage(param1);
            this.banEndDate = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.banEndDate = 0;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_IdentificationFailedBannedMessage(param1);
            return;
        }// end function

        public function serializeAs_IdentificationFailedBannedMessage(param1:IDataOutput) : void
        {
            super.serializeAs_IdentificationFailedMessage(param1);
            if (this.banEndDate < 0)
            {
                throw new Error("Forbidden value (" + this.banEndDate + ") on element banEndDate.");
            }
            param1.writeDouble(this.banEndDate);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_IdentificationFailedBannedMessage(param1);
            return;
        }// end function

        public function deserializeAs_IdentificationFailedBannedMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.banEndDate = param1.readDouble();
            if (this.banEndDate < 0)
            {
                throw new Error("Forbidden value (" + this.banEndDate + ") on element of IdentificationFailedBannedMessage.banEndDate.");
            }
            return;
        }// end function

    }
}
