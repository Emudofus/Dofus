package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class FightTemporarySpellBoostEffect extends FightTemporaryBoostEffect implements INetworkType
   {
      
      public function FightTemporarySpellBoostEffect()
      {
         super();
      }
      
      public static const protocolId:uint = 207;
      
      public var boostedSpellId:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 207;
      }
      
      public function initFightTemporarySpellBoostEffect(param1:uint = 0, param2:int = 0, param3:int = 0, param4:uint = 1, param5:uint = 0, param6:uint = 0, param7:uint = 0, param8:int = 0, param9:uint = 0) : FightTemporarySpellBoostEffect
      {
         super.initFightTemporaryBoostEffect(param1,param2,param3,param4,param5,param6,param7,param8);
         this.boostedSpellId = param9;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.boostedSpellId = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_FightTemporarySpellBoostEffect(param1);
      }
      
      public function serializeAs_FightTemporarySpellBoostEffect(param1:ICustomDataOutput) : void
      {
         super.serializeAs_FightTemporaryBoostEffect(param1);
         if(this.boostedSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.boostedSpellId + ") on element boostedSpellId.");
         }
         else
         {
            param1.writeVarShort(this.boostedSpellId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_FightTemporarySpellBoostEffect(param1);
      }
      
      public function deserializeAs_FightTemporarySpellBoostEffect(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.boostedSpellId = param1.readVarUhShort();
         if(this.boostedSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.boostedSpellId + ") on element of FightTemporarySpellBoostEffect.boostedSpellId.");
         }
         else
         {
            return;
         }
      }
   }
}
