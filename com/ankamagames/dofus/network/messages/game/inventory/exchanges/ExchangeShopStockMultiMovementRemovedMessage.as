package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeShopStockMultiMovementRemovedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeShopStockMultiMovementRemovedMessage()
      {
         this.objectIdList = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6037;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var objectIdList:Vector.<uint>;
      
      override public function getMessageId() : uint
      {
         return 6037;
      }
      
      public function initExchangeShopStockMultiMovementRemovedMessage(param1:Vector.<uint> = null) : ExchangeShopStockMultiMovementRemovedMessage
      {
         this.objectIdList = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectIdList = new Vector.<uint>();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeShopStockMultiMovementRemovedMessage(param1);
      }
      
      public function serializeAs_ExchangeShopStockMultiMovementRemovedMessage(param1:ICustomDataOutput) : void
      {
         param1.writeShort(this.objectIdList.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.objectIdList.length)
         {
            if(this.objectIdList[_loc2_] < 0)
            {
               throw new Error("Forbidden value (" + this.objectIdList[_loc2_] + ") on element 1 (starting at 1) of objectIdList.");
            }
            else
            {
               param1.writeVarInt(this.objectIdList[_loc2_]);
               _loc2_++;
               continue;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeShopStockMultiMovementRemovedMessage(param1);
      }
      
      public function deserializeAs_ExchangeShopStockMultiMovementRemovedMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:uint = 0;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readVarUhInt();
            if(_loc4_ < 0)
            {
               throw new Error("Forbidden value (" + _loc4_ + ") on elements of objectIdList.");
            }
            else
            {
               this.objectIdList.push(_loc4_);
               _loc3_++;
               continue;
            }
         }
      }
   }
}
