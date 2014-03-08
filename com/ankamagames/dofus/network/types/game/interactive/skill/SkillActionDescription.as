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
      
      public function initSkillActionDescription(param1:uint=0) : SkillActionDescription {
         this.skillId = param1;
         return this;
      }
      
      public function reset() : void {
         this.skillId = 0;
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_SkillActionDescription(param1);
      }
      
      public function serializeAs_SkillActionDescription(param1:IDataOutput) : void {
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
         }
         else
         {
            param1.writeShort(this.skillId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_SkillActionDescription(param1);
      }
      
      public function deserializeAs_SkillActionDescription(param1:IDataInput) : void {
         this.skillId = param1.readShort();
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
