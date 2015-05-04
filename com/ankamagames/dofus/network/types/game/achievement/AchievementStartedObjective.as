package com.ankamagames.dofus.network.types.game.achievement
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AchievementStartedObjective extends AchievementObjective implements INetworkType
   {
      
      public function AchievementStartedObjective()
      {
         super();
      }
      
      public static const protocolId:uint = 402;
      
      public var value:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 402;
      }
      
      public function initAchievementStartedObjective(param1:uint = 0, param2:uint = 0, param3:uint = 0) : AchievementStartedObjective
      {
         super.initAchievementObjective(param1,param2);
         this.value = param3;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.value = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_AchievementStartedObjective(param1);
      }
      
      public function serializeAs_AchievementStartedObjective(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AchievementObjective(param1);
         if(this.value < 0)
         {
            throw new Error("Forbidden value (" + this.value + ") on element value.");
         }
         else
         {
            param1.writeVarShort(this.value);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementStartedObjective(param1);
      }
      
      public function deserializeAs_AchievementStartedObjective(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.value = param1.readVarUhShort();
         if(this.value < 0)
         {
            throw new Error("Forbidden value (" + this.value + ") on element of AchievementStartedObjective.value.");
         }
         else
         {
            return;
         }
      }
   }
}
