package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightTriggerEffectMessage extends GameActionFightDispellEffectMessage implements INetworkMessage
   {
      
      public function GameActionFightTriggerEffectMessage() {
         super();
      }
      
      public static const protocolId:uint = 6147;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 6147;
      }
      
      public function initGameActionFightTriggerEffectMessage(actionId:uint = 0, sourceId:int = 0, targetId:int = 0, boostUID:uint = 0) : GameActionFightTriggerEffectMessage {
         super.initGameActionFightDispellEffectMessage(actionId,sourceId,targetId,boostUID);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
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
         this.serializeAs_GameActionFightTriggerEffectMessage(output);
      }
      
      public function serializeAs_GameActionFightTriggerEffectMessage(output:IDataOutput) : void {
         super.serializeAs_GameActionFightDispellEffectMessage(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightTriggerEffectMessage(input);
      }
      
      public function deserializeAs_GameActionFightTriggerEffectMessage(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
