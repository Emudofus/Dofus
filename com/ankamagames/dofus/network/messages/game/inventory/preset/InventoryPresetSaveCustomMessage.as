package com.ankamagames.dofus.network.messages.game.inventory.preset
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class InventoryPresetSaveCustomMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6329;

        private var _isInitialized:Boolean = false;
        public var presetId:uint = 0;
        public var symbolId:uint = 0;
        public var itemsPositions:Vector.<uint>;
        public var itemsUids:Vector.<uint>;

        public function InventoryPresetSaveCustomMessage()
        {
            this.itemsPositions = new Vector.<uint>();
            this.itemsUids = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6329);
        }

        public function initInventoryPresetSaveCustomMessage(presetId:uint=0, symbolId:uint=0, itemsPositions:Vector.<uint>=null, itemsUids:Vector.<uint>=null):InventoryPresetSaveCustomMessage
        {
            this.presetId = presetId;
            this.symbolId = symbolId;
            this.itemsPositions = itemsPositions;
            this.itemsUids = itemsUids;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.presetId = 0;
            this.symbolId = 0;
            this.itemsPositions = new Vector.<uint>();
            this.itemsUids = new Vector.<uint>();
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

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_InventoryPresetSaveCustomMessage(output);
        }

        public function serializeAs_InventoryPresetSaveCustomMessage(output:ICustomDataOutput):void
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
            output.writeShort(this.itemsPositions.length);
            var _i3:uint;
            while (_i3 < this.itemsPositions.length)
            {
                output.writeByte(this.itemsPositions[_i3]);
                _i3++;
            };
            output.writeShort(this.itemsUids.length);
            var _i4:uint;
            while (_i4 < this.itemsUids.length)
            {
                if (this.itemsUids[_i4] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.itemsUids[_i4]) + ") on element 4 (starting at 1) of itemsUids.")));
                };
                output.writeVarInt(this.itemsUids[_i4]);
                _i4++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_InventoryPresetSaveCustomMessage(input);
        }

        public function deserializeAs_InventoryPresetSaveCustomMessage(input:ICustomDataInput):void
        {
            var _val3:uint;
            var _val4:uint;
            this.presetId = input.readByte();
            if (this.presetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.presetId) + ") on element of InventoryPresetSaveCustomMessage.presetId.")));
            };
            this.symbolId = input.readByte();
            if (this.symbolId < 0)
            {
                throw (new Error((("Forbidden value (" + this.symbolId) + ") on element of InventoryPresetSaveCustomMessage.symbolId.")));
            };
            var _itemsPositionsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _itemsPositionsLen)
            {
                _val3 = input.readUnsignedByte();
                if ((((_val3 < 0)) || ((_val3 > 0xFF))))
                {
                    throw (new Error((("Forbidden value (" + _val3) + ") on elements of itemsPositions.")));
                };
                this.itemsPositions.push(_val3);
                _i3++;
            };
            var _itemsUidsLen:uint = input.readUnsignedShort();
            var _i4:uint;
            while (_i4 < _itemsUidsLen)
            {
                _val4 = input.readVarUhInt();
                if (_val4 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val4) + ") on elements of itemsUids.")));
                };
                this.itemsUids.push(_val4);
                _i4++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.preset

