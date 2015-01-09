package com.ankamagames.dofus.network.messages.game.inventory.exchanges
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
    public class ExchangeStartOkJobIndexMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5819;

        private var _isInitialized:Boolean = false;
        public var jobs:Vector.<uint>;

        public function ExchangeStartOkJobIndexMessage()
        {
            this.jobs = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5819);
        }

        public function initExchangeStartOkJobIndexMessage(jobs:Vector.<uint>=null):ExchangeStartOkJobIndexMessage
        {
            this.jobs = jobs;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.jobs = new Vector.<uint>();
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
            this.serializeAs_ExchangeStartOkJobIndexMessage(output);
        }

        public function serializeAs_ExchangeStartOkJobIndexMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.jobs.length);
            var _i1:uint;
            while (_i1 < this.jobs.length)
            {
                if (this.jobs[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.jobs[_i1]) + ") on element 1 (starting at 1) of jobs.")));
                };
                output.writeVarInt(this.jobs[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeStartOkJobIndexMessage(input);
        }

        public function deserializeAs_ExchangeStartOkJobIndexMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _jobsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _jobsLen)
            {
                _val1 = input.readVarUhInt();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of jobs.")));
                };
                this.jobs.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

