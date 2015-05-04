package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ObjectEffectCreature extends ObjectEffect implements INetworkType
   {
      
      public function ObjectEffectCreature()
      {
         super();
      }
      
      public static const protocolId:uint = 71;
      
      public var monsterFamilyId:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 71;
      }
      
      public function initObjectEffectCreature(param1:uint = 0, param2:uint = 0) : ObjectEffectCreature
      {
         super.initObjectEffect(param1);
         this.monsterFamilyId = param2;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.monsterFamilyId = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectEffectCreature(param1);
      }
      
      public function serializeAs_ObjectEffectCreature(param1:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectEffect(param1);
         if(this.monsterFamilyId < 0)
         {
            throw new Error("Forbidden value (" + this.monsterFamilyId + ") on element monsterFamilyId.");
         }
         else
         {
            param1.writeVarShort(this.monsterFamilyId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectEffectCreature(param1);
      }
      
      public function deserializeAs_ObjectEffectCreature(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.monsterFamilyId = param1.readVarUhShort();
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
