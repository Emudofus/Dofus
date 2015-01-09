package com.ankamagames.dofus.network.messages.debug
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class DebugHighlightCellsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 2001;

        private var _isInitialized:Boolean = false;
        public var color:int = 0;
        public var cells:Vector.<uint>;

        public function DebugHighlightCellsMessage()
        {
            this.cells = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (2001);
        }

        public function initDebugHighlightCellsMessage(color:int=0, cells:Vector.<uint>=null):DebugHighlightCellsMessage
        {
            this.color = color;
            this.cells = cells;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.color = 0;
            this.cells = new Vector.<uint>();
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_DebugHighlightCellsMessage(output);
        }

        public function serializeAs_DebugHighlightCellsMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.color);
            output.writeShort(this.cells.length);
            var _i2:uint;
            while (_i2 < this.cells.length)
            {
                if ((((this.cells[_i2] < 0)) || ((this.cells[_i2] > 559))))
                {
                    throw (new Error((("Forbidden value (" + this.cells[_i2]) + ") on element 2 (starting at 1) of cells.")));
                };
                output.writeVarShort(this.cells[_i2]);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_DebugHighlightCellsMessage(input);
        }

        public function deserializeAs_DebugHighlightCellsMessage(input:ICustomDataInput):void
        {
            var _val2:uint;
            this.color = input.readInt();
            var _cellsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _cellsLen)
            {
                _val2 = input.readVarUhShort();
                if ((((_val2 < 0)) || ((_val2 > 559))))
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of cells.")));
                };
                this.cells.push(_val2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.debug

