package com.ankamagames.dofus.network.messages.game.approach
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AccountLoggingKickedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var days:uint = 0;
        public var hours:uint = 0;
        public var minutes:uint = 0;
        public static const protocolId:uint = 6029;

        public function AccountLoggingKickedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6029;
        }// end function

        public function initAccountLoggingKickedMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : AccountLoggingKickedMessage
        {
            this.days = param1;
            this.hours = param2;
            this.minutes = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.days = 0;
            this.hours = 0;
            this.minutes = 0;
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
            this.serializeAs_AccountLoggingKickedMessage(param1);
            return;
        }// end function

        public function serializeAs_AccountLoggingKickedMessage(param1:IDataOutput) : void
        {
            if (this.days < 0)
            {
                throw new Error("Forbidden value (" + this.days + ") on element days.");
            }
            param1.writeInt(this.days);
            if (this.hours < 0)
            {
                throw new Error("Forbidden value (" + this.hours + ") on element hours.");
            }
            param1.writeInt(this.hours);
            if (this.minutes < 0)
            {
                throw new Error("Forbidden value (" + this.minutes + ") on element minutes.");
            }
            param1.writeInt(this.minutes);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AccountLoggingKickedMessage(param1);
            return;
        }// end function

        public function deserializeAs_AccountLoggingKickedMessage(param1:IDataInput) : void
        {
            this.days = param1.readInt();
            if (this.days < 0)
            {
                throw new Error("Forbidden value (" + this.days + ") on element of AccountLoggingKickedMessage.days.");
            }
            this.hours = param1.readInt();
            if (this.hours < 0)
            {
                throw new Error("Forbidden value (" + this.hours + ") on element of AccountLoggingKickedMessage.hours.");
            }
            this.minutes = param1.readInt();
            if (this.minutes < 0)
            {
                throw new Error("Forbidden value (" + this.minutes + ") on element of AccountLoggingKickedMessage.minutes.");
            }
            return;
        }// end function

    }
}
