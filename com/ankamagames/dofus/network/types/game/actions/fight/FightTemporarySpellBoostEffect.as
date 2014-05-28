package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightTemporarySpellBoostEffect extends FightTemporaryBoostEffect implements INetworkType
   {
      
      public function FightTemporarySpellBoostEffect() {
         super();
      }
      
      public static const protocolId:uint = 207;
      
      public var boostedSpellId:uint = 0;
      
      override public function getTypeId() : uint {
         return 207;
      }
      
      public function initFightTemporarySpellBoostEffect(uid:uint = 0, targetId:int = 0, turnDuration:int = 0, dispelable:uint = 1, spellId:uint = 0, parentBoostUid:uint = 0, delta:int = 0, boostedSpellId:uint = 0) : FightTemporarySpellBoostEffect {
         super.initFightTemporaryBoostEffect(uid,targetId,turnDuration,dispelable,spellId,parentBoostUid,delta);
         this.boostedSpellId = boostedSpellId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.boostedSpellId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightTemporarySpellBoostEffect(output);
      }
      
      public function serializeAs_FightTemporarySpellBoostEffect(output:IDataOutput) : void {
         super.serializeAs_FightTemporaryBoostEffect(output);
         if(this.boostedSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.boostedSpellId + ") on element boostedSpellId.");
         }
         else
         {
            output.writeShort(this.boostedSpellId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightTemporarySpellBoostEffect(input);
      }
      
      public function deserializeAs_FightTemporarySpellBoostEffect(input:IDataInput) : void {
         super.deserialize(input);
         this.boostedSpellId = input.readShort();
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
