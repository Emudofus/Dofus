package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

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
            this.serializeAs_SequenceNumberMessage(output);
        }

        public function serializeAs_SequenceNumberMessage(output:ICustomDataOutput):void
        {
            if ((((this.number < 0)) || ((this.number > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.number) + ") on element number.")));
            };
            output.writeShort(this.number);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SequenceNumberMessage(input);
        }

        public function deserializeAs_SequenceNumberMessage(input:ICustomDataInput):void
        {
            this.number = input.readUnsignedShort();
            if ((((this.number < 0)) || ((this.number > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.number) + ") on element of SequenceNumberMessage.number.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.basic

