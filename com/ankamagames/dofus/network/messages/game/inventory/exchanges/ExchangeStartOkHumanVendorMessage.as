package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInHumanVendorShop;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartOkHumanVendorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeStartOkHumanVendorMessage() {
         this.objectsInfos = new Vector.<ObjectItemToSellInHumanVendorShop>();
         super();
      }
      
      public static const protocolId:uint = 5767;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var sellerId:uint = 0;
      
      public var objectsInfos:Vector.<ObjectItemToSellInHumanVendorShop>;
      
      override public function getMessageId() : uint {
         return 5767;
      }
      
      public function initExchangeStartOkHumanVendorMessage(param1:uint=0, param2:Vector.<ObjectItemToSellInHumanVendorShop>=null) : ExchangeStartOkHumanVendorMessage {
         this.sellerId = param1;
         this.objectsInfos = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.sellerId = 0;
         this.objectsInfos = new Vector.<ObjectItemToSellInHumanVendorShop>();
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
         this.serializeAs_ExchangeStartOkHumanVendorMessage(param1);
      }
      
      public function serializeAs_ExchangeStartOkHumanVendorMessage(param1:IDataOutput) : void {
         if(this.sellerId < 0)
         {
            throw new Error("Forbidden value (" + this.sellerId + ") on element sellerId.");
         }
         else
         {
            param1.writeInt(this.sellerId);
            param1.writeShort(this.objectsInfos.length);
            _loc2_ = 0;
            while(_loc2_ < this.objectsInfos.length)
            {
               (this.objectsInfos[_loc2_] as ObjectItemToSellInHumanVendorShop).serializeAs_ObjectItemToSellInHumanVendorShop(param1);
               _loc2_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeStartOkHumanVendorMessage(param1);
      }
      
      public function deserializeAs_ExchangeStartOkHumanVendorMessage(param1:IDataInput) : void {
         var _loc4_:ObjectItemToSellInHumanVendorShop = null;
         this.sellerId = param1.readInt();
         if(this.sellerId < 0)
         {
            throw new Error("Forbidden value (" + this.sellerId + ") on element of ExchangeStartOkHumanVendorMessage.sellerId.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = new ObjectItemToSellInHumanVendorShop();
               _loc4_.deserialize(param1);
               this.objectsInfos.push(_loc4_);
               _loc3_++;
            }
            return;
         }
      }
   }
}
