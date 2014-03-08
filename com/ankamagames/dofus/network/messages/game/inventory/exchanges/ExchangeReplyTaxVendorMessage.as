package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeReplyTaxVendorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeReplyTaxVendorMessage() {
         super();
      }
      
      public static const protocolId:uint = 5787;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var objectValue:uint = 0;
      
      public var totalTaxValue:uint = 0;
      
      override public function getMessageId() : uint {
         return 5787;
      }
      
      public function initExchangeReplyTaxVendorMessage(objectValue:uint=0, totalTaxValue:uint=0) : ExchangeReplyTaxVendorMessage {
         this.objectValue = objectValue;
         this.totalTaxValue = totalTaxValue;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objectValue = 0;
         this.totalTaxValue = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ExchangeReplyTaxVendorMessage(output);
      }
      
      public function serializeAs_ExchangeReplyTaxVendorMessage(output:IDataOutput) : void {
         if(this.objectValue < 0)
         {
            throw new Error("Forbidden value (" + this.objectValue + ") on element objectValue.");
         }
         else
         {
            output.writeInt(this.objectValue);
            if(this.totalTaxValue < 0)
            {
               throw new Error("Forbidden value (" + this.totalTaxValue + ") on element totalTaxValue.");
            }
            else
            {
               output.writeInt(this.totalTaxValue);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeReplyTaxVendorMessage(input);
      }
      
      public function deserializeAs_ExchangeReplyTaxVendorMessage(input:IDataInput) : void {
         this.objectValue = input.readInt();
         if(this.objectValue < 0)
         {
            throw new Error("Forbidden value (" + this.objectValue + ") on element of ExchangeReplyTaxVendorMessage.objectValue.");
         }
         else
         {
            this.totalTaxValue = input.readInt();
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
