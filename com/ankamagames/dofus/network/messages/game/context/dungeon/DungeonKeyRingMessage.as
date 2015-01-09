package com.ankamagames.dofus.network.messages.game.context.dungeon
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class DungeonKeyRingMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6299;

        private var _isInitialized:Boolean = false;
        public var availables:Vector.<uint>;
        public var unavailables:Vector.<uint>;

        public function DungeonKeyRingMessage()
        {
            this.availables = new Vector.<uint>();
            this.unavailables = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6299);
        }

        public function initDungeonKeyRingMessage(availables:Vector.<uint>=null, unavailables:Vector.<uint>=null):DungeonKeyRingMessage
        {
            this.availables = availables;
            this.unavailables = unavailables;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.availables = new Vector.<uint>();
            this.unavailables = new Vector.<uint>();
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
            this.serializeAs_DungeonKeyRingMessage(output);
        }

        public function serializeAs_DungeonKeyRingMessage(output:IDataOutput):void
        {
            output.writeShort(this.availables.length);
            var _i1:uint;
            while (_i1 < this.availables.length)
            {
                if (this.availables[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.availables[_i1]) + ") on element 1 (starting at 1) of availables.")));
                };
                output.writeShort(this.availables[_i1]);
                _i1++;
            };
            output.writeShort(this.unavailables.length);
            var _i2:uint;
            while (_i2 < this.unavailables.length)
            {
                if (this.unavailables[_i2] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.unavailables[_i2]) + ") on element 2 (starting at 1) of unavailables.")));
                };
                output.writeShort(this.unavailables[_i2]);
                _i2++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_DungeonKeyRingMessage(input);
        }

        public function deserializeAs_DungeonKeyRingMessage(input:IDataInput):void
        {
            var _val1:uint;
            var _val2:uint;
            var _availablesLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _availablesLen)
            {
                _val1 = input.readShort();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of availables.")));
                };
                this.availables.push(_val1);
                _i1++;
            };
            var _unavailablesLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _unavailablesLen)
            {
                _val2 = input.readShort();
                if (_val2 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of unavailables.")));
                };
                this.unavailables.push(_val2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.dungeon

