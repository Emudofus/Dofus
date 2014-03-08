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
      
      public function initGameActionFightExchangePositionsMessage(param1:uint=0, param2:int=0, param3:int=0, param4:int=0, param5:int=0) : GameActionFightExchangePositionsMessage {
         super.initAbstractGameActionMessage(param1,param2);
         this.targetId = param3;
         this.casterCellId = param4;
         this.targetCellId = param5;
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
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameActionFightExchangePositionsMessage(param1);
      }
      
      public function serializeAs_GameActionFightExchangePositionsMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(param1);
         param1.writeInt(this.targetId);
         if(this.casterCellId < -1 || this.casterCellId > 559)
         {
            throw new Error("Forbidden value (" + this.casterCellId + ") on element casterCellId.");
         }
         else
         {
            param1.writeShort(this.casterCellId);
            if(this.targetCellId < -1 || this.targetCellId > 559)
            {
               throw new Error("Forbidden value (" + this.targetCellId + ") on element targetCellId.");
            }
            else
            {
               param1.writeShort(this.targetCellId);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameActionFightExchangePositionsMessage(param1);
      }
      
      public function deserializeAs_GameActionFightExchangePositionsMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.targetId = param1.readInt();
         this.casterCellId = param1.readShort();
         if(this.casterCellId < -1 || this.casterCellId > 559)
         {
            throw new Error("Forbidden value (" + this.casterCellId + ") on element of GameActionFightExchangePositionsMessage.casterCellId.");
         }
         else
         {
            this.targetCellId = param1.readShort();
            if(this.targetCellId < -1 || this.targetCellId > 559)
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
