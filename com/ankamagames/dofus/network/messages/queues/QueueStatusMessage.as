package com.ankamagames.dofus.network.messages.queues
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class QueueStatusMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6100;

        private var _isInitialized:Boolean = false;
        public var position:uint = 0;
        public var total:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6100);
        }

        public function initQueueStatusMessage(position:uint=0, total:uint=0):QueueStatusMessage
        {
            this.position = position;
            this.total = total;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.position = 0;
            this.total = 0;
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
            this.serializeAs_QueueStatusMessage(output);
        }

        public function serializeAs_QueueStatusMessage(output:ICustomDataOutput):void
        {
            if ((((this.position < 0)) || ((this.position > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.position) + ") on element position.")));
            };
            output.writeShort(this.position);
            if ((((this.total < 0)) || ((this.total > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.total) + ") on element total.")));
            };
            output.writeShort(this.total);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_QueueStatusMessage(input);
        }

        public function deserializeAs_QueueStatusMessage(input:ICustomDataInput):void
        {
            this.position = input.readUnsignedShort();
            if ((((this.position < 0)) || ((this.position > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.position) + ") on element of QueueStatusMessage.position.")));
            };
            this.total = input.readUnsignedShort();
            if ((((this.total < 0)) || ((this.total > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.total) + ") on element of QueueStatusMessage.total.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.queues

