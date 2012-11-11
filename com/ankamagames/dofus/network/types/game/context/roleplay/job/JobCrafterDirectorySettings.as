package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class JobCrafterDirectorySettings extends Object implements INetworkType
    {
        public var jobId:uint = 0;
        public var minSlot:uint = 0;
        public var userDefinedParams:uint = 0;
        public static const protocolId:uint = 97;

        public function JobCrafterDirectorySettings()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 97;
        }// end function

        public function initJobCrafterDirectorySettings(param1:uint = 0, param2:uint = 0, param3:uint = 0) : JobCrafterDirectorySettings
        {
            this.jobId = param1;
            this.minSlot = param2;
            this.userDefinedParams = param3;
            return this;
        }// end function

        public function reset() : void
        {
            this.jobId = 0;
            this.minSlot = 0;
            this.userDefinedParams = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_JobCrafterDirectorySettings(param1);
            return;
        }// end function

        public function serializeAs_JobCrafterDirectorySettings(param1:IDataOutput) : void
        {
            if (this.jobId < 0)
            {
                throw new Error("Forbidden value (" + this.jobId + ") on element jobId.");
            }
            param1.writeByte(this.jobId);
            if (this.minSlot < 0 || this.minSlot > 9)
            {
                throw new Error("Forbidden value (" + this.minSlot + ") on element minSlot.");
            }
            param1.writeByte(this.minSlot);
            if (this.userDefinedParams < 0)
            {
                throw new Error("Forbidden value (" + this.userDefinedParams + ") on element userDefinedParams.");
            }
            param1.writeByte(this.userDefinedParams);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_JobCrafterDirectorySettings(param1);
            return;
        }// end function

        public function deserializeAs_JobCrafterDirectorySettings(param1:IDataInput) : void
        {
            this.jobId = param1.readByte();
            if (this.jobId < 0)
            {
                throw new Error("Forbidden value (" + this.jobId + ") on element of JobCrafterDirectorySettings.jobId.");
            }
            this.minSlot = param1.readByte();
            if (this.minSlot < 0 || this.minSlot > 9)
            {
                throw new Error("Forbidden value (" + this.minSlot + ") on element of JobCrafterDirectorySettings.minSlot.");
            }
            this.userDefinedParams = param1.readByte();
            if (this.userDefinedParams < 0)
            {
                throw new Error("Forbidden value (" + this.userDefinedParams + ") on element of JobCrafterDirectorySettings.userDefinedParams.");
            }
            return;
        }// end function

    }
}
