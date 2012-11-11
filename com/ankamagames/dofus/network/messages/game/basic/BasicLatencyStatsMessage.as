package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class BasicLatencyStatsMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var latency:uint = 0;
        public var sampleCount:uint = 0;
        public var max:uint = 0;
        public static const protocolId:uint = 5663;

        public function BasicLatencyStatsMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5663;
        }// end function

        public function initBasicLatencyStatsMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : BasicLatencyStatsMessage
        {
            this.latency = param1;
            this.sampleCount = param2;
            this.max = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.latency = 0;
            this.sampleCount = 0;
            this.max = 0;
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
            this.serializeAs_BasicLatencyStatsMessage(param1);
            return;
        }// end function

        public function serializeAs_BasicLatencyStatsMessage(param1:IDataOutput) : void
        {
            if (this.latency < 0 || this.latency > 65535)
            {
                throw new Error("Forbidden value (" + this.latency + ") on element latency.");
            }
            param1.writeShort(this.latency);
            if (this.sampleCount < 0)
            {
                throw new Error("Forbidden value (" + this.sampleCount + ") on element sampleCount.");
            }
            param1.writeShort(this.sampleCount);
            if (this.max < 0)
            {
                throw new Error("Forbidden value (" + this.max + ") on element max.");
            }
            param1.writeShort(this.max);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_BasicLatencyStatsMessage(param1);
            return;
        }// end function

        public function deserializeAs_BasicLatencyStatsMessage(param1:IDataInput) : void
        {
            this.latency = param1.readUnsignedShort();
            if (this.latency < 0 || this.latency > 65535)
            {
                throw new Error("Forbidden value (" + this.latency + ") on element of BasicLatencyStatsMessage.latency.");
            }
            this.sampleCount = param1.readShort();
            if (this.sampleCount < 0)
            {
                throw new Error("Forbidden value (" + this.sampleCount + ") on element of BasicLatencyStatsMessage.sampleCount.");
            }
            this.max = param1.readShort();
            if (this.max < 0)
            {
                throw new Error("Forbidden value (" + this.max + ") on element of BasicLatencyStatsMessage.max.");
            }
            return;
        }// end function

    }
}
