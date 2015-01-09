package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.inventory.preset.Preset;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class InventoryContentAndPresetMessage extends InventoryContentMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6162;

        private var _isInitialized:Boolean = false;
        public var presets:Vector.<Preset>;

        public function InventoryContentAndPresetMessage()
        {
            this.presets = new Vector.<Preset>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6162);
        }

        public function initInventoryContentAndPresetMessage(objects:Vector.<ObjectItem>=null, kamas:uint=0, presets:Vector.<Preset>=null):InventoryContentAndPresetMessage
        {
            super.initInventoryContentMessage(objects, kamas);
            this.presets = presets;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.presets = new Vector.<Preset>();
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
            this.serializeAs_InventoryContentAndPresetMessage(output);
        }

        public function serializeAs_InventoryContentAndPresetMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_InventoryContentMessage(output);
            output.writeShort(this.presets.length);
            var _i1:uint;
            while (_i1 < this.presets.length)
            {
                (this.presets[_i1] as Preset).serializeAs_Preset(output);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_InventoryContentAndPresetMessage(input);
        }

        public function deserializeAs_InventoryContentAndPresetMessage(input:ICustomDataInput):void
        {
            var _item1:Preset;
            super.deserialize(input);
            var _presetsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _presetsLen)
            {
                _item1 = new Preset();
                _item1.deserialize(input);
                this.presets.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

