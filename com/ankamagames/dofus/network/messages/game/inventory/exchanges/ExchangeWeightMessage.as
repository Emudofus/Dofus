package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeWeightMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeWeightMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5793;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var currentWeight:uint = 0;
      
      public var maxWeight:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5793;
      }
      
      public function initExchangeWeightMessage(param1:uint = 0, param2:uint = 0) : ExchangeWeightMessage
      {
         this.currentWeight = param1;
         this.maxWeight = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.currentWeight = 0;
         this.maxWeight = 0;
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
         this.serializeAs_ExchangeWeightMessage(param1);
      }
      
      public function serializeAs_ExchangeWeightMessage(param1:ICustomDataOutput) : void
      {
         if(this.currentWeight < 0)
         {
            throw new Error("Forbidden value (" + this.currentWeight + ") on element currentWeight.");
         }
         else
         {
            param1.writeVarInt(this.currentWeight);
            if(this.maxWeight < 0)
            {
               throw new Error("Forbidden value (" + this.maxWeight + ") on element maxWeight.");
            }
            else
            {
               param1.writeVarInt(this.maxWeight);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeWeightMessage(param1);
      }
      
      public function deserializeAs_ExchangeWeightMessage(param1:ICustomDataInput) : void
      {
         this.currentWeight = param1.readVarUhInt();
         if(this.currentWeight < 0)
         {
            throw new Error("Forbidden value (" + this.currentWeight + ") on element of ExchangeWeightMessage.currentWeight.");
         }
         else
         {
            this.maxWeight = param1.readVarUhInt();
            if(this.maxWeight < 0)
            {
               throw new Error("Forbidden value (" + this.maxWeight + ") on element of ExchangeWeightMessage.maxWeight.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
