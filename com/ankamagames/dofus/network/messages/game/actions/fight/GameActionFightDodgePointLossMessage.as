package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightDodgePointLossMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightDodgePointLossMessage() {
         super();
      }
      
      public static const protocolId:uint = 5828;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var targetId:int = 0;
      
      public var amount:uint = 0;
      
      override public function getMessageId() : uint {
         return 5828;
      }
      
      public function initGameActionFightDodgePointLossMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, amount:uint=0) : GameActionFightDodgePointLossMessage {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.targetId = targetId;
         this.amount = amount;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.targetId = 0;
         this.amount = 0;
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
         this.serializeAs_GameActionFightDodgePointLossMessage(output);
      }
      
      public function serializeAs_GameActionFightDodgePointLossMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeInt(this.targetId);
         if(this.amount < 0)
         {
            throw new Error("Forbidden value (" + this.amount + ") on element amount.");
         }
         else
         {
            output.writeShort(this.amount);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightDodgePointLossMessage(input);
      }
      
      public function deserializeAs_GameActionFightDodgePointLossMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.targetId = input.readInt();
         this.amount = input.readShort();
         if(this.amount < 0)
         {
            throw new Error("Forbidden value (" + this.amount + ") on element of GameActionFightDodgePointLossMessage.amount.");
         }
         else
         {
            return;
         }
      }
   }
}
