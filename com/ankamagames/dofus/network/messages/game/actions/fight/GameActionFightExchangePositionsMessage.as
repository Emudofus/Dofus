package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightExchangePositionsMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightExchangePositionsMessage() {
         super();
      }
      
      public static const protocolId:uint = 5527;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var targetId:int = 0;
      
      public var casterCellId:int = 0;
      
      public var targetCellId:int = 0;
      
      override public function getMessageId() : uint {
         return 5527;
      }
      
      public function initGameActionFightExchangePositionsMessage(actionId:uint = 0, sourceId:int = 0, targetId:int = 0, casterCellId:int = 0, targetCellId:int = 0) : GameActionFightExchangePositionsMessage {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.targetId = targetId;
         this.casterCellId = casterCellId;
         this.targetCellId = targetCellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.targetId = 0;
         this.casterCellId = 0;
         this.targetCellId = 0;
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
         this.serializeAs_GameActionFightExchangePositionsMessage(output);
      }
      
      public function serializeAs_GameActionFightExchangePositionsMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeInt(this.targetId);
         if((this.casterCellId < -1) || (this.casterCellId > 559))
         {
            throw new Error("Forbidden value (" + this.casterCellId + ") on element casterCellId.");
         }
         else
         {
            output.writeShort(this.casterCellId);
            if((this.targetCellId < -1) || (this.targetCellId > 559))
            {
               throw new Error("Forbidden value (" + this.targetCellId + ") on element targetCellId.");
            }
            else
            {
               output.writeShort(this.targetCellId);
               return;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightExchangePositionsMessage(input);
      }
      
      public function deserializeAs_GameActionFightExchangePositionsMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.targetId = input.readInt();
         this.casterCellId = input.readShort();
         if((this.casterCellId < -1) || (this.casterCellId > 559))
         {
            throw new Error("Forbidden value (" + this.casterCellId + ") on element of GameActionFightExchangePositionsMessage.casterCellId.");
         }
         else
         {
            this.targetCellId = input.readShort();
            if((this.targetCellId < -1) || (this.targetCellId > 559))
            {
               throw new Error("Forbidden value (" + this.targetCellId + ") on element of GameActionFightExchangePositionsMessage.targetCellId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
