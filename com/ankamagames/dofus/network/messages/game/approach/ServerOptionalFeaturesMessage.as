package com.ankamagames.dofus.network.messages.game.approach
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
    public class ServerOptionalFeaturesMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6305;

        private var _isInitialized:Boolean = false;
        public var features:Vector.<uint>;

        public function ServerOptionalFeaturesMessage()
        {
            this.features = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6305);
        }

        public function initServerOptionalFeaturesMessage(features:Vector.<uint>=null):ServerOptionalFeaturesMessage
        {
            this.features = features;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.features = new Vector.<uint>();
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
            this.serializeAs_ServerOptionalFeaturesMessage(output);
        }

        public function serializeAs_ServerOptionalFeaturesMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.features.length);
            var _i1:uint;
            while (_i1 < this.features.length)
            {
                if (this.features[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.features[_i1]) + ") on element 1 (starting at 1) of features.")));
                };
                output.writeByte(this.features[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ServerOptionalFeaturesMessage(input);
        }

        public function deserializeAs_ServerOptionalFeaturesMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _featuresLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _featuresLen)
            {
                _val1 = input.readByte();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of features.")));
                };
                this.features.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.approach

