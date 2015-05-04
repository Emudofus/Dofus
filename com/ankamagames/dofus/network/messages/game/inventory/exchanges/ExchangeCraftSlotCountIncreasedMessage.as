package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeCraftSlotCountIncreasedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeCraftSlotCountIncreasedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6125;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var newMaxSlot:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6125;
      }
      
      public function initExchangeCraftSlotCountIncreasedMessage(param1:uint = 0) : ExchangeCraftSlotCountIncreasedMessage
      {
         this.newMaxSlot = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.newMaxSlot = 0;
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
         this.serializeAs_ExchangeCraftSlotCountIncreasedMessage(param1);
      }
      
      public function serializeAs_ExchangeCraftSlotCountIncreasedMessage(param1:ICustomDataOutput) : void
      {
         if(this.newMaxSlot < 0)
         {
            throw new Error("Forbidden value (" + this.newMaxSlot + ") on element newMaxSlot.");
         }
         else
         {
            param1.writeByte(this.newMaxSlot);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeCraftSlotCountIncreasedMessage(param1);
      }
      
      public function deserializeAs_ExchangeCraftSlotCountIncreasedMessage(param1:ICustomDataInput) : void
      {
         this.newMaxSlot = param1.readByte();
         if(this.newMaxSlot < 0)
         {
            throw new Error("Forbidden value (" + this.newMaxSlot + ") on element of ExchangeCraftSlotCountIncreasedMessage.newMaxSlot.");
         }
         else
         {
            return;
         }
      }
   }
}
