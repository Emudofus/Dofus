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
    public class GameMapMovementRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 950;

        private var _isInitialized:Boolean = false;
        public var keyMovements:Vector.<uint>;
        public var mapId:uint = 0;

        public function GameMapMovementRequestMessage()
        {
            this.keyMovements = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (950);
        }

        public function initGameMapMovementRequestMessage(keyMovements:Vector.<uint>=null, mapId:uint=0):GameMapMovementRequestMessage
        {
            this.keyMovements = keyMovements;
            this.mapId = mapId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.keyMovements = new Vector.<uint>();
            this.mapId = 0;
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            if (HASH_FUNCTION != null)
            {
                HASH_FUNCTION(data);
            };
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_GameMapMovementRequestMessage(output);
        }

        public function serializeAs_GameMapMovementRequestMessage(output:IDataOutput):void
        {
            output.writeShort(this.keyMovements.length);
            var _i1:uint;
            while (_i1 < this.keyMovements.length)
            {
                if (this.keyMovements[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.keyMovements[_i1]) + ") on element 1 (starting at 1) of keyMovements.")));
                };
                output.writeShort(this.keyMovements[_i1]);
                _i1++;
            };
            if (this.mapId < 0)
            {
                throw (new Error((("Forbidden value (" + this.mapId) + ") on element mapId.")));
            };
            output.writeInt(this.mapId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GameMapMovementRequestMessage(input);
        }

        public function deserializeAs_GameMapMovementRequestMessage(input:IDataInput):void
        {
            var _val1:uint;
            var _keyMovementsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _keyMovementsLen)
            {
                _val1 = input.readShort();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of keyMovements.")));
                };
                this.keyMovements.push(_val1);
                _i1++;
            };
            this.mapId = input.readInt();
            if (this.mapId < 0)
            {
                throw (new Error((("Forbidden value (" + this.mapId) + ") on element of GameMapMovementRequestMessage.mapId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context

