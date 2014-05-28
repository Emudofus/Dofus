package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.SellerBuyerDescriptor;
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
      
      public function initExchangeStartedBidSellerMessage(sellerDescriptor:SellerBuyerDescriptor = null, objectsInfos:Vector.<ObjectItemToSellInBid> = null) : ExchangeStartedBidSellerMessage {
         this.sellerDescriptor = sellerDescriptor;
         this.objectsInfos = objectsInfos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.sellerDescriptor = new SellerBuyerDescriptor();
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
         this.serializeAs_ExchangeStartedBidSellerMessage(output);
      }
      
      public function serializeAs_ExchangeStartedBidSellerMessage(output:IDataOutput) : void {
         this.sellerDescriptor.serializeAs_SellerBuyerDescriptor(output);
         output.writeShort(this.objectsInfos.length);
         var _i2:uint = 0;
         while(_i2 < this.objectsInfos.length)
         {
            (this.objectsInfos[_i2] as ObjectItemToSellInBid).serializeAs_ObjectItemToSellInBid(output);
            _i2++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeStartedBidSellerMessage(input);
      }
      
      public function deserializeAs_ExchangeStartedBidSellerMessage(input:IDataInput) : void {
         var _item2:ObjectItemToSellInBid = null;
         this.sellerDescriptor = new SellerBuyerDescriptor();
         this.sellerDescriptor.deserialize(input);
         var _objectsInfosLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _objectsInfosLen)
         {
            _item2 = new ObjectItemToSellInBid();
            _item2.deserialize(input);
            this.objectsInfos.push(_item2);
            _i2++;
         }
      }
   }
}
