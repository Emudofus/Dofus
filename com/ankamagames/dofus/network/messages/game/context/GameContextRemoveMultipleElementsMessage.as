package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class GameContextRemoveMultipleElementsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 252;

        private var _isInitialized:Boolean = false;
        public var id:Vector.<int>;

        public function GameContextRemoveMultipleElementsMessage()
        {
            this.id = new Vector.<int>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (252);
        }

        public function initGameContextRemoveMultipleElementsMessage(id:Vector.<int>=null):GameContextRemoveMultipleElementsMessage
        {
            this.id = id;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.id = new Vector.<int>();
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

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_GameContextRemoveMultipleElementsMessage(output);
        }

        public function serializeAs_GameContextRemoveMultipleElementsMessage(output:IDataOutput):void
        {
            output.writeShort(this.id.length);
            var _i1:uint;
            while (_i1 < this.id.length)
            {
                output.writeInt(this.id[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GameContextRemoveMultipleElementsMessage(input);
        }

        public function deserializeAs_GameContextRemoveMultipleElementsMessage(input:IDataInput):void
        {
            var _val1:int;
            var _idLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _idLen)
            {
                _val1 = input.readInt();
                this.id.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context

