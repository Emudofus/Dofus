package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobDescription;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class JobLevelUpMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5656;

        private var _isInitialized:Boolean = false;
        public var newLevel:uint = 0;
        public var jobsDescription:JobDescription;

        public function JobLevelUpMessage()
        {
            this.jobsDescription = new JobDescription();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5656);
        }

        public function initJobLevelUpMessage(newLevel:uint=0, jobsDescription:JobDescription=null):JobLevelUpMessage
        {
            this.newLevel = newLevel;
            this.jobsDescription = jobsDescription;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.newLevel = 0;
            this.jobsDescription = new JobDescription();
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
            this.serializeAs_JobLevelUpMessage(output);
        }

        public function serializeAs_JobLevelUpMessage(output:ICustomDataOutput):void
        {
            if (this.newLevel < 0)
            {
                throw (new Error((("Forbidden value (" + this.newLevel) + ") on element newLevel.")));
            };
            output.writeByte(this.newLevel);
            this.jobsDescription.serializeAs_JobDescription(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_JobLevelUpMessage(input);
        }

        public function deserializeAs_JobLevelUpMessage(input:ICustomDataInput):void
        {
            this.newLevel = input.readByte();
            if (this.newLevel < 0)
            {
                throw (new Error((("Forbidden value (" + this.newLevel) + ") on element of JobLevelUpMessage.newLevel.")));
            };
            this.jobsDescription = new JobDescription();
            this.jobsDescription.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.job

