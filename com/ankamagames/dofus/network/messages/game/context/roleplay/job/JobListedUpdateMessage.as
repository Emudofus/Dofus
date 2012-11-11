package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class JobListedUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var addedOrDeleted:Boolean = false;
        public var jobId:uint = 0;
        public static const protocolId:uint = 6016;

        public function JobListedUpdateMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6016;
        }// end function

        public function initJobListedUpdateMessage(param1:Boolean = false, param2:uint = 0) : JobListedUpdateMessage
        {
            this.addedOrDeleted = param1;
            this.jobId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.addedOrDeleted = false;
            this.jobId = 0;
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
            this.serializeAs_JobListedUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_JobListedUpdateMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.addedOrDeleted);
            if (this.jobId < 0)
            {
                throw new Error("Forbidden value (" + this.jobId + ") on element jobId.");
            }
            param1.writeByte(this.jobId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_JobListedUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_JobListedUpdateMessage(param1:IDataInput) : void
        {
            this.addedOrDeleted = param1.readBoolean();
            this.jobId = param1.readByte();
            if (this.jobId < 0)
            {
                throw new Error("Forbidden value (" + this.jobId + ") on element of JobListedUpdateMessage.jobId.");
            }
            return;
        }// end function

    }
}
