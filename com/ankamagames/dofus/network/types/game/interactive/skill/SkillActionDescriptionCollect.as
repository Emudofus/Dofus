package com.ankamagames.dofus.network.types.game.interactive.skill
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class SkillActionDescriptionCollect extends SkillActionDescriptionTimed implements INetworkType
   {
      
      public function SkillActionDescriptionCollect() {
         super();
      }
      
      public static const protocolId:uint = 99;
      
      public var min:uint = 0;
      
      public var max:uint = 0;
      
      override public function getTypeId() : uint {
         return 99;
      }
      
      public function initSkillActionDescriptionCollect(param1:uint=0, param2:uint=0, param3:uint=0, param4:uint=0) : SkillActionDescriptionCollect {
         super.initSkillActionDescriptionTimed(param1,param2);
         this.min = param3;
         this.max = param4;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.min = 0;
         this.max = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_SkillActionDescriptionCollect(param1);
      }
      
      public function serializeAs_SkillActionDescriptionCollect(param1:IDataOutput) : void {
         super.serializeAs_SkillActionDescriptionTimed(param1);
         if(this.min < 0)
         {
            throw new Error("Forbidden value (" + this.min + ") on element min.");
         }
         else
         {
            param1.writeShort(this.min);
            if(this.max < 0)
            {
               throw new Error("Forbidden value (" + this.max + ") on element max.");
            }
            else
            {
               param1.writeShort(this.max);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_SkillActionDescriptionCollect(param1);
      }
      
      public function deserializeAs_SkillActionDescriptionCollect(param1:IDataInput) : void {
         super.deserialize(param1);
         this.min = param1.readShort();
         if(this.min < 0)
         {
            throw new Error("Forbidden value (" + this.min + ") on element of SkillActionDescriptionCollect.min.");
         }
         else
         {
            this.max = param1.readShort();
            if(this.max < 0)
            {
               throw new Error("Forbidden value (" + this.max + ") on element of SkillActionDescriptionCollect.max.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
