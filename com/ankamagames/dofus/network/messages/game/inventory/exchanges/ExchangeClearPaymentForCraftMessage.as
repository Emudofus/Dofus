package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeClearPaymentForCraftMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeClearPaymentForCraftMessage() {
         super();
      }
      
      public static const protocolId:uint = 6145;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var paymentType:int = 0;
      
      override public function getMessageId() : uint {
         return 6145;
      }
      
      public function initExchangeClearPaymentForCraftMessage(paymentType:int=0) : ExchangeClearPaymentForCraftMessage {
         this.paymentType = paymentType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.paymentType = 0;
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
         this.serializeAs_ExchangeClearPaymentForCraftMessage(output);
      }
      
      public function serializeAs_ExchangeClearPaymentForCraftMessage(output:IDataOutput) : void {
         output.writeByte(this.paymentType);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeClearPaymentForCraftMessage(input);
      }
      
      public function deserializeAs_ExchangeClearPaymentForCraftMessage(input:IDataInput) : void {
         this.paymentType = input.readByte();
      }
   }
}
