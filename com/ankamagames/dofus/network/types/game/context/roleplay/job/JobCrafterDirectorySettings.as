package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class JobCrafterDirectorySettings extends Object implements INetworkType
   {
      
      public function JobCrafterDirectorySettings() {
         super();
      }
      
      public static const protocolId:uint = 97;
      
      public var jobId:uint = 0;
      
      public var minSlot:uint = 0;
      
      public var userDefinedParams:uint = 0;
      
      public function getTypeId() : uint {
         return 97;
      }
      
      public function initJobCrafterDirectorySettings(jobId:uint = 0, minSlot:uint = 0, userDefinedParams:uint = 0) : JobCrafterDirectorySettings {
         this.jobId = jobId;
         this.minSlot = minSlot;
         this.userDefinedParams = userDefinedParams;
         return this;
      }
      
      public function reset() : void {
         this.jobId = 0;
         this.minSlot = 0;
         this.userDefinedParams = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_JobCrafterDirectorySettings(output);
      }
      
      public function serializeAs_JobCrafterDirectorySettings(output:IDataOutput) : void {
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element jobId.");
         }
         else
         {
            output.writeByte(this.jobId);
            if((this.minSlot < 0) || (this.minSlot > 9))
            {
               throw new Error("Forbidden value (" + this.minSlot + ") on element minSlot.");
            }
            else
            {
               output.writeByte(this.minSlot);
               if(this.userDefinedParams < 0)
               {
                  throw new Error("Forbidden value (" + this.userDefinedParams + ") on element userDefinedParams.");
               }
               else
               {
                  output.writeByte(this.userDefinedParams);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_JobCrafterDirectorySettings(input);
      }
      
      public function deserializeAs_JobCrafterDirectorySettings(input:IDataInput) : void {
         this.jobId = input.readByte();
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element of JobCrafterDirectorySettings.jobId.");
         }
         else
         {
            this.minSlot = input.readByte();
            if((this.minSlot < 0) || (this.minSlot > 9))
            {
               throw new Error("Forbidden value (" + this.minSlot + ") on element of JobCrafterDirectorySettings.minSlot.");
            }
            else
            {
               this.userDefinedParams = input.readByte();
               if(this.userDefinedParams < 0)
               {
                  throw new Error("Forbidden value (" + this.userDefinedParams + ") on element of JobCrafterDirectorySettings.userDefinedParams.");
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
