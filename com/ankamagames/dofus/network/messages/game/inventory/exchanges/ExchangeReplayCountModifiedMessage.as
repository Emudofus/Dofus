package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeReplayCountModifiedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeReplayCountModifiedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6023;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var count:int = 0;
      
      override public function getMessageId() : uint {
         return 6023;
      }
      
      public function initExchangeReplayCountModifiedMessage(count:int = 0) : ExchangeReplayCountModifiedMessage {
         this.count = count;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.count = 0;
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
         this.serializeAs_ExchangeReplayCountModifiedMessage(output);
      }
      
      public function serializeAs_ExchangeReplayCountModifiedMessage(output:IDataOutput) : void {
         output.writeInt(this.count);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeReplayCountModifiedMessage(input);
      }
      
      public function deserializeAs_ExchangeReplayCountModifiedMessage(input:IDataInput) : void {
         this.count = input.readInt();
      }
   }
}
