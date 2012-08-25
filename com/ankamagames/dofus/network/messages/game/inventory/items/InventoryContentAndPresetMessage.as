package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.inventory.preset.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InventoryContentAndPresetMessage extends InventoryContentMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var presets:Vector.<Preset>;
        public static const protocolId:uint = 6162;

        public function InventoryContentAndPresetMessage()
        {
            this.presets = new Vector.<Preset>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6162;
        }// end function

        public function initInventoryContentAndPresetMessage(param1:Vector.<ObjectItem> = null, param2:uint = 0, param3:Vector.<Preset> = null) : InventoryContentAndPresetMessage
        {
            super.initInventoryContentMessage(param1, param2);
            this.presets = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.presets = new Vector.<Preset>;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_InventoryContentAndPresetMessage(param1);
            return;
        }// end function

        public function serializeAs_InventoryContentAndPresetMessage(param1:IDataOutput) : void
        {
            super.serializeAs_InventoryContentMessage(param1);
            param1.writeShort(this.presets.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.presets.length)
            {
                
                (this.presets[_loc_2] as Preset).serializeAs_Preset(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InventoryContentAndPresetMessage(param1);
            return;
        }// end function

        public function deserializeAs_InventoryContentAndPresetMessage(param1:IDataInput) : void
        {
            var _loc_4:Preset = null;
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new Preset();
                _loc_4.deserialize(param1);
                this.presets.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
