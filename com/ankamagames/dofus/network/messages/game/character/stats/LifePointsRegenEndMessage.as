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
      
      public function initLifePointsRegenEndMessage(param1:uint=0, param2:uint=0, param3:uint=0) : LifePointsRegenEndMessage {
         super.initUpdateLifePointsMessage(param1,param2);
         this.lifePointsGained = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.lifePointsGained = 0;
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
         this.serializeAs_LifePointsRegenEndMessage(param1);
      }
      
      public function serializeAs_LifePointsRegenEndMessage(param1:IDataOutput) : void {
         super.serializeAs_UpdateLifePointsMessage(param1);
         if(this.lifePointsGained < 0)
         {
            throw new Error("Forbidden value (" + this.lifePointsGained + ") on element lifePointsGained.");
         }
         else
         {
            param1.writeInt(this.lifePointsGained);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_LifePointsRegenEndMessage(param1);
      }
      
      public function deserializeAs_LifePointsRegenEndMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.lifePointsGained = param1.readInt();
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
