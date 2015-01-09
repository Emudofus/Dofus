package com.ankamagames.dofus.network.messages.game.inventory.preset
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.inventory.preset.Preset;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class InventoryPresetUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6171;

        private var _isInitialized:Boolean = false;
        public var preset:Preset;

        public function InventoryPresetUpdateMessage()
        {
            this.preset = new Preset();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6171);
        }

        public function initInventoryPresetUpdateMessage(preset:Preset=null):InventoryPresetUpdateMessage
        {
            this.preset = preset;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.preset = new Preset();
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
            this.serializeAs_InventoryPresetUpdateMessage(output);
        }

        public function serializeAs_InventoryPresetUpdateMessage(output:IDataOutput):void
        {
            this.preset.serializeAs_Preset(output);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_InventoryPresetUpdateMessage(input);
        }

        public function deserializeAs_InventoryPresetUpdateMessage(input:IDataInput):void
        {
            this.preset = new Preset();
            this.preset.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.preset

