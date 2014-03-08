package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeStartedMessage() {
         super();
      }
      
      public static const protocolId:uint = 5512;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var exchangeType:int = 0;
      
      override public function getMessageId() : uint {
         return 5512;
      }
      
      public function initExchangeStartedMessage(exchangeType:int=0) : ExchangeStartedMessage {
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
         this.serializeAs_ExchangeStartedMessage(output);
      }
      
      public function serializeAs_ExchangeStartedMessage(output:IDataOutput) : void {
         output.writeByte(this.exchangeType);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeStartedMessage(input);
      }
      
      public function deserializeAs_ExchangeStartedMessage(input:IDataInput) : void {
         this.exchangeType = input.readByte();
      }
   }
}
