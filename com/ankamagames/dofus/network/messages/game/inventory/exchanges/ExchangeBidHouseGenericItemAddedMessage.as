package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeBidHouseGenericItemAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseGenericItemAddedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5947;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var objGenericId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5947;
      }
      
      public function initExchangeBidHouseGenericItemAddedMessage(param1:uint = 0) : ExchangeBidHouseGenericItemAddedMessage
      {
         this.objGenericId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objGenericId = 0;
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
         this.serializeAs_ExchangeBidHouseGenericItemAddedMessage(param1);
      }
      
      public function serializeAs_ExchangeBidHouseGenericItemAddedMessage(param1:ICustomDataOutput) : void
      {
         if(this.objGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.objGenericId + ") on element objGenericId.");
         }
         else
         {
            param1.writeVarShort(this.objGenericId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidHouseGenericItemAddedMessage(param1);
      }
      
      public function deserializeAs_ExchangeBidHouseGenericItemAddedMessage(param1:ICustomDataInput) : void
      {
         this.objGenericId = param1.readVarUhShort();
         if(this.objGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.objGenericId + ") on element of ExchangeBidHouseGenericItemAddedMessage.objGenericId.");
         }
         else
         {
            return;
         }
      }
   }
}
