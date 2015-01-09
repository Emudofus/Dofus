package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class GameContextRemoveMultipleElementsWithEventsMessage extends GameContextRemoveMultipleElementsMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6416;

        private var _isInitialized:Boolean = false;
        public var elementEventIds:Vector.<uint>;

        public function GameContextRemoveMultipleElementsWithEventsMessage()
        {
            this.elementEventIds = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6416);
        }

        public function initGameContextRemoveMultipleElementsWithEventsMessage(id:Vector.<int>=null, elementEventIds:Vector.<uint>=null):GameContextRemoveMultipleElementsWithEventsMessage
        {
            super.initGameContextRemoveMultipleElementsMessage(id);
            this.elementEventIds = elementEventIds;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.elementEventIds = new Vector.<uint>();
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_GameContextRemoveMultipleElementsWithEventsMessage(output);
        }

        public function serializeAs_GameContextRemoveMultipleElementsWithEventsMessage(output:IDataOutput):void
        {
            super.serializeAs_GameContextRemoveMultipleElementsMessage(output);
            output.writeShort(this.elementEventIds.length);
            var _i1:uint;
            while (_i1 < this.elementEventIds.length)
            {
                if (this.elementEventIds[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.elementEventIds[_i1]) + ") on element 1 (starting at 1) of elementEventIds.")));
                };
                output.writeByte(this.elementEventIds[_i1]);
                _i1++;
            };
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GameContextRemoveMultipleElementsWithEventsMessage(input);
        }

        public function deserializeAs_GameContextRemoveMultipleElementsWithEventsMessage(input:IDataInput):void
        {
            var _val1:uint;
            super.deserialize(input);
            var _elementEventIdsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _elementEventIdsLen)
            {
                _val1 = input.readByte();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of elementEventIds.")));
                };
                this.elementEventIds.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context

