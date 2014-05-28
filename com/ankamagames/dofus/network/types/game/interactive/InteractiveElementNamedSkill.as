package com.ankamagames.dofus.network.types.game.interactive
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class InteractiveElementNamedSkill extends InteractiveElementSkill implements INetworkType
   {
      
      public function InteractiveElementNamedSkill() {
         super();
      }
      
      public static const protocolId:uint = 220;
      
      public var nameId:uint = 0;
      
      override public function getTypeId() : uint {
         return 220;
      }
      
      public function initInteractiveElementNamedSkill(skillId:uint = 0, skillInstanceUid:uint = 0, nameId:uint = 0) : InteractiveElementNamedSkill {
         super.initInteractiveElementSkill(skillId,skillInstanceUid);
         this.nameId = nameId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.nameId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_InteractiveElementNamedSkill(output);
      }
      
      public function serializeAs_InteractiveElementNamedSkill(output:IDataOutput) : void {
         super.serializeAs_InteractiveElementSkill(output);
         if(this.nameId < 0)
         {
            throw new Error("Forbidden value (" + this.nameId + ") on element nameId.");
         }
         else
         {
            output.writeInt(this.nameId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InteractiveElementNamedSkill(input);
      }
      
      public function deserializeAs_InteractiveElementNamedSkill(input:IDataInput) : void {
         super.deserialize(input);
         this.nameId = input.readInt();
         if(this.nameId < 0)
         {
            throw new Error("Forbidden value (" + this.nameId + ") on element of InteractiveElementNamedSkill.nameId.");
         }
         else
         {
            return;
         }
      }
   }
}
