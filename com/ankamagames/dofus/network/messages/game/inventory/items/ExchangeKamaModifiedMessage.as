package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeKamaModifiedMessage extends ExchangeObjectMessage implements INetworkMessage
   {
      
      public function ExchangeKamaModifiedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5521;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var quantity:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5521;
      }
      
      public function initExchangeKamaModifiedMessage(param1:Boolean = false, param2:uint = 0) : ExchangeKamaModifiedMessage
      {
         super.initExchangeObjectMessage(param1);
         this.quantity = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeKamaModifiedMessage(param1);
      }
      
      public function serializeAs_ExchangeKamaModifiedMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeObjectMessage(param1);
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
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeKamaModifiedMessage(param1);
      }
      
      public function deserializeAs_ExchangeKamaModifiedMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.quantity = param1.readVarUhInt();
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of ExchangeKamaModifiedMessage.quantity.");
         }
         else
         {
            return;
         }
      }
   }
}
