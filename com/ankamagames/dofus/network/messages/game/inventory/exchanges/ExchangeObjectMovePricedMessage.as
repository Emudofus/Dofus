package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeObjectMovePricedMessage extends ExchangeObjectMoveMessage implements INetworkMessage
   {
      
      public function ExchangeObjectMovePricedMessage() {
         super();
      }
      
      public static const protocolId:uint = 5514;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var price:int = 0;
      
      override public function getMessageId() : uint {
         return 5514;
      }
      
      public function initExchangeObjectMovePricedMessage(objectUID:uint=0, quantity:int=0, price:int=0) : ExchangeObjectMovePricedMessage {
         super.initExchangeObjectMoveMessage(objectUID,quantity);
         this.price = price;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.price = 0;
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
         this.serializeAs_ExchangeObjectMovePricedMessage(output);
      }
      
      public function serializeAs_ExchangeObjectMovePricedMessage(output:IDataOutput) : void {
         super.serializeAs_ExchangeObjectMoveMessage(output);
         output.writeInt(this.price);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeObjectMovePricedMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectMovePricedMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.price = input.readInt();
      }
   }
}
