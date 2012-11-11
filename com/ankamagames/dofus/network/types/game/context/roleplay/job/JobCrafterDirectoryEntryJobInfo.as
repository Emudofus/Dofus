package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class JobCrafterDirectoryEntryJobInfo extends Object implements INetworkType
    {
        public var jobId:uint = 0;
        public var jobLevel:uint = 0;
        public var userDefinedParams:uint = 0;
        public var minSlots:uint = 0;
        public static const protocolId:uint = 195;

        public function JobCrafterDirectoryEntryJobInfo()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 195;
        }// end function

        public function initJobCrafterDirectoryEntryJobInfo(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0) : JobCrafterDirectoryEntryJobInfo
        {
            this.jobId = param1;
            this.jobLevel = param2;
            this.userDefinedParams = param3;
            this.minSlots = param4;
            return this;
        }// end function

        public function reset() : void
        {
            this.jobId = 0;
            this.jobLevel = 0;
            this.userDefinedParams = 0;
            this.minSlots = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_JobCrafterDirectoryEntryJobInfo(param1);
            return;
        }// end function

        public function serializeAs_JobCrafterDirectoryEntryJobInfo(param1:IDataOutput) : void
        {
            if (this.jobId < 0)
            {
                throw new Error("Forbidden value (" + this.jobId + ") on element jobId.");
            }
            param1.writeByte(this.jobId);
            if (this.jobLevel < 1 || this.jobLevel > 100)
            {
                throw new Error("Forbidden value (" + this.jobLevel + ") on element jobLevel.");
            }
            param1.writeByte(this.jobLevel);
            if (this.userDefinedParams < 0)
            {
                throw new Error("Forbidden value (" + this.userDefinedParams + ") on element userDefinedParams.");
            }
            param1.writeByte(this.userDefinedParams);
            if (this.minSlots < 0 || this.minSlots > 9)
            {
                throw new Error("Forbidden value (" + this.minSlots + ") on element minSlots.");
            }
            param1.writeByte(this.minSlots);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_JobCrafterDirectoryEntryJobInfo(param1);
            return;
        }// end function

        public function deserializeAs_JobCrafterDirectoryEntryJobInfo(param1:IDataInput) : void
        {
            this.jobId = param1.readByte();
            if (this.jobId < 0)
            {
                throw new Error("Forbidden value (" + this.jobId + ") on element of JobCrafterDirectoryEntryJobInfo.jobId.");
            }
            this.jobLevel = param1.readByte();
            if (this.jobLevel < 1 || this.jobLevel > 100)
            {
                throw new Error("Forbidden value (" + this.jobLevel + ") on element of JobCrafterDirectoryEntryJobInfo.jobLevel.");
            }
            this.userDefinedParams = param1.readByte();
            if (this.userDefinedParams < 0)
            {
                throw new Error("Forbidden value (" + this.userDefinedParams + ") on element of JobCrafterDirectoryEntryJobInfo.userDefinedParams.");
            }
            this.minSlots = param1.readByte();
            if (this.minSlots < 0 || this.minSlots > 9)
            {
                throw new Error("Forbidden value (" + this.minSlots + ") on element of JobCrafterDirectoryEntryJobInfo.minSlots.");
            }
            return;
        }// end function

    }
}
