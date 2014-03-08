package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class JobCrafterDirectoryEntryJobInfo extends Object implements INetworkType
   {
      
      public function JobCrafterDirectoryEntryJobInfo() {
         super();
      }
      
      public static const protocolId:uint = 195;
      
      public var jobId:uint = 0;
      
      public var jobLevel:uint = 0;
      
      public var userDefinedParams:uint = 0;
      
      public var minSlots:uint = 0;
      
      public function getTypeId() : uint {
         return 195;
      }
      
      public function initJobCrafterDirectoryEntryJobInfo(jobId:uint=0, jobLevel:uint=0, userDefinedParams:uint=0, minSlots:uint=0) : JobCrafterDirectoryEntryJobInfo {
         this.jobId = jobId;
         this.jobLevel = jobLevel;
         this.userDefinedParams = userDefinedParams;
         this.minSlots = minSlots;
         return this;
      }
      
      public function reset() : void {
         this.jobId = 0;
         this.jobLevel = 0;
         this.userDefinedParams = 0;
         this.minSlots = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_JobCrafterDirectoryEntryJobInfo(output);
      }
      
      public function serializeAs_JobCrafterDirectoryEntryJobInfo(output:IDataOutput) : void {
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element jobId.");
         }
         else
         {
            output.writeByte(this.jobId);
            if((this.jobLevel < 1) || (this.jobLevel > 100))
            {
               throw new Error("Forbidden value (" + this.jobLevel + ") on element jobLevel.");
            }
            else
            {
               output.writeByte(this.jobLevel);
               if(this.userDefinedParams < 0)
               {
                  throw new Error("Forbidden value (" + this.userDefinedParams + ") on element userDefinedParams.");
               }
               else
               {
                  output.writeByte(this.userDefinedParams);
                  if((this.minSlots < 0) || (this.minSlots > 9))
                  {
                     throw new Error("Forbidden value (" + this.minSlots + ") on element minSlots.");
                  }
                  else
                  {
                     output.writeByte(this.minSlots);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_JobCrafterDirectoryEntryJobInfo(input);
      }
      
      public function deserializeAs_JobCrafterDirectoryEntryJobInfo(input:IDataInput) : void {
         this.jobId = input.readByte();
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element of JobCrafterDirectoryEntryJobInfo.jobId.");
         }
         else
         {
            this.jobLevel = input.readByte();
            if((this.jobLevel < 1) || (this.jobLevel > 100))
            {
               throw new Error("Forbidden value (" + this.jobLevel + ") on element of JobCrafterDirectoryEntryJobInfo.jobLevel.");
            }
            else
            {
               this.userDefinedParams = input.readByte();
               if(this.userDefinedParams < 0)
               {
                  throw new Error("Forbidden value (" + this.userDefinedParams + ") on element of JobCrafterDirectoryEntryJobInfo.userDefinedParams.");
               }
               else
               {
                  this.minSlots = input.readByte();
                  if((this.minSlots < 0) || (this.minSlots > 9))
                  {
                     throw new Error("Forbidden value (" + this.minSlots + ") on element of JobCrafterDirectoryEntryJobInfo.minSlots.");
                  }
                  else
                  {
                     return;
                  }
               }
            }
         }
      }
   }
}
