package com.ankamagames.dofus.network.messages.game.inventory.preset
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InventoryPresetUseResultMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var presetId:uint = 0;
        public var code:uint = 3;
        public var unlinkedPosition:Vector.<uint>;
        public static const protocolId:uint = 6163;

        public function InventoryPresetUseResultMessage()
        {
            this.unlinkedPosition = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6163;
        }// end function

        public function initInventoryPresetUseResultMessage(param1:uint = 0, param2:uint = 3, param3:Vector.<uint> = null) : InventoryPresetUseResultMessage
        {
            this.presetId = param1;
            this.code = param2;
            this.unlinkedPosition = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.presetId = 0;
            this.code = 3;
            this.unlinkedPosition = new Vector.<uint>;
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
            this.serializeAs_InventoryPresetUseResultMessage(param1);
            return;
        }// end function

        public function serializeAs_InventoryPresetUseResultMessage(param1:IDataOutput) : void
        {
            if (this.presetId < 0)
            {
                throw new Error("Forbidden value (" + this.presetId + ") on element presetId.");
            }
            param1.writeByte(this.presetId);
            param1.writeByte(this.code);
            param1.writeShort(this.unlinkedPosition.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.unlinkedPosition.length)
            {
                
                param1.writeByte(this.unlinkedPosition[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InventoryPresetUseResultMessage(param1);
            return;
        }// end function

        public function deserializeAs_InventoryPresetUseResultMessage(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            this.presetId = param1.readByte();
            if (this.presetId < 0)
            {
                throw new Error("Forbidden value (" + this.presetId + ") on element of InventoryPresetUseResultMessage.presetId.");
            }
            this.code = param1.readByte();
            if (this.code < 0)
            {
                throw new Error("Forbidden value (" + this.code + ") on element of InventoryPresetUseResultMessage.code.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUnsignedByte();
                if (_loc_4 < 0 || _loc_4 > 255)
                {
                    throw new Error("Forbidden value (" + _loc_4 + ") on elements of unlinkedPosition.");
                }
                this.unlinkedPosition.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
