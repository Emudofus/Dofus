package com.ankamagames.dofus.network.messages.game.inventory.preset
{
    import com.ankamagames.dofus.network.types.game.inventory.preset.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InventoryPresetUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var preset:Preset;
        public static const protocolId:uint = 6171;

        public function InventoryPresetUpdateMessage()
        {
            this.preset = new Preset();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6171;
        }// end function

        public function initInventoryPresetUpdateMessage(param1:Preset = null) : InventoryPresetUpdateMessage
        {
            this.preset = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.preset = new Preset();
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

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_InventoryPresetUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_InventoryPresetUpdateMessage(param1:IDataOutput) : void
        {
            this.preset.serializeAs_Preset(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InventoryPresetUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_InventoryPresetUpdateMessage(param1:IDataInput) : void
        {
            this.preset = new Preset();
            this.preset.deserialize(param1);
            return;
        }// end function

    }
}
