package com.ankamagames.dofus.network.messages.updater.parts
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class DownloadErrorMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var errorId:uint = 0;
        public var message:String = "";
        public var helpUrl:String = "";
        public static const protocolId:uint = 1513;

        public function DownloadErrorMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 1513;
        }// end function

        public function initDownloadErrorMessage(param1:uint = 0, param2:String = "", param3:String = "") : DownloadErrorMessage
        {
            this.errorId = param1;
            this.message = param2;
            this.helpUrl = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.errorId = 0;
            this.message = "";
            this.helpUrl = "";
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
            this.serializeAs_DownloadErrorMessage(param1);
            return;
        }// end function

        public function serializeAs_DownloadErrorMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.errorId);
            param1.writeUTF(this.message);
            param1.writeUTF(this.helpUrl);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_DownloadErrorMessage(param1);
            return;
        }// end function

        public function deserializeAs_DownloadErrorMessage(param1:IDataInput) : void
        {
            this.errorId = param1.readByte();
            if (this.errorId < 0)
            {
                throw new Error("Forbidden value (" + this.errorId + ") on element of DownloadErrorMessage.errorId.");
            }
            this.message = param1.readUTF();
            this.helpUrl = param1.readUTF();
            return;
        }// end function

    }
}
