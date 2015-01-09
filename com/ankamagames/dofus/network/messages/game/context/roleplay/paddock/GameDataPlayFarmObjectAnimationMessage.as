package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class GameDataPlayFarmObjectAnimationMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6026;

        private var _isInitialized:Boolean = false;
        public var cellId:Vector.<uint>;

        public function GameDataPlayFarmObjectAnimationMessage()
        {
            this.cellId = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6026);
        }

        public function initGameDataPlayFarmObjectAnimationMessage(cellId:Vector.<uint>=null):GameDataPlayFarmObjectAnimationMessage
        {
            this.cellId = cellId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.cellId = new Vector.<uint>();
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
            this.serializeAs_GameDataPlayFarmObjectAnimationMessage(output);
        }

        public function serializeAs_GameDataPlayFarmObjectAnimationMessage(output:IDataOutput):void
        {
            output.writeShort(this.cellId.length);
            var _i1:uint;
            while (_i1 < this.cellId.length)
            {
                if ((((this.cellId[_i1] < 0)) || ((this.cellId[_i1] > 559))))
                {
                    throw (new Error((("Forbidden value (" + this.cellId[_i1]) + ") on element 1 (starting at 1) of cellId.")));
                };
                output.writeShort(this.cellId[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GameDataPlayFarmObjectAnimationMessage(input);
        }

        public function deserializeAs_GameDataPlayFarmObjectAnimationMessage(input:IDataInput):void
        {
            var _val1:uint;
            var _cellIdLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _cellIdLen)
            {
                _val1 = input.readShort();
                if ((((_val1 < 0)) || ((_val1 > 559))))
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of cellId.")));
                };
                this.cellId.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock

