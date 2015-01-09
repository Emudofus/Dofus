package com.ankamagames.dofus.network.messages.game.inventory.storage
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class StorageObjectsUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6036;

        private var _isInitialized:Boolean = false;
        public var objectList:Vector.<ObjectItem>;

        public function StorageObjectsUpdateMessage()
        {
            this.objectList = new Vector.<ObjectItem>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6036);
        }

        public function initStorageObjectsUpdateMessage(objectList:Vector.<ObjectItem>=null):StorageObjectsUpdateMessage
        {
            this.objectList = objectList;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectList = new Vector.<ObjectItem>();
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
            this.serializeAs_StorageObjectsUpdateMessage(output);
        }

        public function serializeAs_StorageObjectsUpdateMessage(output:IDataOutput):void
        {
            output.writeShort(this.objectList.length);
            var _i1:uint;
            while (_i1 < this.objectList.length)
            {
                (this.objectList[_i1] as ObjectItem).serializeAs_ObjectItem(output);
                _i1++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_StorageObjectsUpdateMessage(input);
        }

        public function deserializeAs_StorageObjectsUpdateMessage(input:IDataInput):void
        {
            var _item1:ObjectItem;
            var _objectListLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _objectListLen)
            {
                _item1 = new ObjectItem();
                _item1.deserialize(input);
                this.objectList.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.storage

