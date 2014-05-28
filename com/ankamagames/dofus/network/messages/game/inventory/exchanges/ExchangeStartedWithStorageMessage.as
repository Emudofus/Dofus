package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartedWithStorageMessage extends ExchangeStartedMessage implements INetworkMessage
   {
      
      public function ExchangeStartedWithStorageMessage() {
         super();
      }
      
      public static const protocolId:uint = 6236;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var storageMaxSlot:uint = 0;
      
      override public function getMessageId() : uint {
         return 6236;
      }
      
      public function initExchangeStartedWithStorageMessage(exchangeType:int = 0, storageMaxSlot:uint = 0) : ExchangeStartedWithStorageMessage {
         super.initExchangeStartedMessage(exchangeType);
         this.storageMaxSlot = storageMaxSlot;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.storageMaxSlot = 0;
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ExchangeStartedWithStorageMessage(output);
      }
      
      public function serializeAs_ExchangeStartedWithStorageMessage(output:IDataOutput) : void {
         super.serializeAs_ExchangeStartedMessage(output);
         if(this.storageMaxSlot < 0)
         {
            throw new Error("Forbidden value (" + this.storageMaxSlot + ") on element storageMaxSlot.");
         }
         else
         {
            output.writeInt(this.storageMaxSlot);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeStartedWithStorageMessage(input);
      }
      
      public function deserializeAs_ExchangeStartedWithStorageMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.storageMaxSlot = input.readInt();
         if(this.storageMaxSlot < 0)
         {
            throw new Error("Forbidden value (" + this.storageMaxSlot + ") on element of ExchangeStartedWithStorageMessage.storageMaxSlot.");
         }
         else
         {
            return;
         }
      }
   }
}
