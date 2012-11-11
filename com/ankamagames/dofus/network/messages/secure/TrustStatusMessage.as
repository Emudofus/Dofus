package com.ankamagames.dofus.network.messages.secure
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TrustStatusMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var trusted:Boolean = false;
        public static const protocolId:uint = 6267;

        public function TrustStatusMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6267;
        }// end function

        public function initTrustStatusMessage(param1:Boolean = false) : TrustStatusMessage
        {
            this.trusted = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.trusted = false;
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
            this.serializeAs_TrustStatusMessage(param1);
            return;
        }// end function

        public function serializeAs_TrustStatusMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.trusted);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TrustStatusMessage(param1);
            return;
        }// end function

        public function deserializeAs_TrustStatusMessage(param1:IDataInput) : void
        {
            this.trusted = param1.readBoolean();
            return;
        }// end function

    }
}
