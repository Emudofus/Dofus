package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeWaitingResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeWaitingResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 5786;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var bwait:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5786;
      }
      
      public function initExchangeWaitingResultMessage(bwait:Boolean = false) : ExchangeWaitingResultMessage {
         this.bwait = bwait;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.bwait = false;
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
         this.serializeAs_ExchangeWaitingResultMessage(output);
      }
      
      public function serializeAs_ExchangeWaitingResultMessage(output:IDataOutput) : void {
         output.writeBoolean(this.bwait);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeWaitingResultMessage(input);
      }
      
      public function deserializeAs_ExchangeWaitingResultMessage(input:IDataInput) : void {
         this.bwait = input.readBoolean();
      }
   }
}
