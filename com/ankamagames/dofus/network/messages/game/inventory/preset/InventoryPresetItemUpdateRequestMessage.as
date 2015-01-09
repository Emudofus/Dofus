package com.ankamagames.dofus.network.messages.game.inventory.preset
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class InventoryPresetItemUpdateRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6210;

        private var _isInitialized:Boolean = false;
        public var presetId:uint = 0;
        public var position:uint = 63;
        public var objUid:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6210);
        }

        public function initInventoryPresetItemUpdateRequestMessage(presetId:uint=0, position:uint=63, objUid:uint=0):InventoryPresetItemUpdateRequestMessage
        {
            this.presetId = presetId;
            this.position = position;
            this.objUid = objUid;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.presetId = 0;
            this.position = 63;
            this.objUid = 0;
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
            this.serializeAs_InventoryPresetItemUpdateRequestMessage(output);
        }

        public function serializeAs_InventoryPresetItemUpdateRequestMessage(output:IDataOutput):void
        {
            if (this.presetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.presetId) + ") on element presetId.")));
            };
            output.writeByte(this.presetId);
            output.writeByte(this.position);
            if (this.objUid < 0)
            {
                throw (new Error((("Forbidden value (" + this.objUid) + ") on element objUid.")));
            };
            output.writeInt(this.objUid);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_InventoryPresetItemUpdateRequestMessage(input);
        }

        public function deserializeAs_InventoryPresetItemUpdateRequestMessage(input:IDataInput):void
        {
            this.presetId = input.readByte();
            if (this.presetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.presetId) + ") on element of InventoryPresetItemUpdateRequestMessage.presetId.")));
            };
            this.position = input.readUnsignedByte();
            if ((((this.position < 0)) || ((this.position > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.position) + ") on element of InventoryPresetItemUpdateRequestMessage.position.")));
            };
            this.objUid = input.readInt();
            if (this.objUid < 0)
            {
                throw (new Error((("Forbidden value (" + this.objUid) + ") on element of InventoryPresetItemUpdateRequestMessage.objUid.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.preset

