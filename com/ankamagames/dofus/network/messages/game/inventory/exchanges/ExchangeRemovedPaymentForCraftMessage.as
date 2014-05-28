package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeRemovedPaymentForCraftMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeRemovedPaymentForCraftMessage() {
         super();
      }
      
      public static const protocolId:uint = 6031;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var onlySuccess:Boolean = false;
      
      public var objectUID:uint = 0;
      
      override public function getMessageId() : uint {
         return 6031;
      }
      
      public function initExchangeRemovedPaymentForCraftMessage(onlySuccess:Boolean = false, objectUID:uint = 0) : ExchangeRemovedPaymentForCraftMessage {
         this.onlySuccess = onlySuccess;
         this.objectUID = objectUID;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.onlySuccess = false;
         this.objectUID = 0;
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
         this.serializeAs_ExchangeRemovedPaymentForCraftMessage(output);
      }
      
      public function serializeAs_ExchangeRemovedPaymentForCraftMessage(output:IDataOutput) : void {
         output.writeBoolean(this.onlySuccess);
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         else
         {
            output.writeInt(this.objectUID);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeRemovedPaymentForCraftMessage(input);
      }
      
      public function deserializeAs_ExchangeRemovedPaymentForCraftMessage(input:IDataInput) : void {
         this.onlySuccess = input.readBoolean();
         this.objectUID = input.readInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ExchangeRemovedPaymentForCraftMessage.objectUID.");
         }
         else
         {
            return;
         }
      }
   }
}
