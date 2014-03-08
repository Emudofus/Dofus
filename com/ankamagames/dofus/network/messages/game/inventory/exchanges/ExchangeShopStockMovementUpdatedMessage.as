package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSell;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeShopStockMovementUpdatedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeShopStockMovementUpdatedMessage() {
         this.objectInfo = new ObjectItemToSell();
         super();
      }
      
      public static const protocolId:uint = 5909;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var objectInfo:ObjectItemToSell;
      
      override public function getMessageId() : uint {
         return 5909;
      }
      
      public function initExchangeShopStockMovementUpdatedMessage(param1:ObjectItemToSell=null) : ExchangeShopStockMovementUpdatedMessage {
         this.objectInfo = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objectInfo = new ObjectItemToSell();
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
         this.serializeAs_ExchangeShopStockMovementUpdatedMessage(param1);
      }
      
      public function serializeAs_ExchangeShopStockMovementUpdatedMessage(param1:IDataOutput) : void {
         this.objectInfo.serializeAs_ObjectItemToSell(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeShopStockMovementUpdatedMessage(param1);
      }
      
      public function deserializeAs_ExchangeShopStockMovementUpdatedMessage(param1:IDataInput) : void {
         this.objectInfo = new ObjectItemToSell();
         this.objectInfo.deserialize(param1);
      }
   }
}
