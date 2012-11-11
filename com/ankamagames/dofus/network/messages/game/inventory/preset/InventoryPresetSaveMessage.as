package com.ankamagames.dofus.network.messages.game.inventory.preset
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InventoryPresetSaveMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var presetId:uint = 0;
        public var symbolId:uint = 0;
        public var saveEquipment:Boolean = false;
        public static const protocolId:uint = 6165;

        public function InventoryPresetSaveMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6165;
        }// end function

        public function initInventoryPresetSaveMessage(param1:uint = 0, param2:uint = 0, param3:Boolean = false) : InventoryPresetSaveMessage
        {
            this.presetId = param1;
            this.symbolId = param2;
            this.saveEquipment = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.presetId = 0;
            this.symbolId = 0;
            this.saveEquipment = false;
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
            this.serializeAs_InventoryPresetSaveMessage(param1);
            return;
        }// end function

        public function serializeAs_InventoryPresetSaveMessage(param1:IDataOutput) : void
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
            param1.writeBoolean(this.saveEquipment);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InventoryPresetSaveMessage(param1);
            return;
        }// end function

        public function deserializeAs_InventoryPresetSaveMessage(param1:IDataInput) : void
        {
            this.presetId = param1.readByte();
            if (this.presetId < 0)
            {
                throw new Error("Forbidden value (" + this.presetId + ") on element of InventoryPresetSaveMessage.presetId.");
            }
            this.symbolId = param1.readByte();
            if (this.symbolId < 0)
            {
                throw new Error("Forbidden value (" + this.symbolId + ") on element of InventoryPresetSaveMessage.symbolId.");
            }
            this.saveEquipment = param1.readBoolean();
            return;
        }// end function

    }
}
