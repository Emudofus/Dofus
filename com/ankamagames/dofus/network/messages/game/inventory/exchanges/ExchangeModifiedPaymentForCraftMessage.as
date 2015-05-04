package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemNotInContainer;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeModifiedPaymentForCraftMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeModifiedPaymentForCraftMessage()
      {
         this.object = new ObjectItemNotInContainer();
         super();
      }
      
      public static const protocolId:uint = 5832;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var onlySuccess:Boolean = false;
      
      public var object:ObjectItemNotInContainer;
      
      override public function getMessageId() : uint
      {
         return 5832;
      }
      
      public function initExchangeModifiedPaymentForCraftMessage(param1:Boolean = false, param2:ObjectItemNotInContainer = null) : ExchangeModifiedPaymentForCraftMessage
      {
         this.onlySuccess = param1;
         this.object = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.onlySuccess = false;
         this.object = new ObjectItemNotInContainer();
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
         this.serializeAs_ExchangeModifiedPaymentForCraftMessage(param1);
      }
      
      public function serializeAs_ExchangeModifiedPaymentForCraftMessage(param1:ICustomDataOutput) : void
      {
         param1.writeBoolean(this.onlySuccess);
         this.object.serializeAs_ObjectItemNotInContainer(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeModifiedPaymentForCraftMessage(param1);
      }
      
      public function deserializeAs_ExchangeModifiedPaymentForCraftMessage(param1:ICustomDataInput) : void
      {
         this.onlySuccess = param1.readBoolean();
         this.object = new ObjectItemNotInContainer();
         this.object.deserialize(param1);
      }
   }
}
