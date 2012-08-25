package com.ankamagames.dofus.network.types.game.inventory.preset
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class Preset extends Object implements INetworkType
    {
        public var presetId:uint = 0;
        public var symbolId:uint = 0;
        public var mount:Boolean = false;
        public var objects:Vector.<PresetItem>;
        public static const protocolId:uint = 355;

        public function Preset()
        {
            this.objects = new Vector.<PresetItem>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 355;
        }// end function

        public function initPreset(param1:uint = 0, param2:uint = 0, param3:Boolean = false, param4:Vector.<PresetItem> = null) : Preset
        {
            this.presetId = param1;
            this.symbolId = param2;
            this.mount = param3;
            this.objects = param4;
            return this;
        }// end function

        public function reset() : void
        {
            this.presetId = 0;
            this.symbolId = 0;
            this.mount = false;
            this.objects = new Vector.<PresetItem>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_Preset(param1);
            return;
        }// end function

        public function serializeAs_Preset(param1:IDataOutput) : void
        {
            if (this.presetId < 0)
            {
                throw new Error("Forbidden value (" + this.presetId + ") on element presetId.");
            }
            param1.writeByte(this.presetId);
            if (this.symbolId < 0)
            {
                throw new Error("Forbidden value (" + this.symbolId + ") on element symbolId.");
            }
            param1.writeByte(this.symbolId);
            param1.writeBoolean(this.mount);
            param1.writeShort(this.objects.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.objects.length)
            {
                
                (this.objects[_loc_2] as PresetItem).serializeAs_PresetItem(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_Preset(param1);
            return;
        }// end function

        public function deserializeAs_Preset(param1:IDataInput) : void
        {
            var _loc_4:PresetItem = null;
            this.presetId = param1.readByte();
            if (this.presetId < 0)
            {
                throw new Error("Forbidden value (" + this.presetId + ") on element of Preset.presetId.");
            }
            this.symbolId = param1.readByte();
            if (this.symbolId < 0)
            {
                throw new Error("Forbidden value (" + this.symbolId + ") on element of Preset.symbolId.");
            }
            this.mount = param1.readBoolean();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new PresetItem();
                _loc_4.deserialize(param1);
                this.objects.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
