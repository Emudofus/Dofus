package com.ankamagames.dofus.network.messages.game.look
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
    public class AccessoryPreviewRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6518;

        private var _isInitialized:Boolean = false;
        public var genericId:Vector.<uint>;

        public function AccessoryPreviewRequestMessage()
        {
            this.genericId = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6518);
        }

        public function initAccessoryPreviewRequestMessage(genericId:Vector.<uint>=null):AccessoryPreviewRequestMessage
        {
            this.genericId = genericId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.genericId = new Vector.<uint>();
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
            this.serializeAs_AccessoryPreviewRequestMessage(output);
        }

        public function serializeAs_AccessoryPreviewRequestMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.genericId.length);
            var _i1:uint;
            while (_i1 < this.genericId.length)
            {
                if (this.genericId[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.genericId[_i1]) + ") on element 1 (starting at 1) of genericId.")));
                };
                output.writeVarShort(this.genericId[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AccessoryPreviewRequestMessage(input);
        }

        public function deserializeAs_AccessoryPreviewRequestMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _genericIdLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _genericIdLen)
            {
                _val1 = input.readVarUhShort();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of genericId.")));
                };
                this.genericId.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.look

