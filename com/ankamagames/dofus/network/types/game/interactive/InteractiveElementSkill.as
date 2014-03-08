package com.ankamagames.dofus.network.types.game.interactive
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class InteractiveElementSkill extends Object implements INetworkType
   {
      
      public function InteractiveElementSkill() {
         super();
      }
      
      public static const protocolId:uint = 219;
      
      public var skillId:uint = 0;
      
      public var skillInstanceUid:uint = 0;
      
      public function getTypeId() : uint {
         return 219;
      }
      
      public function initInteractiveElementSkill(skillId:uint=0, skillInstanceUid:uint=0) : InteractiveElementSkill {
         this.skillId = skillId;
         this.skillInstanceUid = skillInstanceUid;
         return this;
      }
      
      public function reset() : void {
         this.skillId = 0;
         this.skillInstanceUid = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_InteractiveElementSkill(output);
      }
      
      public function serializeAs_InteractiveElementSkill(output:IDataOutput) : void {
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
         }
         else
         {
            output.writeInt(this.skillId);
            if(this.skillInstanceUid < 0)
            {
               throw new Error("Forbidden value (" + this.skillInstanceUid + ") on element skillInstanceUid.");
            }
            else
            {
               output.writeInt(this.skillInstanceUid);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InteractiveElementSkill(input);
      }
      
      public function deserializeAs_InteractiveElementSkill(input:IDataInput) : void {
         this.skillId = input.readInt();
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element of InteractiveElementSkill.skillId.");
         }
         else
         {
            this.skillInstanceUid = input.readInt();
            if(this.skillInstanceUid < 0)
            {
               throw new Error("Forbidden value (" + this.skillInstanceUid + ") on element of InteractiveElementSkill.skillInstanceUid.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
