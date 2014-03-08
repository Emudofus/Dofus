package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightTemporarySpellImmunityEffect extends AbstractFightDispellableEffect implements INetworkType
   {
      
      public function FightTemporarySpellImmunityEffect() {
         super();
      }
      
      public static const protocolId:uint = 366;
      
      public var immuneSpellId:int = 0;
      
      override public function getTypeId() : uint {
         return 366;
      }
      
      public function initFightTemporarySpellImmunityEffect(param1:uint=0, param2:int=0, param3:int=0, param4:uint=1, param5:uint=0, param6:uint=0, param7:int=0) : FightTemporarySpellImmunityEffect {
         super.initAbstractFightDispellableEffect(param1,param2,param3,param4,param5,param6);
         this.immuneSpellId = param7;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.immuneSpellId = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_FightTemporarySpellImmunityEffect(param1);
      }
      
      public function serializeAs_FightTemporarySpellImmunityEffect(param1:IDataOutput) : void {
         super.serializeAs_AbstractFightDispellableEffect(param1);
         param1.writeInt(this.immuneSpellId);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FightTemporarySpellImmunityEffect(param1);
      }
      
      public function deserializeAs_FightTemporarySpellImmunityEffect(param1:IDataInput) : void {
         super.deserialize(param1);
         this.immuneSpellId = param1.readInt();
      }
   }
}
