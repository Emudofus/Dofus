package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeReplyTaxVendorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeReplyTaxVendorMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5787;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var objectValue:uint = 0;
      
      public var totalTaxValue:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5787;
      }
      
      public function initExchangeReplyTaxVendorMessage(param1:uint = 0, param2:uint = 0) : ExchangeReplyTaxVendorMessage
      {
         this.objectValue = param1;
         this.totalTaxValue = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectValue = 0;
         this.totalTaxValue = 0;
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
         this.serializeAs_ExchangeReplyTaxVendorMessage(param1);
      }
      
      public function serializeAs_ExchangeReplyTaxVendorMessage(param1:ICustomDataOutput) : void
      {
         if(this.objectValue < 0)
         {
            throw new Error("Forbidden value (" + this.objectValue + ") on element objectValue.");
         }
         else
         {
            param1.writeVarInt(this.objectValue);
            if(this.totalTaxValue < 0)
            {
               throw new Error("Forbidden value (" + this.totalTaxValue + ") on element totalTaxValue.");
            }
            else
            {
               param1.writeVarInt(this.totalTaxValue);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeReplyTaxVendorMessage(param1);
      }
      
      public function deserializeAs_ExchangeReplyTaxVendorMessage(param1:ICustomDataInput) : void
      {
         this.objectValue = param1.readVarUhInt();
         if(this.objectValue < 0)
         {
            throw new Error("Forbidden value (" + this.objectValue + ") on element of ExchangeReplyTaxVendorMessage.objectValue.");
         }
         else
         {
            this.totalTaxValue = param1.readVarUhInt();
            if(this.totalTaxValue < 0)
            {
               throw new Error("Forbidden value (" + this.totalTaxValue + ") on element of ExchangeReplyTaxVendorMessage.totalTaxValue.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
