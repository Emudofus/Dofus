package com.ankamagames.dofus.network.messages.game.inventory.preset
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InventoryPresetItemUpdateErrorMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var code:uint = 1;
        public static const protocolId:uint = 6211;

        public function InventoryPresetItemUpdateErrorMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6211;
        }// end function

        public function initInventoryPresetItemUpdateErrorMessage(param1:uint = 1) : InventoryPresetItemUpdateErrorMessage
        {
            this.code = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.code = 1;
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
            this.serializeAs_InventoryPresetItemUpdateErrorMessage(param1);
            return;
        }// end function

        public function serializeAs_InventoryPresetItemUpdateErrorMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.code);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InventoryPresetItemUpdateErrorMessage(param1);
            return;
        }// end function

        public function deserializeAs_InventoryPresetItemUpdateErrorMessage(param1:IDataInput) : void
        {
            this.code = param1.readByte();
            if (this.code < 0)
            {
                throw new Error("Forbidden value (" + this.code + ") on element of InventoryPresetItemUpdateErrorMessage.code.");
            }
            return;
        }// end function

    }
}
