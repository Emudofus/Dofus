package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeObjectModifyPricedMessage extends ExchangeObjectMovePricedMessage implements INetworkMessage
   {
      
      public function ExchangeObjectModifyPricedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6238;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 6238;
      }
      
      public function initExchangeObjectModifyPricedMessage(objectUID:uint = 0, quantity:int = 0, price:int = 0) : ExchangeObjectModifyPricedMessage {
         super.initExchangeObjectMovePricedMessage(objectUID,quantity,price);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
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
         this.serializeAs_ExchangeObjectModifyPricedMessage(output);
      }
      
      public function serializeAs_ExchangeObjectModifyPricedMessage(output:IDataOutput) : void {
         super.serializeAs_ExchangeObjectMovePricedMessage(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeObjectModifyPricedMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectModifyPricedMessage(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
