package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import flash.utils.IDataInput;
   
   public class FightResultExperienceData extends FightResultAdditionalData implements INetworkType
   {
      
      public function FightResultExperienceData() {
         super();
      }
      
      public static const protocolId:uint = 192;
      
      public var experience:Number = 0;
      
      public var showExperience:Boolean = false;
      
      public var experienceLevelFloor:Number = 0;
      
      public var showExperienceLevelFloor:Boolean = false;
      
      public var experienceNextLevelFloor:Number = 0;
      
      public var showExperienceNextLevelFloor:Boolean = false;
      
      public var experienceFightDelta:int = 0;
      
      public var showExperienceFightDelta:Boolean = false;
      
      public var experienceForGuild:uint = 0;
      
      public var showExperienceForGuild:Boolean = false;
      
      public var experienceForMount:uint = 0;
      
      public var showExperienceForMount:Boolean = false;
      
      public var isIncarnationExperience:Boolean = false;
      
      public var rerollExperienceMul:int = 0;
      
      override public function getTypeId() : uint {
         return 192;
      }
      
      public function initFightResultExperienceData(experience:Number=0, showExperience:Boolean=false, experienceLevelFloor:Number=0, showExperienceLevelFloor:Boolean=false, experienceNextLevelFloor:Number=0, showExperienceNextLevelFloor:Boolean=false, experienceFightDelta:int=0, showExperienceFightDelta:Boolean=false, experienceForGuild:uint=0, showExperienceForGuild:Boolean=false, experienceForMount:uint=0, showExperienceForMount:Boolean=false, isIncarnationExperience:Boolean=false, rerollExperienceMul:int=0) : FightResultExperienceData {
         this.experience = experience;
         this.showExperience = showExperience;
         this.experienceLevelFloor = experienceLevelFloor;
         this.showExperienceLevelFloor = showExperienceLevelFloor;
         this.experienceNextLevelFloor = experienceNextLevelFloor;
         this.showExperienceNextLevelFloor = showExperienceNextLevelFloor;
         this.experienceFightDelta = experienceFightDelta;
         this.showExperienceFightDelta = showExperienceFightDelta;
         this.experienceForGuild = experienceForGuild;
         this.showExperienceForGuild = showExperienceForGuild;
         this.experienceForMount = experienceForMount;
         this.showExperienceForMount = showExperienceForMount;
         this.isIncarnationExperience = isIncarnationExperience;
         this.rerollExperienceMul = rerollExperienceMul;
         return this;
      }
      
      override public function reset() : void {
         this.experience = 0;
         this.showExperience = false;
         this.experienceLevelFloor = 0;
         this.showExperienceLevelFloor = false;
         this.experienceNextLevelFloor = 0;
         this.showExperienceNextLevelFloor = false;
         this.experienceFightDelta = 0;
         this.showExperienceFightDelta = false;
         this.experienceForGuild = 0;
         this.showExperienceForGuild = false;
         this.experienceForMount = 0;
         this.showExperienceForMount = false;
         this.isIncarnationExperience = false;
         this.rerollExperienceMul = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightResultExperienceData(output);
      }
      
      public function serializeAs_FightResultExperienceData(output:IDataOutput) : void {
         super.serializeAs_FightResultAdditionalData(output);
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.showExperience);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.showExperienceLevelFloor);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.showExperienceNextLevelFloor);
         _box0 = BooleanByteWrapper.setFlag(_box0,3,this.showExperienceFightDelta);
         _box0 = BooleanByteWrapper.setFlag(_box0,4,this.showExperienceForGuild);
         _box0 = BooleanByteWrapper.setFlag(_box0,5,this.showExperienceForMount);
         _box0 = BooleanByteWrapper.setFlag(_box0,6,this.isIncarnationExperience);
         output.writeByte(_box0);
         if(this.experience < 0)
         {
            throw new Error("Forbidden value (" + this.experience + ") on element experience.");
         }
         else
         {
            output.writeDouble(this.experience);
            if(this.experienceLevelFloor < 0)
            {
               throw new Error("Forbidden value (" + this.experienceLevelFloor + ") on element experienceLevelFloor.");
            }
            else
            {
               output.writeDouble(this.experienceLevelFloor);
               if(this.experienceNextLevelFloor < 0)
               {
                  throw new Error("Forbidden value (" + this.experienceNextLevelFloor + ") on element experienceNextLevelFloor.");
               }
               else
               {
                  output.writeDouble(this.experienceNextLevelFloor);
                  output.writeInt(this.experienceFightDelta);
                  if(this.experienceForGuild < 0)
                  {
                     throw new Error("Forbidden value (" + this.experienceForGuild + ") on element experienceForGuild.");
                  }
                  else
                  {
                     output.writeInt(this.experienceForGuild);
                     if(this.experienceForMount < 0)
                     {
                        throw new Error("Forbidden value (" + this.experienceForMount + ") on element experienceForMount.");
                     }
                     else
                     {
                        output.writeInt(this.experienceForMount);
                        output.writeInt(this.rerollExperienceMul);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightResultExperienceData(input);
      }
      
      public function deserializeAs_FightResultExperienceData(input:IDataInput) : void {
         super.deserialize(input);
         var _box0:uint = input.readByte();
         this.showExperience = BooleanByteWrapper.getFlag(_box0,0);
         this.showExperienceLevelFloor = BooleanByteWrapper.getFlag(_box0,1);
         this.showExperienceNextLevelFloor = BooleanByteWrapper.getFlag(_box0,2);
         this.showExperienceFightDelta = BooleanByteWrapper.getFlag(_box0,3);
         this.showExperienceForGuild = BooleanByteWrapper.getFlag(_box0,4);
         this.showExperienceForMount = BooleanByteWrapper.getFlag(_box0,5);
         this.isIncarnationExperience = BooleanByteWrapper.getFlag(_box0,6);
         this.experience = input.readDouble();
         if(this.experience < 0)
         {
            throw new Error("Forbidden value (" + this.experience + ") on element of FightResultExperienceData.experience.");
         }
         else
         {
            this.experienceLevelFloor = input.readDouble();
            if(this.experienceLevelFloor < 0)
            {
               throw new Error("Forbidden value (" + this.experienceLevelFloor + ") on element of FightResultExperienceData.experienceLevelFloor.");
            }
            else
            {
               this.experienceNextLevelFloor = input.readDouble();
               if(this.experienceNextLevelFloor < 0)
               {
                  throw new Error("Forbidden value (" + this.experienceNextLevelFloor + ") on element of FightResultExperienceData.experienceNextLevelFloor.");
               }
               else
               {
                  this.experienceFightDelta = input.readInt();
                  this.experienceForGuild = input.readInt();
                  if(this.experienceForGuild < 0)
                  {
                     throw new Error("Forbidden value (" + this.experienceForGuild + ") on element of FightResultExperienceData.experienceForGuild.");
                  }
                  else
                  {
                     this.experienceForMount = input.readInt();
                     if(this.experienceForMount < 0)
                     {
                        throw new Error("Forbidden value (" + this.experienceForMount + ") on element of FightResultExperienceData.experienceForMount.");
                     }
                     else
                     {
                        this.rerollExperienceMul = input.readInt();
                        return;
                     }
                  }
               }
            }
         }
      }
   }
}
