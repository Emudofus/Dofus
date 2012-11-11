package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class BasicTimeMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var timestamp:uint = 0;
        public var timezoneOffset:int = 0;
        public static const protocolId:uint = 175;

        public function BasicTimeMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 175;
        }// end function

        public function initBasicTimeMessage(param1:uint = 0, param2:int = 0) : BasicTimeMessage
        {
            this.timestamp = param1;
            this.timezoneOffset = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.timestamp = 0;
            this.timezoneOffset = 0;
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
            this.serializeAs_BasicTimeMessage(param1);
            return;
        }// end function

        public function serializeAs_BasicTimeMessage(param1:IDataOutput) : void
        {
            if (this.timestamp < 0)
            {
                throw new Error("Forbidden value (" + this.timestamp + ") on element timestamp.");
            }
            param1.writeInt(this.timestamp);
            param1.writeShort(this.timezoneOffset);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_BasicTimeMessage(param1);
            return;
        }// end function

        public function deserializeAs_BasicTimeMessage(param1:IDataInput) : void
        {
            this.timestamp = param1.readInt();
            if (this.timestamp < 0)
            {
                throw new Error("Forbidden value (" + this.timestamp + ") on element of BasicTimeMessage.timestamp.");
            }
            this.timezoneOffset = param1.readShort();
            return;
        }// end function

    }
}
