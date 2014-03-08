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
      
      public function initExchangeShopStockMovementUpdatedMessage(objectInfo:ObjectItemToSell=null) : ExchangeShopStockMovementUpdatedMessage {
         this.objectInfo = objectInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objectInfo = new ObjectItemToSell();
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
         this.serializeAs_ExchangeShopStockMovementUpdatedMessage(output);
      }
      
      public function serializeAs_ExchangeShopStockMovementUpdatedMessage(output:IDataOutput) : void {
         this.objectInfo.serializeAs_ObjectItemToSell(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeShopStockMovementUpdatedMessage(input);
      }
      
      public function deserializeAs_ExchangeShopStockMovementUpdatedMessage(input:IDataInput) : void {
         this.objectInfo = new ObjectItemToSell();
         this.objectInfo.deserialize(input);
      }
   }
}
