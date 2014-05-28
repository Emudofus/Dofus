package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMark;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightMarkCellsMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightMarkCellsMessage() {
         this.mark = new GameActionMark();
         super();
      }
      
      public static const protocolId:uint = 5540;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var mark:GameActionMark;
      
      override public function getMessageId() : uint {
         return 5540;
      }
      
      public function initGameActionFightMarkCellsMessage(actionId:uint = 0, sourceId:int = 0, mark:GameActionMark = null) : GameActionFightMarkCellsMessage {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.mark = mark;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.mark = new GameActionMark();
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
         this.serializeAs_GameActionFightMarkCellsMessage(output);
      }
      
      public function serializeAs_GameActionFightMarkCellsMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(output);
         this.mark.serializeAs_GameActionMark(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightMarkCellsMessage(input);
      }
      
      public function deserializeAs_GameActionFightMarkCellsMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.mark = new GameActionMark();
         this.mark.deserialize(input);
      }
   }
}
