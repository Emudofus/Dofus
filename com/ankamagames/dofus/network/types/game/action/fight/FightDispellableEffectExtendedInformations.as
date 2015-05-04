package com.ankamagames.dofus.network.types.game.action.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.actions.fight.AbstractFightDispellableEffect;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class FightDispellableEffectExtendedInformations extends Object implements INetworkType
   {
      
      public function FightDispellableEffectExtendedInformations()
      {
         this.effect = new AbstractFightDispellableEffect();
         super();
      }
      
      public static const protocolId:uint = 208;
      
      public var actionId:uint = 0;
      
      public var sourceId:int = 0;
      
      public var effect:AbstractFightDispellableEffect;
      
      public function getTypeId() : uint
      {
         return 208;
      }
      
      public function initFightDispellableEffectExtendedInformations(param1:uint = 0, param2:int = 0, param3:AbstractFightDispellableEffect = null) : FightDispellableEffectExtendedInformations
      {
         this.actionId = param1;
         this.sourceId = param2;
         this.effect = param3;
         return this;
      }
      
      public function reset() : void
      {
         this.actionId = 0;
         this.sourceId = 0;
         this.effect = new AbstractFightDispellableEffect();
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_FightDispellableEffectExtendedInformations(param1);
      }
      
      public function serializeAs_FightDispellableEffectExtendedInformations(param1:ICustomDataOutput) : void
      {
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
         }
         else
         {
            param1.writeVarShort(this.actionId);
            param1.writeInt(this.sourceId);
            param1.writeShort(this.effect.getTypeId());
            this.effect.serialize(param1);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_FightDispellableEffectExtendedInformations(param1);
      }
      
      public function deserializeAs_FightDispellableEffectExtendedInformations(param1:ICustomDataInput) : void
      {
         this.actionId = param1.readVarUhShort();
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element of FightDispellableEffectExtendedInformations.actionId.");
         }
         else
         {
            this.sourceId = param1.readInt();
            var _loc2_:uint = param1.readUnsignedShort();
            this.effect = ProtocolTypeManager.getInstance(AbstractFightDispellableEffect,_loc2_);
            this.effect.deserialize(param1);
            return;
         }
      }
   }
}
