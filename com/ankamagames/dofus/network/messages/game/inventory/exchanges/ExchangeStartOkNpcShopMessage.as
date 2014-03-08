package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInNpcShop;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartOkNpcShopMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeStartOkNpcShopMessage() {
         this.objectsInfos = new Vector.<ObjectItemToSellInNpcShop>();
         super();
      }
      
      public static const protocolId:uint = 5761;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var npcSellerId:int = 0;
      
      public var tokenId:uint = 0;
      
      public var objectsInfos:Vector.<ObjectItemToSellInNpcShop>;
      
      override public function getMessageId() : uint {
         return 5761;
      }
      
      public function initExchangeStartOkNpcShopMessage(param1:int=0, param2:uint=0, param3:Vector.<ObjectItemToSellInNpcShop>=null) : ExchangeStartOkNpcShopMessage {
         this.npcSellerId = param1;
         this.tokenId = param2;
         this.objectsInfos = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.npcSellerId = 0;
         this.tokenId = 0;
         this.objectsInfos = new Vector.<ObjectItemToSellInNpcShop>();
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
         this.serializeAs_ExchangeStartOkNpcShopMessage(param1);
      }
      
      public function serializeAs_ExchangeStartOkNpcShopMessage(param1:IDataOutput) : void {
         param1.writeInt(this.npcSellerId);
         if(this.tokenId < 0)
         {
            throw new Error("Forbidden value (" + this.tokenId + ") on element tokenId.");
         }
         else
         {
            param1.writeInt(this.tokenId);
            param1.writeShort(this.objectsInfos.length);
            _loc2_ = 0;
            while(_loc2_ < this.objectsInfos.length)
            {
               (this.objectsInfos[_loc2_] as ObjectItemToSellInNpcShop).serializeAs_ObjectItemToSellInNpcShop(param1);
               _loc2_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeStartOkNpcShopMessage(param1);
      }
      
      public function deserializeAs_ExchangeStartOkNpcShopMessage(param1:IDataInput) : void {
         var _loc4_:ObjectItemToSellInNpcShop = null;
         this.npcSellerId = param1.readInt();
         this.tokenId = param1.readInt();
         if(this.tokenId < 0)
         {
            throw new Error("Forbidden value (" + this.tokenId + ") on element of ExchangeStartOkNpcShopMessage.tokenId.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = new ObjectItemToSellInNpcShop();
               _loc4_.deserialize(param1);
               this.objectsInfos.push(_loc4_);
               _loc3_++;
            }
            return;
         }
      }
   }
}
