﻿package com.ankamagames.dofus.network.messages.game.inventory.items
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
    public class ObjectsDeletedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6034;

        private var _isInitialized:Boolean = false;
        public var objectUID:Vector.<uint>;

        public function ObjectsDeletedMessage()
        {
            this.objectUID = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6034);
        }

        public function initObjectsDeletedMessage(objectUID:Vector.<uint>=null):ObjectsDeletedMessage
        {
            this.objectUID = objectUID;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectUID = new Vector.<uint>();
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
            this.serializeAs_ObjectsDeletedMessage(output);
        }

        public function serializeAs_ObjectsDeletedMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.objectUID.length);
            var _i1:uint;
            while (_i1 < this.objectUID.length)
            {
                if (this.objectUID[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.objectUID[_i1]) + ") on element 1 (starting at 1) of objectUID.")));
                };
                output.writeVarInt(this.objectUID[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectsDeletedMessage(input);
        }

        public function deserializeAs_ObjectsDeletedMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _objectUIDLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _objectUIDLen)
            {
                _val1 = input.readVarUhInt();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of objectUID.")));
                };
                this.objectUID.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

