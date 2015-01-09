package com.ankamagames.dofus.network.messages.game.context.roleplay.objects
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
    public class ObjectGroundRemovedMultipleMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5944;

        private var _isInitialized:Boolean = false;
        public var cells:Vector.<uint>;

        public function ObjectGroundRemovedMultipleMessage()
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
            return (5944);
        }

        public function initObjectGroundRemovedMultipleMessage(cells:Vector.<uint>=null):ObjectGroundRemovedMultipleMessage
        {
            this.cells = cells;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
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
            this.serializeAs_ObjectGroundRemovedMultipleMessage(output);
        }

        public function serializeAs_ObjectGroundRemovedMultipleMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.cells.length);
            var _i1:uint;
            while (_i1 < this.cells.length)
            {
                if ((((this.cells[_i1] < 0)) || ((this.cells[_i1] > 559))))
                {
                    throw (new Error((("Forbidden value (" + this.cells[_i1]) + ") on element 1 (starting at 1) of cells.")));
                };
                output.writeVarShort(this.cells[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectGroundRemovedMultipleMessage(input);
        }

        public function deserializeAs_ObjectGroundRemovedMultipleMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _cellsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _cellsLen)
            {
                _val1 = input.readVarUhShort();
                if ((((_val1 < 0)) || ((_val1 > 559))))
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of cells.")));
                };
                this.cells.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.objects

