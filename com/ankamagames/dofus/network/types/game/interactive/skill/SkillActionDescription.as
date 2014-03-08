package com.ankamagames.dofus.network.types.game.interactive.skill
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class SkillActionDescription extends Object implements INetworkType
   {
      
      public function SkillActionDescription() {
         super();
      }
      
      public static const protocolId:uint = 102;
      
      public var skillId:uint = 0;
      
      public function getTypeId() : uint {
         return 102;
      }
      
      public function initSkillActionDescription(skillId:uint=0) : SkillActionDescription {
         this.skillId = skillId;
         return this;
      }
      
      public function reset() : void {
         this.skillId = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_SkillActionDescription(output);
      }
      
      public function serializeAs_SkillActionDescription(output:IDataOutput) : void {
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
         }
         else
         {
            output.writeShort(this.skillId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SkillActionDescription(input);
      }
      
      public function deserializeAs_SkillActionDescription(input:IDataInput) : void {
         this.skillId = input.readShort();
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element of SkillActionDescription.skillId.");
         }
         else
         {
            return;
         }
      }
   }
}
