package com.ankamagames.dofus.network.messages.game.context.roleplay.document
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class DocumentReadingBeginMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var documentId:uint = 0;
        public static const protocolId:uint = 5675;

        public function DocumentReadingBeginMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5675;
        }// end function

        public function initDocumentReadingBeginMessage(param1:uint = 0) : DocumentReadingBeginMessage
        {
            this.documentId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.documentId = 0;
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
            this.serializeAs_DocumentReadingBeginMessage(param1);
            return;
        }// end function

        public function serializeAs_DocumentReadingBeginMessage(param1:IDataOutput) : void
        {
            if (this.documentId < 0)
            {
                throw new Error("Forbidden value (" + this.documentId + ") on element documentId.");
            }
            param1.writeShort(this.documentId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_DocumentReadingBeginMessage(param1);
            return;
        }// end function

        public function deserializeAs_DocumentReadingBeginMessage(param1:IDataInput) : void
        {
            this.documentId = param1.readShort();
            if (this.documentId < 0)
            {
                throw new Error("Forbidden value (" + this.documentId + ") on element of DocumentReadingBeginMessage.documentId.");
            }
            return;
        }// end function

    }
}
