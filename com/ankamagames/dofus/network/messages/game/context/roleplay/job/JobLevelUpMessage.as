package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class JobLevelUpMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var newLevel:uint = 0;
        public var jobsDescription:JobDescription;
        public static const protocolId:uint = 5656;

        public function JobLevelUpMessage()
        {
            this.jobsDescription = new JobDescription();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5656;
        }// end function

        public function initJobLevelUpMessage(param1:uint = 0, param2:JobDescription = null) : JobLevelUpMessage
        {
            this.newLevel = param1;
            this.jobsDescription = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.newLevel = 0;
            this.jobsDescription = new JobDescription();
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
            this.serializeAs_JobLevelUpMessage(param1);
            return;
        }// end function

        public function serializeAs_JobLevelUpMessage(param1:IDataOutput) : void
        {
            if (this.newLevel < 0)
            {
                throw new Error("Forbidden value (" + this.newLevel + ") on element newLevel.");
            }
            param1.writeByte(this.newLevel);
            this.jobsDescription.serializeAs_JobDescription(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_JobLevelUpMessage(param1);
            return;
        }// end function

        public function deserializeAs_JobLevelUpMessage(param1:IDataInput) : void
        {
            this.newLevel = param1.readByte();
            if (this.newLevel < 0)
            {
                throw new Error("Forbidden value (" + this.newLevel + ") on element of JobLevelUpMessage.newLevel.");
            }
            this.jobsDescription = new JobDescription();
            this.jobsDescription.deserialize(param1);
            return;
        }// end function

    }
}
