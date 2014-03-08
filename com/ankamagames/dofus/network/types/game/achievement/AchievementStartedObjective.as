package com.ankamagames.dofus.network.types.game.achievement
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AchievementStartedObjective extends AchievementObjective implements INetworkType
   {
      
      public function AchievementStartedObjective() {
         super();
      }
      
      public static const protocolId:uint = 402;
      
      public var value:uint = 0;
      
      override public function getTypeId() : uint {
         return 402;
      }
      
      public function initAchievementStartedObjective(param1:uint=0, param2:uint=0, param3:uint=0) : AchievementStartedObjective {
         super.initAchievementObjective(param1,param2);
         this.value = param3;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.value = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AchievementStartedObjective(param1);
      }
      
      public function serializeAs_AchievementStartedObjective(param1:IDataOutput) : void {
         super.serializeAs_AchievementObjective(param1);
         if(this.value < 0)
         {
            throw new Error("Forbidden value (" + this.value + ") on element value.");
         }
         else
         {
            param1.writeShort(this.value);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AchievementStartedObjective(param1);
      }
      
      public function deserializeAs_AchievementStartedObjective(param1:IDataInput) : void {
         super.deserialize(param1);
         this.value = param1.readShort();
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
