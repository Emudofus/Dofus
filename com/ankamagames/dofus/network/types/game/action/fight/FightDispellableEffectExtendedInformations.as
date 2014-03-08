package com.ankamagames.dofus.network.types.game.action.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.actions.fight.AbstractFightDispellableEffect;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class FightDispellableEffectExtendedInformations extends Object implements INetworkType
   {
      
      public function FightDispellableEffectExtendedInformations() {
         this.effect = new AbstractFightDispellableEffect();
         super();
      }
      
      public static const protocolId:uint = 208;
      
      public var actionId:uint = 0;
      
      public var sourceId:int = 0;
      
      public var effect:AbstractFightDispellableEffect;
      
      public function getTypeId() : uint {
         return 208;
      }
      
      public function initFightDispellableEffectExtendedInformations(actionId:uint=0, sourceId:int=0, effect:AbstractFightDispellableEffect=null) : FightDispellableEffectExtendedInformations {
         this.actionId = actionId;
         this.sourceId = sourceId;
         this.effect = effect;
         return this;
      }
      
      public function reset() : void {
         this.actionId = 0;
         this.sourceId = 0;
         this.effect = new AbstractFightDispellableEffect();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightDispellableEffectExtendedInformations(output);
      }
      
      public function serializeAs_FightDispellableEffectExtendedInformations(output:IDataOutput) : void {
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
         }
         else
         {
            output.writeShort(this.actionId);
            output.writeInt(this.sourceId);
            output.writeShort(this.effect.getTypeId());
            this.effect.serialize(output);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightDispellableEffectExtendedInformations(input);
      }
      
      public function deserializeAs_FightDispellableEffectExtendedInformations(input:IDataInput) : void {
         this.actionId = input.readShort();
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element of FightDispellableEffectExtendedInformations.actionId.");
         }
         else
         {
            this.sourceId = input.readInt();
            _id3 = input.readUnsignedShort();
            this.effect = ProtocolTypeManager.getInstance(AbstractFightDispellableEffect,_id3);
            this.effect.deserialize(input);
            return;
         }
      }
   }
}
