package com.ankamagames.dofus.network.messages.game.actions.sequence
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SequenceStartMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var sequenceType:int = 0;
        public var authorId:int = 0;
        public static const protocolId:uint = 955;

        public function SequenceStartMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 955;
        }// end function

        public function initSequenceStartMessage(param1:int = 0, param2:int = 0) : SequenceStartMessage
        {
            this.sequenceType = param1;
            this.authorId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.sequenceType = 0;
            this.authorId = 0;
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
            this.serializeAs_SequenceStartMessage(param1);
            return;
        }// end function

        public function serializeAs_SequenceStartMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.sequenceType);
            param1.writeInt(this.authorId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SequenceStartMessage(param1);
            return;
        }// end function

        public function deserializeAs_SequenceStartMessage(param1:IDataInput) : void
        {
            this.sequenceType = param1.readByte();
            this.authorId = param1.readInt();
            return;
        }// end function

    }
}
