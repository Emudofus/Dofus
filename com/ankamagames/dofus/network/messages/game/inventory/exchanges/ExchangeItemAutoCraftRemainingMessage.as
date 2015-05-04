package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeItemAutoCraftRemainingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeItemAutoCraftRemainingMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6015;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var count:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6015;
      }
      
      public function initExchangeItemAutoCraftRemainingMessage(param1:uint = 0) : ExchangeItemAutoCraftRemainingMessage
      {
         this.count = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.count = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeItemAutoCraftRemainingMessage(param1);
      }
      
      public function serializeAs_ExchangeItemAutoCraftRemainingMessage(param1:ICustomDataOutput) : void
      {
         if(this.count < 0)
         {
            throw new Error("Forbidden value (" + this.count + ") on element count.");
         }
         else
         {
            param1.writeVarInt(this.count);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeItemAutoCraftRemainingMessage(param1);
      }
      
      public function deserializeAs_ExchangeItemAutoCraftRemainingMessage(param1:ICustomDataInput) : void
      {
         this.count = param1.readVarUhInt();
         if(this.count < 0)
         {
            throw new Error("Forbidden value (" + this.count + ") on element of ExchangeItemAutoCraftRemainingMessage.count.");
         }
         else
         {
            return;
         }
      }
   }
}
