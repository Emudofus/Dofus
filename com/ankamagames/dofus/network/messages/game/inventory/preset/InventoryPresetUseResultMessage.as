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
    public class InventoryPresetUseResultMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6163;

        private var _isInitialized:Boolean = false;
        public var presetId:uint = 0;
        public var code:uint = 3;
        public var unlinkedPosition:Vector.<uint>;

        public function InventoryPresetUseResultMessage()
        {
            this.unlinkedPosition = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6163);
        }

        public function initInventoryPresetUseResultMessage(presetId:uint=0, code:uint=3, unlinkedPosition:Vector.<uint>=null):InventoryPresetUseResultMessage
        {
            this.presetId = presetId;
            this.code = code;
            this.unlinkedPosition = unlinkedPosition;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.presetId = 0;
            this.code = 3;
            this.unlinkedPosition = new Vector.<uint>();
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
            this.serializeAs_InventoryPresetUseResultMessage(output);
        }

        public function serializeAs_InventoryPresetUseResultMessage(output:ICustomDataOutput):void
        {
            if (this.presetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.presetId) + ") on element presetId.")));
            };
            output.writeByte(this.presetId);
            output.writeByte(this.code);
            output.writeShort(this.unlinkedPosition.length);
            var _i3:uint;
            while (_i3 < this.unlinkedPosition.length)
            {
                output.writeByte(this.unlinkedPosition[_i3]);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_InventoryPresetUseResultMessage(input);
        }

        public function deserializeAs_InventoryPresetUseResultMessage(input:ICustomDataInput):void
        {
            var _val3:uint;
            this.presetId = input.readByte();
            if (this.presetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.presetId) + ") on element of InventoryPresetUseResultMessage.presetId.")));
            };
            this.code = input.readByte();
            if (this.code < 0)
            {
                throw (new Error((("Forbidden value (" + this.code) + ") on element of InventoryPresetUseResultMessage.code.")));
            };
            var _unlinkedPositionLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _unlinkedPositionLen)
            {
                _val3 = input.readUnsignedByte();
                if ((((_val3 < 0)) || ((_val3 > 0xFF))))
                {
                    throw (new Error((("Forbidden value (" + _val3) + ") on elements of unlinkedPosition.")));
                };
                this.unlinkedPosition.push(_val3);
                _i3++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.preset

