package com.ankamagames.dofus.network.types.game.achievement
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class Achievement extends Object implements INetworkType
   {
      
      public function Achievement() {
         this.finishedObjective = new Vector.<AchievementObjective>();
         this.startedObjectives = new Vector.<AchievementStartedObjective>();
         super();
      }
      
      public static const protocolId:uint = 363;
      
      public var id:uint = 0;
      
      public var finishedObjective:Vector.<AchievementObjective>;
      
      public var startedObjectives:Vector.<AchievementStartedObjective>;
      
      public function getTypeId() : uint {
         return 363;
      }
      
      public function initAchievement(param1:uint=0, param2:Vector.<AchievementObjective>=null, param3:Vector.<AchievementStartedObjective>=null) : Achievement {
         this.id = param1;
         this.finishedObjective = param2;
         this.startedObjectives = param3;
         return this;
      }
      
      public function reset() : void {
         this.id = 0;
         this.finishedObjective = new Vector.<AchievementObjective>();
         this.startedObjectives = new Vector.<AchievementStartedObjective>();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_Achievement(param1);
      }
      
      public function serializeAs_Achievement(param1:IDataOutput) : void {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            param1.writeShort(this.id);
            param1.writeShort(this.finishedObjective.length);
            _loc2_ = 0;
            while(_loc2_ < this.finishedObjective.length)
            {
               (this.finishedObjective[_loc2_] as AchievementObjective).serializeAs_AchievementObjective(param1);
               _loc2_++;
            }
            param1.writeShort(this.startedObjectives.length);
            _loc3_ = 0;
            while(_loc3_ < this.startedObjectives.length)
            {
               (this.startedObjectives[_loc3_] as AchievementStartedObjective).serializeAs_AchievementStartedObjective(param1);
               _loc3_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_Achievement(param1);
      }
      
      public function deserializeAs_Achievement(param1:IDataInput) : void {
         var _loc6_:AchievementObjective = null;
         var _loc7_:AchievementStartedObjective = null;
         this.id = param1.readShort();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of Achievement.id.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc6_ = new AchievementObjective();
               _loc6_.deserialize(param1);
               this.finishedObjective.push(_loc6_);
               _loc3_++;
            }
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc7_ = new AchievementStartedObjective();
               _loc7_.deserialize(param1);
               this.startedObjectives.push(_loc7_);
               _loc5_++;
            }
            return;
         }
      }
   }
}
