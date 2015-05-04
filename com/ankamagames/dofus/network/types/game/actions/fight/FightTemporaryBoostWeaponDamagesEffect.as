package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class FightTemporaryBoostWeaponDamagesEffect extends FightTemporaryBoostEffect implements INetworkType
   {
      
      public function FightTemporaryBoostWeaponDamagesEffect()
      {
         super();
      }
      
      public static const protocolId:uint = 211;
      
      public var weaponTypeId:int = 0;
      
      override public function getTypeId() : uint
      {
         return 211;
      }
      
      public function initFightTemporaryBoostWeaponDamagesEffect(param1:uint = 0, param2:int = 0, param3:int = 0, param4:uint = 1, param5:uint = 0, param6:uint = 0, param7:uint = 0, param8:int = 0, param9:int = 0) : FightTemporaryBoostWeaponDamagesEffect
      {
         super.initFightTemporaryBoostEffect(param1,param2,param3,param4,param5,param6,param7,param8);
         this.weaponTypeId = param9;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.weaponTypeId = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_FightTemporaryBoostWeaponDamagesEffect(param1);
      }
      
      public function serializeAs_FightTemporaryBoostWeaponDamagesEffect(param1:ICustomDataOutput) : void
      {
         super.serializeAs_FightTemporaryBoostEffect(param1);
         param1.writeShort(this.weaponTypeId);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_FightTemporaryBoostWeaponDamagesEffect(param1);
      }
      
      public function deserializeAs_FightTemporaryBoostWeaponDamagesEffect(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.weaponTypeId = param1.readShort();
      }
   }
}
