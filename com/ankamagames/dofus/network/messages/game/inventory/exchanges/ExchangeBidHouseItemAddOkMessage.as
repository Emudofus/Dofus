package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInBid;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeBidHouseItemAddOkMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseItemAddOkMessage()
      {
         this.itemInfo = new ObjectItemToSellInBid();
         super();
      }
      
      public static const protocolId:uint = 5945;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var itemInfo:ObjectItemToSellInBid;
      
      override public function getMessageId() : uint
      {
         return 5945;
      }
      
      public function initExchangeBidHouseItemAddOkMessage(param1:ObjectItemToSellInBid = null) : ExchangeBidHouseItemAddOkMessage
      {
         this.itemInfo = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.itemInfo = new ObjectItemToSellInBid();
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
         this.serializeAs_ExchangeBidHouseItemAddOkMessage(param1);
      }
      
      public function serializeAs_ExchangeBidHouseItemAddOkMessage(param1:ICustomDataOutput) : void
      {
         this.itemInfo.serializeAs_ObjectItemToSellInBid(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidHouseItemAddOkMessage(param1);
      }
      
      public function deserializeAs_ExchangeBidHouseItemAddOkMessage(param1:ICustomDataInput) : void
      {
         this.itemInfo = new ObjectItemToSellInBid();
         this.itemInfo.deserialize(param1);
      }
   }
}
