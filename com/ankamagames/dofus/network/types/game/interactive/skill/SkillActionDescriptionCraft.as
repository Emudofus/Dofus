package com.ankamagames.dofus.network.types.game.interactive.skill
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class SkillActionDescriptionCraft extends SkillActionDescription implements INetworkType
   {
      
      public function SkillActionDescriptionCraft()
      {
         super();
      }
      
      public static const protocolId:uint = 100;
      
      public var maxSlots:uint = 0;
      
      public var probability:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 100;
      }
      
      public function initSkillActionDescriptionCraft(param1:uint = 0, param2:uint = 0, param3:uint = 0) : SkillActionDescriptionCraft
      {
         super.initSkillActionDescription(param1);
         this.maxSlots = param2;
         this.probability = param3;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.maxSlots = 0;
         this.probability = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_SkillActionDescriptionCraft(param1);
      }
      
      public function serializeAs_SkillActionDescriptionCraft(param1:ICustomDataOutput) : void
      {
         super.serializeAs_SkillActionDescription(param1);
         if(this.maxSlots < 0)
         {
            throw new Error("Forbidden value (" + this.maxSlots + ") on element maxSlots.");
         }
         else
         {
            param1.writeByte(this.maxSlots);
            if(this.probability < 0)
            {
               throw new Error("Forbidden value (" + this.probability + ") on element probability.");
            }
            else
            {
               param1.writeByte(this.probability);
               return;
            }
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_SkillActionDescriptionCraft(param1);
      }
      
      public function deserializeAs_SkillActionDescriptionCraft(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.maxSlots = param1.readByte();
         if(this.maxSlots < 0)
         {
            throw new Error("Forbidden value (" + this.maxSlots + ") on element of SkillActionDescriptionCraft.maxSlots.");
         }
         else
         {
            this.probability = param1.readByte();
            if(this.probability < 0)
            {
               throw new Error("Forbidden value (" + this.probability + ") on element of SkillActionDescriptionCraft.probability.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
