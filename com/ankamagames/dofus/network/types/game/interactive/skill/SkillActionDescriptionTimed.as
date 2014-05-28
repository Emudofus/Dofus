package com.ankamagames.dofus.network.types.game.interactive.skill
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class SkillActionDescriptionTimed extends SkillActionDescription implements INetworkType
   {
      
      public function SkillActionDescriptionTimed() {
         super();
      }
      
      public static const protocolId:uint = 103;
      
      public var time:uint = 0;
      
      override public function getTypeId() : uint {
         return 103;
      }
      
      public function initSkillActionDescriptionTimed(skillId:uint = 0, time:uint = 0) : SkillActionDescriptionTimed {
         super.initSkillActionDescription(skillId);
         this.time = time;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.time = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_SkillActionDescriptionTimed(output);
      }
      
      public function serializeAs_SkillActionDescriptionTimed(output:IDataOutput) : void {
         super.serializeAs_SkillActionDescription(output);
         if((this.time < 0) || (this.time > 255))
         {
            throw new Error("Forbidden value (" + this.time + ") on element time.");
         }
         else
         {
            output.writeByte(this.time);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SkillActionDescriptionTimed(input);
      }
      
      public function deserializeAs_SkillActionDescriptionTimed(input:IDataInput) : void {
         super.deserialize(input);
         this.time = input.readUnsignedByte();
         if((this.time < 0) || (this.time > 255))
         {
            throw new Error("Forbidden value (" + this.time + ") on element of SkillActionDescriptionTimed.time.");
         }
         else
         {
            return;
         }
      }
   }
}
