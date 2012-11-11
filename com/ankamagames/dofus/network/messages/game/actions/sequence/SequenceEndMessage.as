package com.ankamagames.dofus.network.messages.game.actions.sequence
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SequenceEndMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var actionId:uint = 0;
        public var authorId:int = 0;
        public var sequenceType:int = 0;
        public static const protocolId:uint = 956;

        public function SequenceEndMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 956;
        }// end function

        public function initSequenceEndMessage(param1:uint = 0, param2:int = 0, param3:int = 0) : SequenceEndMessage
        {
            this.actionId = param1;
            this.authorId = param2;
            this.sequenceType = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.actionId = 0;
            this.authorId = 0;
            this.sequenceType = 0;
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
            this.serializeAs_SequenceEndMessage(param1);
            return;
        }// end function

        public function serializeAs_SequenceEndMessage(param1:IDataOutput) : void
        {
            if (this.actionId < 0)
            {
                throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
            }
            param1.writeShort(this.actionId);
            param1.writeInt(this.authorId);
            param1.writeByte(this.sequenceType);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SequenceEndMessage(param1);
            return;
        }// end function

        public function deserializeAs_SequenceEndMessage(param1:IDataInput) : void
        {
            this.actionId = param1.readShort();
            if (this.actionId < 0)
            {
                throw new Error("Forbidden value (" + this.actionId + ") on element of SequenceEndMessage.actionId.");
            }
            this.authorId = param1.readInt();
            this.sequenceType = param1.readByte();
            return;
        }// end function

    }
}
