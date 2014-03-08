package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightDeathMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightDeathMessage() {
         super();
      }
      
      public static const protocolId:uint = 1099;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var targetId:int = 0;
      
      override public function getMessageId() : uint {
         return 1099;
      }
      
      public function initGameActionFightDeathMessage(actionId:uint=0, sourceId:int=0, targetId:int=0) : GameActionFightDeathMessage {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.targetId = targetId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.targetId = 0;
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
         this.serializeAs_GameActionFightDeathMessage(output);
      }
      
      public function serializeAs_GameActionFightDeathMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeInt(this.targetId);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightDeathMessage(input);
      }
      
      public function deserializeAs_GameActionFightDeathMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.targetId = input.readInt();
      }
   }
}
