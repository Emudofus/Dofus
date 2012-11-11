package com.ankamagames.dofus.network.messages.web.krosmaster
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class KrosmasterTransferMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var uid:String = "";
        public var failure:uint = 0;
        public static const protocolId:uint = 6348;

        public function KrosmasterTransferMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6348;
        }// end function

        public function initKrosmasterTransferMessage(param1:String = "", param2:uint = 0) : KrosmasterTransferMessage
        {
            this.uid = param1;
            this.failure = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.uid = "";
            this.failure = 0;
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
            this.serializeAs_KrosmasterTransferMessage(param1);
            return;
        }// end function

        public function serializeAs_KrosmasterTransferMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.uid);
            param1.writeByte(this.failure);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_KrosmasterTransferMessage(param1);
            return;
        }// end function

        public function deserializeAs_KrosmasterTransferMessage(param1:IDataInput) : void
        {
            this.uid = param1.readUTF();
            this.failure = param1.readByte();
            if (this.failure < 0)
            {
                throw new Error("Forbidden value (" + this.failure + ") on element of KrosmasterTransferMessage.failure.");
            }
            return;
        }// end function

    }
}
