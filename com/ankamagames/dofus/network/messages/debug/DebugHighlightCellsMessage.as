package com.ankamagames.dofus.network.messages.debug
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class DebugHighlightCellsMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var color:int = 0;
        public var cells:Vector.<uint>;
        public static const protocolId:uint = 2001;

        public function DebugHighlightCellsMessage()
        {
            this.cells = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 2001;
        }// end function

        public function initDebugHighlightCellsMessage(param1:int = 0, param2:Vector.<uint> = null) : DebugHighlightCellsMessage
        {
            this.color = param1;
            this.cells = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.color = 0;
            this.cells = new Vector.<uint>;
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
            this.serializeAs_DebugHighlightCellsMessage(param1);
            return;
        }// end function

        public function serializeAs_DebugHighlightCellsMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.color);
            param1.writeShort(this.cells.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.cells.length)
            {
                
                if (this.cells[_loc_2] < 0 || this.cells[_loc_2] > 559)
                {
                    throw new Error("Forbidden value (" + this.cells[_loc_2] + ") on element 2 (starting at 1) of cells.");
                }
                param1.writeShort(this.cells[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_DebugHighlightCellsMessage(param1);
            return;
        }// end function

        public function deserializeAs_DebugHighlightCellsMessage(param1:IDataInput) : void
        {
            var _loc_4:* = 0;
            this.color = param1.readInt();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readShort();
                if (_loc_4 < 0 || _loc_4 > 559)
                {
                    throw new Error("Forbidden value (" + _loc_4 + ") on elements of cells.");
                }
                this.cells.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
