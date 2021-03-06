﻿package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItemQuantity;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class ObjectsQuantityMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6206;

        private var _isInitialized:Boolean = false;
        public var objectsUIDAndQty:Vector.<ObjectItemQuantity>;

        public function ObjectsQuantityMessage()
        {
            this.objectsUIDAndQty = new Vector.<ObjectItemQuantity>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6206);
        }

        public function initObjectsQuantityMessage(objectsUIDAndQty:Vector.<ObjectItemQuantity>=null):ObjectsQuantityMessage
        {
            this.objectsUIDAndQty = objectsUIDAndQty;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectsUIDAndQty = new Vector.<ObjectItemQuantity>();
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
            this.serializeAs_ObjectsQuantityMessage(output);
        }

        public function serializeAs_ObjectsQuantityMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.objectsUIDAndQty.length);
            var _i1:uint;
            while (_i1 < this.objectsUIDAndQty.length)
            {
                (this.objectsUIDAndQty[_i1] as ObjectItemQuantity).serializeAs_ObjectItemQuantity(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectsQuantityMessage(input);
        }

        public function deserializeAs_ObjectsQuantityMessage(input:ICustomDataInput):void
        {
            var _item1:ObjectItemQuantity;
            var _objectsUIDAndQtyLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _objectsUIDAndQtyLen)
            {
                _item1 = new ObjectItemQuantity();
                _item1.deserialize(input);
                this.objectsUIDAndQty.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

