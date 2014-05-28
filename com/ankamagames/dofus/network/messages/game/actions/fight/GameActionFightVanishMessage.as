package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightVanishMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightVanishMessage() {
         super();
      }
      
      public static const protocolId:uint = 6217;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var targetId:int = 0;
      
      override public function getMessageId() : uint {
         return 6217;
      }
      
      public function initGameActionFightVanishMessage(actionId:uint = 0, sourceId:int = 0, targetId:int = 0) : GameActionFightVanishMessage {
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
         this.serializeAs_GameActionFightVanishMessage(output);
      }
      
      public function serializeAs_GameActionFightVanishMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeInt(this.targetId);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightVanishMessage(input);
      }
      
      public function deserializeAs_GameActionFightVanishMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.targetId = input.readInt();
      }
   }
}
