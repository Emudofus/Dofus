package com.ankamagames.dofus.network.messages.updater.parts
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.updater.ContentPart;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class PartsListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 1502;

        private var _isInitialized:Boolean = false;
        public var parts:Vector.<ContentPart>;

        public function PartsListMessage()
        {
            this.parts = new Vector.<ContentPart>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (1502);
        }

        public function initPartsListMessage(parts:Vector.<ContentPart>=null):PartsListMessage
        {
            this.parts = parts;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.parts = new Vector.<ContentPart>();
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
            this.serializeAs_PartsListMessage(output);
        }

        public function serializeAs_PartsListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.parts.length);
            var _i1:uint;
            while (_i1 < this.parts.length)
            {
                (this.parts[_i1] as ContentPart).serializeAs_ContentPart(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartsListMessage(input);
        }

        public function deserializeAs_PartsListMessage(input:ICustomDataInput):void
        {
            var _item1:ContentPart;
            var _partsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _partsLen)
            {
                _item1 = new ContentPart();
                _item1.deserialize(input);
                this.parts.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.updater.parts

