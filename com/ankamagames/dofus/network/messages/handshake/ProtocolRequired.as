package com.ankamagames.dofus.network.messages.handshake
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ProtocolRequired extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var requiredVersion:uint = 0;
        public var currentVersion:uint = 0;
        public static const protocolId:uint = 1;

        public function ProtocolRequired()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 1;
        }// end function

        public function initProtocolRequired(param1:uint = 0, param2:uint = 0) : ProtocolRequired
        {
            this.requiredVersion = param1;
            this.currentVersion = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.requiredVersion = 0;
            this.currentVersion = 0;
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
            this.serializeAs_ProtocolRequired(param1);
            return;
        }// end function

        public function serializeAs_ProtocolRequired(param1:IDataOutput) : void
        {
            if (this.requiredVersion < 0)
            {
                throw new Error("Forbidden value (" + this.requiredVersion + ") on element requiredVersion.");
            }
            param1.writeInt(this.requiredVersion);
            if (this.currentVersion < 0)
            {
                throw new Error("Forbidden value (" + this.currentVersion + ") on element currentVersion.");
            }
            param1.writeInt(this.currentVersion);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ProtocolRequired(param1);
            return;
        }// end function

        public function deserializeAs_ProtocolRequired(param1:IDataInput) : void
        {
            this.requiredVersion = param1.readInt();
            if (this.requiredVersion < 0)
            {
                throw new Error("Forbidden value (" + this.requiredVersion + ") on element of ProtocolRequired.requiredVersion.");
            }
            this.currentVersion = param1.readInt();
            if (this.currentVersion < 0)
            {
                throw new Error("Forbidden value (" + this.currentVersion + ") on element of ProtocolRequired.currentVersion.");
            }
            return;
        }// end function

    }
}
