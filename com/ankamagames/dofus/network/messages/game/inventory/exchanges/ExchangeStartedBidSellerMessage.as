package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.SellerBuyerDescriptor;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInBid;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartedBidSellerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeStartedBidSellerMessage() {
         this.sellerDescriptor = new SellerBuyerDescriptor();
         this.objectsInfos = new Vector.<ObjectItemToSellInBid>();
         super();
      }
      
      public static const protocolId:uint = 5905;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var sellerDescriptor:SellerBuyerDescriptor;
      
      public var objectsInfos:Vector.<ObjectItemToSellInBid>;
      
      override public function getMessageId() : uint {
         return 5905;
      }
      
      public function initExchangeStartedBidSellerMessage(param1:SellerBuyerDescriptor=null, param2:Vector.<ObjectItemToSellInBid>=null) : ExchangeStartedBidSellerMessage {
         this.sellerDescriptor = param1;
         this.objectsInfos = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.sellerDescriptor = new SellerBuyerDescriptor();
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
         this.serializeAs_ExchangeStartedBidSellerMessage(param1);
      }
      
      public function serializeAs_ExchangeStartedBidSellerMessage(param1:IDataOutput) : void {
         this.sellerDescriptor.serializeAs_SellerBuyerDescriptor(param1);
         param1.writeShort(this.objectsInfos.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.objectsInfos.length)
         {
            (this.objectsInfos[_loc2_] as ObjectItemToSellInBid).serializeAs_ObjectItemToSellInBid(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeStartedBidSellerMessage(param1);
      }
      
      public function deserializeAs_ExchangeStartedBidSellerMessage(param1:IDataInput) : void {
         var _loc4_:ObjectItemToSellInBid = null;
         this.sellerDescriptor = new SellerBuyerDescriptor();
         this.sellerDescriptor.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new ObjectItemToSellInBid();
            _loc4_.deserialize(param1);
            this.objectsInfos.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
