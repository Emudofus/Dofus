package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectUseOnCellMessage extends ObjectUseMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var cells:uint = 0;
        public static const protocolId:uint = 3013;

        public function ObjectUseOnCellMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 3013;
        }// end function

        public function initObjectUseOnCellMessage(param1:uint = 0, param2:uint = 0) : ObjectUseOnCellMessage
        {
            super.initObjectUseMessage(param1);
            this.cells = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.cells = 0;
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
            this.serializeAs_ObjectUseOnCellMessage(param1);
            return;
        }// end function

        public function serializeAs_ObjectUseOnCellMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ObjectUseMessage(param1);
            if (this.cells < 0 || this.cells > 559)
            {
                throw new Error("Forbidden value (" + this.cells + ") on element cells.");
            }
            param1.writeShort(this.cells);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectUseOnCellMessage(param1);
            return;
        }// end function

        public function deserializeAs_ObjectUseOnCellMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.cells = param1.readShort();
            if (this.cells < 0 || this.cells > 559)
            {
                throw new Error("Forbidden value (" + this.cells + ") on element of ObjectUseOnCellMessage.cells.");
            }
            return;
        }// end function

    }
}
