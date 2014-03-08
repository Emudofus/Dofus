package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.SellerBuyerDescriptor;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartedBidBuyerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeStartedBidBuyerMessage() {
         this.buyerDescriptor = new SellerBuyerDescriptor();
         super();
      }
      
      public static const protocolId:uint = 5904;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var buyerDescriptor:SellerBuyerDescriptor;
      
      override public function getMessageId() : uint {
         return 5904;
      }
      
      public function initExchangeStartedBidBuyerMessage(buyerDescriptor:SellerBuyerDescriptor=null) : ExchangeStartedBidBuyerMessage {
         this.buyerDescriptor = buyerDescriptor;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.buyerDescriptor = new SellerBuyerDescriptor();
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
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ExchangeStartedBidBuyerMessage(output);
      }
      
      public function serializeAs_ExchangeStartedBidBuyerMessage(output:IDataOutput) : void {
         this.buyerDescriptor.serializeAs_SellerBuyerDescriptor(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeStartedBidBuyerMessage(input);
      }
      
      public function deserializeAs_ExchangeStartedBidBuyerMessage(input:IDataInput) : void {
         this.buyerDescriptor = new SellerBuyerDescriptor();
         this.buyerDescriptor.deserialize(input);
      }
   }
}
