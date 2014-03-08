package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeRequestedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeRequestedMessage() {
         super();
      }
      
      public static const protocolId:uint = 5522;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var exchangeType:int = 0;
      
      override public function getMessageId() : uint {
         return 5522;
      }
      
      public function initExchangeRequestedMessage(exchangeType:int=0) : ExchangeRequestedMessage {
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
         this.serializeAs_ExchangeRequestedMessage(output);
      }
      
      public function serializeAs_ExchangeRequestedMessage(output:IDataOutput) : void {
         output.writeByte(this.exchangeType);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeRequestedMessage(input);
      }
      
      public function deserializeAs_ExchangeRequestedMessage(input:IDataInput) : void {
         this.exchangeType = input.readByte();
      }
   }
}
