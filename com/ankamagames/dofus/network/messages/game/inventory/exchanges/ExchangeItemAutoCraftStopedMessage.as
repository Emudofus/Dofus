package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeItemAutoCraftStopedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeItemAutoCraftStopedMessage() {
         super();
      }
      
      public static const protocolId:uint = 5810;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var reason:int = 0;
      
      override public function getMessageId() : uint {
         return 5810;
      }
      
      public function initExchangeItemAutoCraftStopedMessage(reason:int = 0) : ExchangeItemAutoCraftStopedMessage {
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.reason = 0;
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
         this.serializeAs_ExchangeItemAutoCraftStopedMessage(output);
      }
      
      public function serializeAs_ExchangeItemAutoCraftStopedMessage(output:IDataOutput) : void {
         output.writeByte(this.reason);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeItemAutoCraftStopedMessage(input);
      }
      
      public function deserializeAs_ExchangeItemAutoCraftStopedMessage(input:IDataInput) : void {
         this.reason = input.readByte();
      }
   }
}
