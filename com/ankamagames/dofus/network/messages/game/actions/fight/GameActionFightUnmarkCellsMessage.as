package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightUnmarkCellsMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightUnmarkCellsMessage() {
         super();
      }
      
      public static const protocolId:uint = 5570;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var markId:int = 0;
      
      override public function getMessageId() : uint {
         return 5570;
      }
      
      public function initGameActionFightUnmarkCellsMessage(actionId:uint = 0, sourceId:int = 0, markId:int = 0) : GameActionFightUnmarkCellsMessage {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.markId = markId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.markId = 0;
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
         this.serializeAs_GameActionFightUnmarkCellsMessage(output);
      }
      
      public function serializeAs_GameActionFightUnmarkCellsMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeShort(this.markId);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightUnmarkCellsMessage(input);
      }
      
      public function deserializeAs_GameActionFightUnmarkCellsMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.markId = input.readShort();
      }
   }
}
