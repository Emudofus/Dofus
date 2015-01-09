package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class BasicLatencyStatsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5663;

        private var _isInitialized:Boolean = false;
        public var latency:uint = 0;
        public var sampleCount:uint = 0;
        public var max:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5663);
        }

        public function initBasicLatencyStatsMessage(latency:uint=0, sampleCount:uint=0, max:uint=0):BasicLatencyStatsMessage
        {
            this.latency = latency;
            this.sampleCount = sampleCount;
            this.max = max;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.latency = 0;
            this.sampleCount = 0;
            this.max = 0;
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            if (HASH_FUNCTION != null)
            {
                HASH_FUNCTION(data);
            };
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_BasicLatencyStatsMessage(output);
        }

        public function serializeAs_BasicLatencyStatsMessage(output:ICustomDataOutput):void
        {
            if ((((this.latency < 0)) || ((this.latency > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.latency) + ") on element latency.")));
            };
            output.writeShort(this.latency);
            if (this.sampleCount < 0)
            {
                throw (new Error((("Forbidden value (" + this.sampleCount) + ") on element sampleCount.")));
            };
            output.writeVarShort(this.sampleCount);
            if (this.max < 0)
            {
                throw (new Error((("Forbidden value (" + this.max) + ") on element max.")));
            };
            output.writeVarShort(this.max);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_BasicLatencyStatsMessage(input);
        }

        public function deserializeAs_BasicLatencyStatsMessage(input:ICustomDataInput):void
        {
            this.latency = input.readUnsignedShort();
            if ((((this.latency < 0)) || ((this.latency > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.latency) + ") on element of BasicLatencyStatsMessage.latency.")));
            };
            this.sampleCount = input.readVarUhShort();
            if (this.sampleCount < 0)
            {
                throw (new Error((("Forbidden value (" + this.sampleCount) + ") on element of BasicLatencyStatsMessage.sampleCount.")));
            };
            this.max = input.readVarUhShort();
            if (this.max < 0)
            {
                throw (new Error((("Forbidden value (" + this.max) + ") on element of BasicLatencyStatsMessage.max.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.basic

