package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PaddockMoveItemRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var oldCellId:uint = 0;
        public var newCellId:uint = 0;
        public static const protocolId:uint = 6052;

        public function PaddockMoveItemRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6052;
        }// end function

        public function initPaddockMoveItemRequestMessage(param1:uint = 0, param2:uint = 0) : PaddockMoveItemRequestMessage
        {
            this.oldCellId = param1;
            this.newCellId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.oldCellId = 0;
            this.newCellId = 0;
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
            this.serializeAs_PaddockMoveItemRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_PaddockMoveItemRequestMessage(param1:IDataOutput) : void
        {
            if (this.oldCellId < 0 || this.oldCellId > 559)
            {
                throw new Error("Forbidden value (" + this.oldCellId + ") on element oldCellId.");
            }
            param1.writeShort(this.oldCellId);
            if (this.newCellId < 0 || this.newCellId > 559)
            {
                throw new Error("Forbidden value (" + this.newCellId + ") on element newCellId.");
            }
            param1.writeShort(this.newCellId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PaddockMoveItemRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_PaddockMoveItemRequestMessage(param1:IDataInput) : void
        {
            this.oldCellId = param1.readShort();
            if (this.oldCellId < 0 || this.oldCellId > 559)
            {
                throw new Error("Forbidden value (" + this.oldCellId + ") on element of PaddockMoveItemRequestMessage.oldCellId.");
            }
            this.newCellId = param1.readShort();
            if (this.newCellId < 0 || this.newCellId > 559)
            {
                throw new Error("Forbidden value (" + this.newCellId + ") on element of PaddockMoveItemRequestMessage.newCellId.");
            }
            return;
        }// end function

    }
}
