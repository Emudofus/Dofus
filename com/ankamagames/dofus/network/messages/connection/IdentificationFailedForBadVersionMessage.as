package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.dofus.network.types.version.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class IdentificationFailedForBadVersionMessage extends IdentificationFailedMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var requiredVersion:Version;
        public static const protocolId:uint = 21;

        public function IdentificationFailedForBadVersionMessage()
        {
            this.requiredVersion = new Version();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 21;
        }// end function

        public function initIdentificationFailedForBadVersionMessage(param1:uint = 99, param2:Version = null) : IdentificationFailedForBadVersionMessage
        {
            super.initIdentificationFailedMessage(param1);
            this.requiredVersion = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.requiredVersion = new Version();
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
            this.serializeAs_IdentificationFailedForBadVersionMessage(param1);
            return;
        }// end function

        public function serializeAs_IdentificationFailedForBadVersionMessage(param1:IDataOutput) : void
        {
            super.serializeAs_IdentificationFailedMessage(param1);
            this.requiredVersion.serializeAs_Version(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_IdentificationFailedForBadVersionMessage(param1);
            return;
        }// end function

        public function deserializeAs_IdentificationFailedForBadVersionMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.requiredVersion = new Version();
            this.requiredVersion.deserialize(param1);
            return;
        }// end function

    }
}
