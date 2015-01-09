package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class SequenceNumberMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6317;

        private var _isInitialized:Boolean = false;
        public var number:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6317);
        }

        public function initSequenceNumberMessage(number:uint=0):SequenceNumberMessage
        {
            this.number = number;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.number = 0;
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_SequenceNumberMessage(output);
        }

        public function serializeAs_SequenceNumberMessage(output:IDataOutput):void
        {
            if ((((this.number < 0)) || ((this.number > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.number) + ") on element number.")));
            };
            output.writeShort(this.number);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_SequenceNumberMessage(input);
        }

        public function deserializeAs_SequenceNumberMessage(input:IDataInput):void
        {
            this.number = input.readUnsignedShort();
            if ((((this.number < 0)) || ((this.number > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.number) + ") on element of SequenceNumberMessage.number.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.basic

