package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeKamaModifiedMessage extends ExchangeObjectMessage implements INetworkMessage
   {
      
      public function ExchangeKamaModifiedMessage() {
         super();
      }
      
      public static const protocolId:uint = 5521;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var quantity:uint = 0;
      
      override public function getMessageId() : uint {
         return 5521;
      }
      
      public function initExchangeKamaModifiedMessage(remote:Boolean = false, quantity:uint = 0) : ExchangeKamaModifiedMessage {
         super.initExchangeObjectMessage(remote);
         this.quantity = quantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.quantity = 0;
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
         this.serializeAs_ExchangeKamaModifiedMessage(output);
      }
      
      public function serializeAs_ExchangeKamaModifiedMessage(output:IDataOutput) : void {
         super.serializeAs_ExchangeObjectMessage(output);
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
         }
         else
         {
            output.writeInt(this.quantity);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeKamaModifiedMessage(input);
      }
      
      public function deserializeAs_ExchangeKamaModifiedMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.quantity = input.readInt();
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of ExchangeKamaModifiedMessage.quantity.");
         }
         else
         {
            return;
         }
      }
   }
}
