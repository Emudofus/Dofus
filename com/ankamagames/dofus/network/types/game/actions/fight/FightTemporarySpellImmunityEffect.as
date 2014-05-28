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
      
      public function initFightTemporarySpellImmunityEffect(uid:uint = 0, targetId:int = 0, turnDuration:int = 0, dispelable:uint = 1, spellId:uint = 0, parentBoostUid:uint = 0, immuneSpellId:int = 0) : FightTemporarySpellImmunityEffect {
         super.initAbstractFightDispellableEffect(uid,targetId,turnDuration,dispelable,spellId,parentBoostUid);
         this.immuneSpellId = immuneSpellId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.immuneSpellId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightTemporarySpellImmunityEffect(output);
      }
      
      public function serializeAs_FightTemporarySpellImmunityEffect(output:IDataOutput) : void {
         super.serializeAs_AbstractFightDispellableEffect(output);
         output.writeInt(this.immuneSpellId);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightTemporarySpellImmunityEffect(input);
      }
      
      public function deserializeAs_FightTemporarySpellImmunityEffect(input:IDataInput) : void {
         super.deserialize(input);
         this.immuneSpellId = input.readInt();
      }
   }
}
