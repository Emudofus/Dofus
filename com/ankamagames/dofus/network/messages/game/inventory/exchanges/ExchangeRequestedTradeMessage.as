package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeRequestedTradeMessage extends ExchangeRequestedMessage implements INetworkMessage
   {
      
      public function ExchangeRequestedTradeMessage() {
         super();
      }
      
      public static const protocolId:uint = 5523;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var source:uint = 0;
      
      public var target:uint = 0;
      
      override public function getMessageId() : uint {
         return 5523;
      }
      
      public function initExchangeRequestedTradeMessage(param1:int=0, param2:uint=0, param3:uint=0) : ExchangeRequestedTradeMessage {
         super.initExchangeRequestedMessage(param1);
         this.source = param2;
         this.target = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.source = 0;
         this.target = 0;
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
         this.serializeAs_ExchangeRequestedTradeMessage(param1);
      }
      
      public function serializeAs_ExchangeRequestedTradeMessage(param1:IDataOutput) : void {
         super.serializeAs_ExchangeRequestedMessage(param1);
         if(this.source < 0)
         {
            throw new Error("Forbidden value (" + this.source + ") on element source.");
         }
         else
         {
            param1.writeInt(this.source);
            if(this.target < 0)
            {
               throw new Error("Forbidden value (" + this.target + ") on element target.");
            }
            else
            {
               param1.writeInt(this.target);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeRequestedTradeMessage(param1);
      }
      
      public function deserializeAs_ExchangeRequestedTradeMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.source = param1.readInt();
         if(this.source < 0)
         {
            throw new Error("Forbidden value (" + this.source + ") on element of ExchangeRequestedTradeMessage.source.");
         }
         else
         {
            this.target = param1.readInt();
            if(this.target < 0)
            {
               throw new Error("Forbidden value (" + this.target + ") on element of ExchangeRequestedTradeMessage.target.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
