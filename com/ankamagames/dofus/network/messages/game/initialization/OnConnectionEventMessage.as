package com.ankamagames.dofus.network.messages.game.initialization
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class OnConnectionEventMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var eventType:uint = 0;
        public static const protocolId:uint = 5726;

        public function OnConnectionEventMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5726;
        }// end function

        public function initOnConnectionEventMessage(param1:uint = 0) : OnConnectionEventMessage
        {
            this.eventType = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.eventType = 0;
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
            this.serializeAs_OnConnectionEventMessage(param1);
            return;
        }// end function

        public function serializeAs_OnConnectionEventMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.eventType);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_OnConnectionEventMessage(param1);
            return;
        }// end function

        public function deserializeAs_OnConnectionEventMessage(param1:IDataInput) : void
        {
            this.eventType = param1.readByte();
            if (this.eventType < 0)
            {
                throw new Error("Forbidden value (" + this.eventType + ") on element of OnConnectionEventMessage.eventType.");
            }
            return;
        }// end function

    }
}
