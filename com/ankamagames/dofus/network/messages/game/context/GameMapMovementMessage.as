package com.ankamagames.dofus.network.messages.game.context
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
    public class GameMapMovementMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 951;

        private var _isInitialized:Boolean = false;
        public var keyMovements:Vector.<uint>;
        public var actorId:int = 0;

        public function GameMapMovementMessage()
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
            return (951);
        }

        public function initGameMapMovementMessage(keyMovements:Vector.<uint>=null, actorId:int=0):GameMapMovementMessage
        {
            this.keyMovements = keyMovements;
            this.actorId = actorId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.keyMovements = new Vector.<uint>();
            this.actorId = 0;
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
            this.serializeAs_GameMapMovementMessage(output);
        }

        public function serializeAs_GameMapMovementMessage(output:ICustomDataOutput):void
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
            output.writeInt(this.actorId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameMapMovementMessage(input);
        }

        public function deserializeAs_GameMapMovementMessage(input:ICustomDataInput):void
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
            this.actorId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context

