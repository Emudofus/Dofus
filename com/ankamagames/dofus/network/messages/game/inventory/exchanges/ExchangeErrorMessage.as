package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 5513;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var errorType:int = 0;
      
      override public function getMessageId() : uint {
         return 5513;
      }
      
      public function initExchangeErrorMessage(errorType:int=0) : ExchangeErrorMessage {
         this.errorType = errorType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.errorType = 0;
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
         this.serializeAs_ExchangeErrorMessage(output);
      }
      
      public function serializeAs_ExchangeErrorMessage(output:IDataOutput) : void {
         output.writeByte(this.errorType);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeErrorMessage(input);
      }
      
      public function deserializeAs_ExchangeErrorMessage(input:IDataInput) : void {
         this.errorType = input.readByte();
      }
   }
}
