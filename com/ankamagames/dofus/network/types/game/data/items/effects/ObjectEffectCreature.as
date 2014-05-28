package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ObjectEffectCreature extends ObjectEffect implements INetworkType
   {
      
      public function ObjectEffectCreature() {
         super();
      }
      
      public static const protocolId:uint = 71;
      
      public var monsterFamilyId:uint = 0;
      
      override public function getTypeId() : uint {
         return 71;
      }
      
      public function initObjectEffectCreature(actionId:uint = 0, monsterFamilyId:uint = 0) : ObjectEffectCreature {
         super.initObjectEffect(actionId);
         this.monsterFamilyId = monsterFamilyId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.monsterFamilyId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectEffectCreature(output);
      }
      
      public function serializeAs_ObjectEffectCreature(output:IDataOutput) : void {
         super.serializeAs_ObjectEffect(output);
         if(this.monsterFamilyId < 0)
         {
            throw new Error("Forbidden value (" + this.monsterFamilyId + ") on element monsterFamilyId.");
         }
         else
         {
            output.writeShort(this.monsterFamilyId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectEffectCreature(input);
      }
      
      public function deserializeAs_ObjectEffectCreature(input:IDataInput) : void {
         super.deserialize(input);
         this.monsterFamilyId = input.readShort();
         if(this.monsterFamilyId < 0)
         {
            throw new Error("Forbidden value (" + this.monsterFamilyId + ") on element of ObjectEffectCreature.monsterFamilyId.");
         }
         else
         {
            return;
         }
      }
   }
}
