﻿package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class JobCrafterDirectoryEntryJobInfo implements INetworkType 
    {

        public static const protocolId:uint = 195;

        public var jobId:uint = 0;
        public var jobLevel:uint = 0;
        public var userDefinedParams:uint = 0;
        public var minSlots:uint = 0;


        public function getTypeId():uint
        {
            return (195);
        }

        public function initJobCrafterDirectoryEntryJobInfo(jobId:uint=0, jobLevel:uint=0, userDefinedParams:uint=0, minSlots:uint=0):JobCrafterDirectoryEntryJobInfo
        {
            this.jobId = jobId;
            this.jobLevel = jobLevel;
            this.userDefinedParams = userDefinedParams;
            this.minSlots = minSlots;
            return (this);
        }

        public function reset():void
        {
            this.jobId = 0;
            this.jobLevel = 0;
            this.userDefinedParams = 0;
            this.minSlots = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_JobCrafterDirectoryEntryJobInfo(output);
        }

        public function serializeAs_JobCrafterDirectoryEntryJobInfo(output:ICustomDataOutput):void
        {
            if (this.jobId < 0)
            {
                throw (new Error((("Forbidden value (" + this.jobId) + ") on element jobId.")));
            };
            output.writeByte(this.jobId);
            if ((((this.jobLevel < 1)) || ((this.jobLevel > 100))))
            {
                throw (new Error((("Forbidden value (" + this.jobLevel) + ") on element jobLevel.")));
            };
            output.writeByte(this.jobLevel);
            if (this.userDefinedParams < 0)
            {
                throw (new Error((("Forbidden value (" + this.userDefinedParams) + ") on element userDefinedParams.")));
            };
            output.writeByte(this.userDefinedParams);
            if ((((this.minSlots < 0)) || ((this.minSlots > 9))))
            {
                throw (new Error((("Forbidden value (" + this.minSlots) + ") on element minSlots.")));
            };
            output.writeByte(this.minSlots);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_JobCrafterDirectoryEntryJobInfo(input);
        }

        public function deserializeAs_JobCrafterDirectoryEntryJobInfo(input:ICustomDataInput):void
        {
            this.jobId = input.readByte();
            if (this.jobId < 0)
            {
                throw (new Error((("Forbidden value (" + this.jobId) + ") on element of JobCrafterDirectoryEntryJobInfo.jobId.")));
            };
            this.jobLevel = input.readByte();
            if ((((this.jobLevel < 1)) || ((this.jobLevel > 100))))
            {
                throw (new Error((("Forbidden value (" + this.jobLevel) + ") on element of JobCrafterDirectoryEntryJobInfo.jobLevel.")));
            };
            this.userDefinedParams = input.readByte();
            if (this.userDefinedParams < 0)
            {
                throw (new Error((("Forbidden value (" + this.userDefinedParams) + ") on element of JobCrafterDirectoryEntryJobInfo.userDefinedParams.")));
            };
            this.minSlots = input.readByte();
            if ((((this.minSlots < 0)) || ((this.minSlots > 9))))
            {
                throw (new Error((("Forbidden value (" + this.minSlots) + ") on element of JobCrafterDirectoryEntryJobInfo.minSlots.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.job

