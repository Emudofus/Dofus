package com.ankamagames.dofus.network.messages.game.inventory.storage
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
    public class StorageObjectsRemoveMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6035;

        private var _isInitialized:Boolean = false;
        public var objectUIDList:Vector.<uint>;

        public function StorageObjectsRemoveMessage()
        {
            this.objectUIDList = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6035);
        }

        public function initStorageObjectsRemoveMessage(objectUIDList:Vector.<uint>=null):StorageObjectsRemoveMessage
        {
            this.objectUIDList = objectUIDList;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectUIDList = new Vector.<uint>();
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
            this.serializeAs_StorageObjectsRemoveMessage(output);
        }

        public function serializeAs_StorageObjectsRemoveMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.objectUIDList.length);
            var _i1:uint;
            while (_i1 < this.objectUIDList.length)
            {
                if (this.objectUIDList[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.objectUIDList[_i1]) + ") on element 1 (starting at 1) of objectUIDList.")));
                };
                output.writeVarInt(this.objectUIDList[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_StorageObjectsRemoveMessage(input);
        }

        public function deserializeAs_StorageObjectsRemoveMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _objectUIDListLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _objectUIDListLen)
            {
                _val1 = input.readVarUhInt();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of objectUIDList.")));
                };
                this.objectUIDList.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.storage

