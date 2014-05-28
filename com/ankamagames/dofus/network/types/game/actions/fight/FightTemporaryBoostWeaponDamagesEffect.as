package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightTemporaryBoostWeaponDamagesEffect extends FightTemporaryBoostEffect implements INetworkType
   {
      
      public function FightTemporaryBoostWeaponDamagesEffect() {
         super();
      }
      
      public static const protocolId:uint = 211;
      
      public var weaponTypeId:int = 0;
      
      override public function getTypeId() : uint {
         return 211;
      }
      
      public function initFightTemporaryBoostWeaponDamagesEffect(uid:uint = 0, targetId:int = 0, turnDuration:int = 0, dispelable:uint = 1, spellId:uint = 0, parentBoostUid:uint = 0, delta:int = 0, weaponTypeId:int = 0) : FightTemporaryBoostWeaponDamagesEffect {
         super.initFightTemporaryBoostEffect(uid,targetId,turnDuration,dispelable,spellId,parentBoostUid,delta);
         this.weaponTypeId = weaponTypeId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.weaponTypeId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightTemporaryBoostWeaponDamagesEffect(output);
      }
      
      public function serializeAs_FightTemporaryBoostWeaponDamagesEffect(output:IDataOutput) : void {
         super.serializeAs_FightTemporaryBoostEffect(output);
         output.writeShort(this.weaponTypeId);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightTemporaryBoostWeaponDamagesEffect(input);
      }
      
      public function deserializeAs_FightTemporaryBoostWeaponDamagesEffect(input:IDataInput) : void {
         super.deserialize(input);
         this.weaponTypeId = input.readShort();
      }
   }
}
