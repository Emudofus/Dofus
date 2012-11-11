package com.ankamagames.dofus.network.messages.updater.parts
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class DownloadSetSpeedRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var downloadSpeed:uint = 0;
        public static const protocolId:uint = 1512;

        public function DownloadSetSpeedRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 1512;
        }// end function

        public function initDownloadSetSpeedRequestMessage(param1:uint = 0) : DownloadSetSpeedRequestMessage
        {
            this.downloadSpeed = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.downloadSpeed = 0;
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
            this.serializeAs_DownloadSetSpeedRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_DownloadSetSpeedRequestMessage(param1:IDataOutput) : void
        {
            if (this.downloadSpeed < 1 || this.downloadSpeed > 10)
            {
                throw new Error("Forbidden value (" + this.downloadSpeed + ") on element downloadSpeed.");
            }
            param1.writeByte(this.downloadSpeed);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_DownloadSetSpeedRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_DownloadSetSpeedRequestMessage(param1:IDataInput) : void
        {
            this.downloadSpeed = param1.readByte();
            if (this.downloadSpeed < 1 || this.downloadSpeed > 10)
            {
                throw new Error("Forbidden value (" + this.downloadSpeed + ") on element of DownloadSetSpeedRequestMessage.downloadSpeed.");
            }
            return;
        }// end function

    }
}
