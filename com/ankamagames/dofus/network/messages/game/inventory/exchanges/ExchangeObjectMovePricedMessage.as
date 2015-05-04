package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeObjectMovePricedMessage extends ExchangeObjectMoveMessage implements INetworkMessage
   {
      
      public function ExchangeObjectMovePricedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5514;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var price:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5514;
      }
      
      public function initExchangeObjectMovePricedMessage(param1:uint = 0, param2:int = 0, param3:uint = 0) : ExchangeObjectMovePricedMessage
      {
         super.initExchangeObjectMoveMessage(param1,param2);
         this.price = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.price = 0;
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
         this.serializeAs_ExchangeObjectMovePricedMessage(param1);
      }
      
      public function serializeAs_ExchangeObjectMovePricedMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeObjectMoveMessage(param1);
         if(this.price < 0)
         {
            throw new Error("Forbidden value (" + this.price + ") on element price.");
         }
         else
         {
            param1.writeVarInt(this.price);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeObjectMovePricedMessage(param1);
      }
      
      public function deserializeAs_ExchangeObjectMovePricedMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.price = param1.readVarUhInt();
         if(this.price < 0)
         {
            throw new Error("Forbidden value (" + this.price + ") on element of ExchangeObjectMovePricedMessage.price.");
         }
         else
         {
            return;
         }
      }
   }
}
