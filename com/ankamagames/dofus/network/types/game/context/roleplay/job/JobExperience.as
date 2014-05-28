package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class JobExperience extends Object implements INetworkType
   {
      
      public function JobExperience() {
         super();
      }
      
      public static const protocolId:uint = 98;
      
      public var jobId:uint = 0;
      
      public var jobLevel:uint = 0;
      
      public var jobXP:Number = 0;
      
      public var jobXpLevelFloor:Number = 0;
      
      public var jobXpNextLevelFloor:Number = 0;
      
      public function getTypeId() : uint {
         return 98;
      }
      
      public function initJobExperience(jobId:uint = 0, jobLevel:uint = 0, jobXP:Number = 0, jobXpLevelFloor:Number = 0, jobXpNextLevelFloor:Number = 0) : JobExperience {
         this.jobId = jobId;
         this.jobLevel = jobLevel;
         this.jobXP = jobXP;
         this.jobXpLevelFloor = jobXpLevelFloor;
         this.jobXpNextLevelFloor = jobXpNextLevelFloor;
         return this;
      }
      
      public function reset() : void {
         this.jobId = 0;
         this.jobLevel = 0;
         this.jobXP = 0;
         this.jobXpLevelFloor = 0;
         this.jobXpNextLevelFloor = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_JobExperience(output);
      }
      
      public function serializeAs_JobExperience(output:IDataOutput) : void {
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element jobId.");
         }
         else
         {
            output.writeByte(this.jobId);
            if(this.jobLevel < 0)
            {
               throw new Error("Forbidden value (" + this.jobLevel + ") on element jobLevel.");
            }
            else
            {
               output.writeByte(this.jobLevel);
               if(this.jobXP < 0)
               {
                  throw new Error("Forbidden value (" + this.jobXP + ") on element jobXP.");
               }
               else
               {
                  output.writeDouble(this.jobXP);
                  if(this.jobXpLevelFloor < 0)
                  {
                     throw new Error("Forbidden value (" + this.jobXpLevelFloor + ") on element jobXpLevelFloor.");
                  }
                  else
                  {
                     output.writeDouble(this.jobXpLevelFloor);
                     if(this.jobXpNextLevelFloor < 0)
                     {
                        throw new Error("Forbidden value (" + this.jobXpNextLevelFloor + ") on element jobXpNextLevelFloor.");
                     }
                     else
                     {
                        output.writeDouble(this.jobXpNextLevelFloor);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_JobExperience(input);
      }
      
      public function deserializeAs_JobExperience(input:IDataInput) : void {
         this.jobId = input.readByte();
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element of JobExperience.jobId.");
         }
         else
         {
            this.jobLevel = input.readByte();
            if(this.jobLevel < 0)
            {
               throw new Error("Forbidden value (" + this.jobLevel + ") on element of JobExperience.jobLevel.");
            }
            else
            {
               this.jobXP = input.readDouble();
               if(this.jobXP < 0)
               {
                  throw new Error("Forbidden value (" + this.jobXP + ") on element of JobExperience.jobXP.");
               }
               else
               {
                  this.jobXpLevelFloor = input.readDouble();
                  if(this.jobXpLevelFloor < 0)
                  {
                     throw new Error("Forbidden value (" + this.jobXpLevelFloor + ") on element of JobExperience.jobXpLevelFloor.");
                  }
                  else
                  {
                     this.jobXpNextLevelFloor = input.readDouble();
                     if(this.jobXpNextLevelFloor < 0)
                     {
                        throw new Error("Forbidden value (" + this.jobXpNextLevelFloor + ") on element of JobExperience.jobXpNextLevelFloor.");
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
}
