package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5505;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var exchangeType:int = 0;
      
      override public function getMessageId() : uint {
         return 5505;
      }
      
      public function initExchangeRequestMessage(exchangeType:int = 0) : ExchangeRequestMessage {
         this.exchangeType = exchangeType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.exchangeType = 0;
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
         this.serializeAs_ExchangeRequestMessage(output);
      }
      
      public function serializeAs_ExchangeRequestMessage(output:IDataOutput) : void {
         output.writeByte(this.exchangeType);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeRequestMessage(input);
      }
      
      public function deserializeAs_ExchangeRequestMessage(input:IDataInput) : void {
         this.exchangeType = input.readByte();
      }
   }
}
