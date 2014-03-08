package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightTemporaryBoostEffect extends AbstractFightDispellableEffect implements INetworkType
   {
      
      public function FightTemporaryBoostEffect() {
         super();
      }
      
      public static const protocolId:uint = 209;
      
      public var delta:int = 0;
      
      override public function getTypeId() : uint {
         return 209;
      }
      
      public function initFightTemporaryBoostEffect(uid:uint=0, targetId:int=0, turnDuration:int=0, dispelable:uint=1, spellId:uint=0, parentBoostUid:uint=0, delta:int=0) : FightTemporaryBoostEffect {
         super.initAbstractFightDispellableEffect(uid,targetId,turnDuration,dispelable,spellId,parentBoostUid);
         this.delta = delta;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.delta = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightTemporaryBoostEffect(output);
      }
      
      public function serializeAs_FightTemporaryBoostEffect(output:IDataOutput) : void {
         super.serializeAs_AbstractFightDispellableEffect(output);
         output.writeShort(this.delta);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightTemporaryBoostEffect(input);
      }
      
      public function deserializeAs_FightTemporaryBoostEffect(input:IDataInput) : void {
         super.deserialize(input);
         this.delta = input.readShort();
      }
   }
}
