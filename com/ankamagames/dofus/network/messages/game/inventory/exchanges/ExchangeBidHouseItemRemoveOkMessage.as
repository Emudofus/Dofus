package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeBidHouseItemRemoveOkMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseItemRemoveOkMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5946;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var sellerId:int = 0;
      
      override public function getMessageId() : uint
      {
         return 5946;
      }
      
      public function initExchangeBidHouseItemRemoveOkMessage(param1:int = 0) : ExchangeBidHouseItemRemoveOkMessage
      {
         this.sellerId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.sellerId = 0;
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
         this.serializeAs_ExchangeBidHouseItemRemoveOkMessage(param1);
      }
      
      public function serializeAs_ExchangeBidHouseItemRemoveOkMessage(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.sellerId);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidHouseItemRemoveOkMessage(param1);
      }
      
      public function deserializeAs_ExchangeBidHouseItemRemoveOkMessage(param1:ICustomDataInput) : void
      {
         this.sellerId = param1.readInt();
      }
   }
}
