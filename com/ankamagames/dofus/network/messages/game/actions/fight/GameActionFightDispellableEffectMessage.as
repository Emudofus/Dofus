package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.actions.fight.AbstractFightDispellableEffect;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameActionFightDispellableEffectMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightDispellableEffectMessage() {
         this.effect = new AbstractFightDispellableEffect();
         super();
      }
      
      public static const protocolId:uint = 6070;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var effect:AbstractFightDispellableEffect;
      
      override public function getMessageId() : uint {
         return 6070;
      }
      
      public function initGameActionFightDispellableEffectMessage(actionId:uint=0, sourceId:int=0, effect:AbstractFightDispellableEffect=null) : GameActionFightDispellableEffectMessage {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.effect = effect;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.effect = new AbstractFightDispellableEffect();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameActionFightDispellableEffectMessage(output);
      }
      
      public function serializeAs_GameActionFightDispellableEffectMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeShort(this.effect.getTypeId());
         this.effect.serialize(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightDispellableEffectMessage(input);
      }
      
      public function deserializeAs_GameActionFightDispellableEffectMessage(input:IDataInput) : void {
         super.deserialize(input);
         var _id1:uint = input.readUnsignedShort();
         this.effect = ProtocolTypeManager.getInstance(AbstractFightDispellableEffect,_id1);
         this.effect.deserialize(input);
      }
   }
}
