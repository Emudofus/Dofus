package com.ankamagames.dofus.network.messages.game.inventory.storage
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class StorageObjectUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5647;

        private var _isInitialized:Boolean = false;
        public var object:ObjectItem;

        public function StorageObjectUpdateMessage()
        {
            this.object = new ObjectItem();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5647);
        }

        public function initStorageObjectUpdateMessage(object:ObjectItem=null):StorageObjectUpdateMessage
        {
            this.object = object;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.object = new ObjectItem();
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
            this.serializeAs_StorageObjectUpdateMessage(output);
        }

        public function serializeAs_StorageObjectUpdateMessage(output:ICustomDataOutput):void
        {
            this.object.serializeAs_ObjectItem(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_StorageObjectUpdateMessage(input);
        }

        public function deserializeAs_StorageObjectUpdateMessage(input:ICustomDataInput):void
        {
            this.object = new ObjectItem();
            this.object.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.storage

