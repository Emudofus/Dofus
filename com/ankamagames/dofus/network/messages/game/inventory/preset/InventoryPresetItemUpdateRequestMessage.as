package com.ankamagames.dofus.network.messages.game.inventory.preset
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InventoryPresetItemUpdateRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var presetId:uint = 0;
        public var position:uint = 63;
        public var objUid:uint = 0;
        public static const protocolId:uint = 6210;

        public function InventoryPresetItemUpdateRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6210;
        }// end function

        public function initInventoryPresetItemUpdateRequestMessage(param1:uint = 0, param2:uint = 63, param3:uint = 0) : InventoryPresetItemUpdateRequestMessage
        {
            this.presetId = param1;
            this.position = param2;
            this.objUid = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.presetId = 0;
            this.position = 63;
            this.objUid = 0;
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
            this.serializeAs_InventoryPresetItemUpdateRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_InventoryPresetItemUpdateRequestMessage(param1:IDataOutput) : void
        {
            if (this.presetId < 0)
            {
                throw new Error("Forbidden value (" + this.presetId + ") on element presetId.");
            }
            param1.writeByte(this.presetId);
            param1.writeByte(this.position);
            if (this.objUid < 0)
            {
                throw new Error("Forbidden value (" + this.objUid + ") on element objUid.");
            }
            param1.writeInt(this.objUid);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InventoryPresetItemUpdateRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_InventoryPresetItemUpdateRequestMessage(param1:IDataInput) : void
        {
            this.presetId = param1.readByte();
            if (this.presetId < 0)
            {
                throw new Error("Forbidden value (" + this.presetId + ") on element of InventoryPresetItemUpdateRequestMessage.presetId.");
            }
            this.position = param1.readUnsignedByte();
            if (this.position < 0 || this.position > 255)
            {
                throw new Error("Forbidden value (" + this.position + ") on element of InventoryPresetItemUpdateRequestMessage.position.");
            }
            this.objUid = param1.readInt();
            if (this.objUid < 0)
            {
                throw new Error("Forbidden value (" + this.objUid + ") on element of InventoryPresetItemUpdateRequestMessage.objUid.");
            }
            return;
        }// end function

    }
}
