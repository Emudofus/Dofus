package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeShopStockMovementRemovedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeShopStockMovementRemovedMessage() {
         super();
      }
      
      public static const protocolId:uint = 5907;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var objectId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5907;
      }
      
      public function initExchangeShopStockMovementRemovedMessage(param1:uint=0) : ExchangeShopStockMovementRemovedMessage {
         this.objectId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objectId = 0;
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
         this.serializeAs_ExchangeShopStockMovementRemovedMessage(param1);
      }
      
      public function serializeAs_ExchangeShopStockMovementRemovedMessage(param1:IDataOutput) : void {
         if(this.objectId < 0)
         {
            throw new Error("Forbidden value (" + this.objectId + ") on element objectId.");
         }
         else
         {
            param1.writeInt(this.objectId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeShopStockMovementRemovedMessage(param1);
      }
      
      public function deserializeAs_ExchangeShopStockMovementRemovedMessage(param1:IDataInput) : void {
         this.objectId = param1.readInt();
         if(this.objectId < 0)
         {
            throw new Error("Forbidden value (" + this.objectId + ") on element of ExchangeShopStockMovementRemovedMessage.objectId.");
         }
         else
         {
            return;
         }
      }
   }
}
