package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeSellMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeSellMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5778;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var objectToSellId:uint = 0;
      
      public var quantity:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5778;
      }
      
      public function initExchangeSellMessage(param1:uint = 0, param2:uint = 0) : ExchangeSellMessage
      {
         this.objectToSellId = param1;
         this.quantity = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectToSellId = 0;
         this.quantity = 0;
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
         this.serializeAs_ExchangeSellMessage(param1);
      }
      
      public function serializeAs_ExchangeSellMessage(param1:ICustomDataOutput) : void
      {
         if(this.objectToSellId < 0)
         {
            throw new Error("Forbidden value (" + this.objectToSellId + ") on element objectToSellId.");
         }
         else
         {
            param1.writeVarInt(this.objectToSellId);
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            else
            {
               param1.writeVarInt(this.quantity);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeSellMessage(param1);
      }
      
      public function deserializeAs_ExchangeSellMessage(param1:ICustomDataInput) : void
      {
         this.objectToSellId = param1.readVarUhInt();
         if(this.objectToSellId < 0)
         {
            throw new Error("Forbidden value (" + this.objectToSellId + ") on element of ExchangeSellMessage.objectToSellId.");
         }
         else
         {
            this.quantity = param1.readVarUhInt();
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element of ExchangeSellMessage.quantity.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
