package com.ankamagames.dofus.network.types.game.achievement
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AchievementRewardable extends Object implements INetworkType
   {
      
      public function AchievementRewardable() {
         super();
      }
      
      public static const protocolId:uint = 412;
      
      public var id:uint = 0;
      
      public var finishedlevel:uint = 0;
      
      public function getTypeId() : uint {
         return 412;
      }
      
      public function initAchievementRewardable(id:uint = 0, finishedlevel:uint = 0) : AchievementRewardable {
         this.id = id;
         this.finishedlevel = finishedlevel;
         return this;
      }
      
      public function reset() : void {
         this.id = 0;
         this.finishedlevel = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_AchievementRewardable(output);
      }
      
      public function serializeAs_AchievementRewardable(output:IDataOutput) : void {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            output.writeShort(this.id);
            if((this.finishedlevel < 0) || (this.finishedlevel > 200))
            {
               throw new Error("Forbidden value (" + this.finishedlevel + ") on element finishedlevel.");
            }
            else
            {
               output.writeShort(this.finishedlevel);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AchievementRewardable(input);
      }
      
      public function deserializeAs_AchievementRewardable(input:IDataInput) : void {
         this.id = input.readShort();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of AchievementRewardable.id.");
         }
         else
         {
            this.finishedlevel = input.readShort();
            if((this.finishedlevel < 0) || (this.finishedlevel > 200))
            {
               throw new Error("Forbidden value (" + this.finishedlevel + ") on element of AchievementRewardable.finishedlevel.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
