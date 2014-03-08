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
      
      public function initExchangeStartedWithStorageMessage(param1:int=0, param2:uint=0) : ExchangeStartedWithStorageMessage {
         super.initExchangeStartedMessage(param1);
         this.storageMaxSlot = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.storageMaxSlot = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ExchangeStartedWithStorageMessage(param1);
      }
      
      public function serializeAs_ExchangeStartedWithStorageMessage(param1:IDataOutput) : void {
         super.serializeAs_ExchangeStartedMessage(param1);
         if(this.storageMaxSlot < 0)
         {
            throw new Error("Forbidden value (" + this.storageMaxSlot + ") on element storageMaxSlot.");
         }
         else
         {
            param1.writeInt(this.storageMaxSlot);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeStartedWithStorageMessage(param1);
      }
      
      public function deserializeAs_ExchangeStartedWithStorageMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.storageMaxSlot = param1.readInt();
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
