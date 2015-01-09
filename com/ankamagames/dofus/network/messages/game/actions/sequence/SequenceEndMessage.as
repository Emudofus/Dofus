package com.ankamagames.dofus.network.messages.game.actions.sequence
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class SequenceEndMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 956;

        private var _isInitialized:Boolean = false;
        public var actionId:uint = 0;
        public var authorId:int = 0;
        public var sequenceType:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (956);
        }

        public function initSequenceEndMessage(actionId:uint=0, authorId:int=0, sequenceType:int=0):SequenceEndMessage
        {
            this.actionId = actionId;
            this.authorId = authorId;
            this.sequenceType = sequenceType;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.actionId = 0;
            this.authorId = 0;
            this.sequenceType = 0;
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
            this.serializeAs_SequenceEndMessage(output);
        }

        public function serializeAs_SequenceEndMessage(output:ICustomDataOutput):void
        {
            if (this.actionId < 0)
            {
                throw (new Error((("Forbidden value (" + this.actionId) + ") on element actionId.")));
            };
            output.writeVarShort(this.actionId);
            output.writeInt(this.authorId);
            output.writeByte(this.sequenceType);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SequenceEndMessage(input);
        }

        public function deserializeAs_SequenceEndMessage(input:ICustomDataInput):void
        {
            this.actionId = input.readVarUhShort();
            if (this.actionId < 0)
            {
                throw (new Error((("Forbidden value (" + this.actionId) + ") on element of SequenceEndMessage.actionId.")));
            };
            this.authorId = input.readInt();
            this.sequenceType = input.readByte();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions.sequence

