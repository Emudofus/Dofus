package com.ankamagames.dofus.network.types.game.achievement
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.*;
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
      
      public function initAchievement(id:uint=0, finishedObjective:Vector.<AchievementObjective>=null, startedObjectives:Vector.<AchievementStartedObjective>=null) : Achievement {
         this.id = id;
         this.finishedObjective = finishedObjective;
         this.startedObjectives = startedObjectives;
         return this;
      }
      
      public function reset() : void {
         this.id = 0;
         this.finishedObjective = new Vector.<AchievementObjective>();
         this.startedObjectives = new Vector.<AchievementStartedObjective>();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_Achievement(output);
      }
      
      public function serializeAs_Achievement(output:IDataOutput) : void {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            output.writeShort(this.id);
            output.writeShort(this.finishedObjective.length);
            _i2 = 0;
            while(_i2 < this.finishedObjective.length)
            {
               (this.finishedObjective[_i2] as AchievementObjective).serializeAs_AchievementObjective(output);
               _i2++;
            }
            output.writeShort(this.startedObjectives.length);
            _i3 = 0;
            while(_i3 < this.startedObjectives.length)
            {
               (this.startedObjectives[_i3] as AchievementStartedObjective).serializeAs_AchievementStartedObjective(output);
               _i3++;
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_Achievement(input);
      }
      
      public function deserializeAs_Achievement(input:IDataInput) : void {
         var _item2:AchievementObjective = null;
         var _item3:AchievementStartedObjective = null;
         this.id = input.readShort();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of Achievement.id.");
         }
         else
         {
            _finishedObjectiveLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _finishedObjectiveLen)
            {
               _item2 = new AchievementObjective();
               _item2.deserialize(input);
               this.finishedObjective.push(_item2);
               _i2++;
            }
            _startedObjectivesLen = input.readUnsignedShort();
            _i3 = 0;
            while(_i3 < _startedObjectivesLen)
            {
               _item3 = new AchievementStartedObjective();
               _item3.deserialize(input);
               this.startedObjectives.push(_item3);
               _i3++;
            }
            return;
         }
      }
   }
}
