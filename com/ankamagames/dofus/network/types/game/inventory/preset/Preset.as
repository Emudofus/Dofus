package com.ankamagames.dofus.network.types.game.inventory.preset
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class Preset implements INetworkType 
    {

        public static const protocolId:uint = 355;

        public var presetId:uint = 0;
        public var symbolId:uint = 0;
        public var mount:Boolean = false;
        public var objects:Vector.<PresetItem>;

        public function Preset()
        {
            this.objects = new Vector.<PresetItem>();
            super();
        }

        public function getTypeId():uint
        {
            return (355);
        }

        public function initPreset(presetId:uint=0, symbolId:uint=0, mount:Boolean=false, objects:Vector.<PresetItem>=null):Preset
        {
            this.presetId = presetId;
            this.symbolId = symbolId;
            this.mount = mount;
            this.objects = objects;
            return (this);
        }

        public function reset():void
        {
            this.presetId = 0;
            this.symbolId = 0;
            this.mount = false;
            this.objects = new Vector.<PresetItem>();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_Preset(output);
        }

        public function serializeAs_Preset(output:ICustomDataOutput):void
        {
            if (this.presetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.presetId) + ") on element presetId.")));
            };
            output.writeByte(this.presetId);
            if (this.symbolId < 0)
            {
                throw (new Error((("Forbidden value (" + this.symbolId) + ") on element symbolId.")));
            };
            output.writeByte(this.symbolId);
            output.writeBoolean(this.mount);
            output.writeShort(this.objects.length);
            var _i4:uint;
            while (_i4 < this.objects.length)
            {
                (this.objects[_i4] as PresetItem).serializeAs_PresetItem(output);
                _i4++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_Preset(input);
        }

        public function deserializeAs_Preset(input:ICustomDataInput):void
        {
            var _item4:PresetItem;
            this.presetId = input.readByte();
            if (this.presetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.presetId) + ") on element of Preset.presetId.")));
            };
            this.symbolId = input.readByte();
            if (this.symbolId < 0)
            {
                throw (new Error((("Forbidden value (" + this.symbolId) + ") on element of Preset.symbolId.")));
            };
            this.mount = input.readBoolean();
            var _objectsLen:uint = input.readUnsignedShort();
            var _i4:uint;
            while (_i4 < _objectsLen)
            {
                _item4 = new PresetItem();
                _item4.deserialize(input);
                this.objects.push(_item4);
                _i4++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.inventory.preset

