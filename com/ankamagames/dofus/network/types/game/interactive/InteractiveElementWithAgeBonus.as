package com.ankamagames.dofus.network.types.game.interactive
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class InteractiveElementWithAgeBonus extends InteractiveElement implements INetworkType
   {
      
      public function InteractiveElementWithAgeBonus() {
         super();
      }
      
      public static const protocolId:uint = 398;
      
      public var ageBonus:int = 0;
      
      override public function getTypeId() : uint {
         return 398;
      }
      
      public function initInteractiveElementWithAgeBonus(elementId:uint = 0, elementTypeId:int = 0, enabledSkills:Vector.<InteractiveElementSkill> = null, disabledSkills:Vector.<InteractiveElementSkill> = null, ageBonus:int = 0) : InteractiveElementWithAgeBonus {
         super.initInteractiveElement(elementId,elementTypeId,enabledSkills,disabledSkills);
         this.ageBonus = ageBonus;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.ageBonus = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_InteractiveElementWithAgeBonus(output);
      }
      
      public function serializeAs_InteractiveElementWithAgeBonus(output:IDataOutput) : void {
         super.serializeAs_InteractiveElement(output);
         if((this.ageBonus < -1) || (this.ageBonus > 1000))
         {
            throw new Error("Forbidden value (" + this.ageBonus + ") on element ageBonus.");
         }
         else
         {
            output.writeShort(this.ageBonus);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InteractiveElementWithAgeBonus(input);
      }
      
      public function deserializeAs_InteractiveElementWithAgeBonus(input:IDataInput) : void {
         super.deserialize(input);
         this.ageBonus = input.readShort();
         if((this.ageBonus < -1) || (this.ageBonus > 1000))
         {
            throw new Error("Forbidden value (" + this.ageBonus + ") on element of InteractiveElementWithAgeBonus.ageBonus.");
         }
         else
         {
            return;
         }
      }
   }
}
