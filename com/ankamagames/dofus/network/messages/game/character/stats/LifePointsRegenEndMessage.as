package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class LifePointsRegenEndMessage extends UpdateLifePointsMessage implements INetworkMessage
   {
      
      public function LifePointsRegenEndMessage() {
         super();
      }
      
      public static const protocolId:uint = 5686;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var lifePointsGained:uint = 0;
      
      override public function getMessageId() : uint {
         return 5686;
      }
      
      public function initLifePointsRegenEndMessage(lifePoints:uint = 0, maxLifePoints:uint = 0, lifePointsGained:uint = 0) : LifePointsRegenEndMessage {
         super.initUpdateLifePointsMessage(lifePoints,maxLifePoints);
         this.lifePointsGained = lifePointsGained;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.lifePointsGained = 0;
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
         this.serializeAs_LifePointsRegenEndMessage(output);
      }
      
      public function serializeAs_LifePointsRegenEndMessage(output:IDataOutput) : void {
         super.serializeAs_UpdateLifePointsMessage(output);
         if(this.lifePointsGained < 0)
         {
            throw new Error("Forbidden value (" + this.lifePointsGained + ") on element lifePointsGained.");
         }
         else
         {
            output.writeInt(this.lifePointsGained);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_LifePointsRegenEndMessage(input);
      }
      
      public function deserializeAs_LifePointsRegenEndMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.lifePointsGained = input.readInt();
         if(this.lifePointsGained < 0)
         {
            throw new Error("Forbidden value (" + this.lifePointsGained + ") on element of LifePointsRegenEndMessage.lifePointsGained.");
         }
         else
         {
            return;
         }
      }
   }
}
