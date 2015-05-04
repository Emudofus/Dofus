package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeBidHouseInListUpdatedMessage extends ExchangeBidHouseInListAddedMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseInListUpdatedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6337;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint
      {
         return 6337;
      }
      
      public function initExchangeBidHouseInListUpdatedMessage(param1:int = 0, param2:int = 0, param3:Vector.<ObjectEffect> = null, param4:Vector.<uint> = null) : ExchangeBidHouseInListUpdatedMessage
      {
         super.initExchangeBidHouseInListAddedMessage(param1,param2,param3,param4);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeBidHouseInListUpdatedMessage(param1);
      }
      
      public function serializeAs_ExchangeBidHouseInListUpdatedMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeBidHouseInListAddedMessage(param1);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidHouseInListUpdatedMessage(param1);
      }
      
      public function deserializeAs_ExchangeBidHouseInListUpdatedMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
      }
   }
}
