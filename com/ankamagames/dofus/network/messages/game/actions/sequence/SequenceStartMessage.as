package com.ankamagames.dofus.network.messages.game.actions.sequence
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class SequenceStartMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 955;

        private var _isInitialized:Boolean = false;
        public var sequenceType:int = 0;
        public var authorId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (955);
        }

        public function initSequenceStartMessage(sequenceType:int=0, authorId:int=0):SequenceStartMessage
        {
            this.sequenceType = sequenceType;
            this.authorId = authorId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.sequenceType = 0;
            this.authorId = 0;
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
            this.serializeAs_SequenceStartMessage(output);
        }

        public function serializeAs_SequenceStartMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.sequenceType);
            output.writeInt(this.authorId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SequenceStartMessage(input);
        }

        public function deserializeAs_SequenceStartMessage(input:ICustomDataInput):void
        {
            this.sequenceType = input.readByte();
            this.authorId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions.sequence

