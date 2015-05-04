package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class FightTemporaryBoostEffect extends AbstractFightDispellableEffect implements INetworkType
   {
      
      public function FightTemporaryBoostEffect()
      {
         super();
      }
      
      public static const protocolId:uint = 209;
      
      public var delta:int = 0;
      
      override public function getTypeId() : uint
      {
         return 209;
      }
      
      public function initFightTemporaryBoostEffect(param1:uint = 0, param2:int = 0, param3:int = 0, param4:uint = 1, param5:uint = 0, param6:uint = 0, param7:uint = 0, param8:int = 0) : FightTemporaryBoostEffect
      {
         super.initAbstractFightDispellableEffect(param1,param2,param3,param4,param5,param6,param7);
         this.delta = param8;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.delta = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_FightTemporaryBoostEffect(param1);
      }
      
      public function serializeAs_FightTemporaryBoostEffect(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractFightDispellableEffect(param1);
         param1.writeShort(this.delta);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_FightTemporaryBoostEffect(param1);
      }
      
      public function deserializeAs_FightTemporaryBoostEffect(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.delta = param1.readShort();
      }
   }
}
