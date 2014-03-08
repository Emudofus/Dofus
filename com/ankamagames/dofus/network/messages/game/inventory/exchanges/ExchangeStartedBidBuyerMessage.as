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
      
      public function initExchangeStartedBidBuyerMessage(param1:SellerBuyerDescriptor=null) : ExchangeStartedBidBuyerMessage {
         this.buyerDescriptor = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.buyerDescriptor = new SellerBuyerDescriptor();
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
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ExchangeStartedBidBuyerMessage(param1);
      }
      
      public function serializeAs_ExchangeStartedBidBuyerMessage(param1:IDataOutput) : void {
         this.buyerDescriptor.serializeAs_SellerBuyerDescriptor(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeStartedBidBuyerMessage(param1);
      }
      
      public function deserializeAs_ExchangeStartedBidBuyerMessage(param1:IDataInput) : void {
         this.buyerDescriptor = new SellerBuyerDescriptor();
         this.buyerDescriptor.deserialize(param1);
      }
   }
}
