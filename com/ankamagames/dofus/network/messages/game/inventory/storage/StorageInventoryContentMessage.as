package com.ankamagames.dofus.network.messages.game.inventory.storage
{
    import com.ankamagames.dofus.network.messages.game.inventory.items.InventoryContentMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class StorageInventoryContentMessage extends InventoryContentMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5646;

        private var _isInitialized:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5646);
        }

        public function initStorageInventoryContentMessage(objects:Vector.<ObjectItem>=null, kamas:uint=0):StorageInventoryContentMessage
        {
            super.initInventoryContentMessage(objects, kamas);
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_StorageInventoryContentMessage(output);
        }

        public function serializeAs_StorageInventoryContentMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_InventoryContentMessage(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_StorageInventoryContentMessage(input);
        }

        public function deserializeAs_StorageInventoryContentMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.storage

