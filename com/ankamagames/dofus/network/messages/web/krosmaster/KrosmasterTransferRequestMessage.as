package com.ankamagames.dofus.network.messages.web.krosmaster
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class KrosmasterTransferRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var uid:String = "";
        public static const protocolId:uint = 6349;

        public function KrosmasterTransferRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6349;
        }// end function

        public function initKrosmasterTransferRequestMessage(param1:String = "") : KrosmasterTransferRequestMessage
        {
            this.uid = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.uid = "";
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
            this.serializeAs_KrosmasterTransferRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_KrosmasterTransferRequestMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.uid);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_KrosmasterTransferRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_KrosmasterTransferRequestMessage(param1:IDataInput) : void
        {
            this.uid = param1.readUTF();
            return;
        }// end function

    }
}
