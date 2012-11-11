package com.ankamagames.dofus.network.messages.game.subscriber
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SubscriptionLimitationMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var reason:uint = 0;
        public static const protocolId:uint = 5542;

        public function SubscriptionLimitationMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5542;
        }// end function

        public function initSubscriptionLimitationMessage(param1:uint = 0) : SubscriptionLimitationMessage
        {
            this.reason = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.reason = 0;
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
            this.serializeAs_SubscriptionLimitationMessage(param1);
            return;
        }// end function

        public function serializeAs_SubscriptionLimitationMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.reason);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SubscriptionLimitationMessage(param1);
            return;
        }// end function

        public function deserializeAs_SubscriptionLimitationMessage(param1:IDataInput) : void
        {
            this.reason = param1.readByte();
            if (this.reason < 0)
            {
                throw new Error("Forbidden value (" + this.reason + ") on element of SubscriptionLimitationMessage.reason.");
            }
            return;
        }// end function

    }
}
