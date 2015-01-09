package com.ankamagames.dofus.network.messages.game.inventory.storage
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class StorageKamasUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5645;

        private var _isInitialized:Boolean = false;
        public var kamasTotal:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5645);
        }

        public function initStorageKamasUpdateMessage(kamasTotal:int=0):StorageKamasUpdateMessage
        {
            this.kamasTotal = kamasTotal;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.kamasTotal = 0;
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
            this.serializeAs_StorageKamasUpdateMessage(output);
        }

        public function serializeAs_StorageKamasUpdateMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.kamasTotal);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_StorageKamasUpdateMessage(input);
        }

        public function deserializeAs_StorageKamasUpdateMessage(input:ICustomDataInput):void
        {
            this.kamasTotal = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.storage

