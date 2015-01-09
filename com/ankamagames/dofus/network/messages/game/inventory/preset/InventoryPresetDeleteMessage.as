package com.ankamagames.dofus.network.messages.game.inventory.preset
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class InventoryPresetDeleteMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6169;

        private var _isInitialized:Boolean = false;
        public var presetId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6169);
        }

        public function initInventoryPresetDeleteMessage(presetId:uint=0):InventoryPresetDeleteMessage
        {
            this.presetId = presetId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.presetId = 0;
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
            this.serializeAs_InventoryPresetDeleteMessage(output);
        }

        public function serializeAs_InventoryPresetDeleteMessage(output:ICustomDataOutput):void
        {
            if (this.presetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.presetId) + ") on element presetId.")));
            };
            output.writeByte(this.presetId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_InventoryPresetDeleteMessage(input);
        }

        public function deserializeAs_InventoryPresetDeleteMessage(input:ICustomDataInput):void
        {
            this.presetId = input.readByte();
            if (this.presetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.presetId) + ") on element of InventoryPresetDeleteMessage.presetId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.preset

