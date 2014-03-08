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
      
      public function initGameActionFightDispellableEffectMessage(param1:uint=0, param2:int=0, param3:AbstractFightDispellableEffect=null) : GameActionFightDispellableEffectMessage {
         super.initAbstractGameActionMessage(param1,param2);
         this.effect = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.effect = new AbstractFightDispellableEffect();
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameActionFightDispellableEffectMessage(param1);
      }
      
      public function serializeAs_GameActionFightDispellableEffectMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(param1);
         param1.writeShort(this.effect.getTypeId());
         this.effect.serialize(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameActionFightDispellableEffectMessage(param1);
      }
      
      public function deserializeAs_GameActionFightDispellableEffectMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         this.effect = ProtocolTypeManager.getInstance(AbstractFightDispellableEffect,_loc2_);
         this.effect.deserialize(param1);
      }
   }
}
