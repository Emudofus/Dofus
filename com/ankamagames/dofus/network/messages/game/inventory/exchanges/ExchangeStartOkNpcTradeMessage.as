package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartOkNpcTradeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeStartOkNpcTradeMessage() {
         super();
      }
      
      public static const protocolId:uint = 5785;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var npcId:int = 0;
      
      override public function getMessageId() : uint {
         return 5785;
      }
      
      public function initExchangeStartOkNpcTradeMessage(npcId:int = 0) : ExchangeStartOkNpcTradeMessage {
         this.npcId = npcId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.npcId = 0;
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
         this.serializeAs_ExchangeStartOkNpcTradeMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkNpcTradeMessage(output:IDataOutput) : void {
         output.writeInt(this.npcId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeStartOkNpcTradeMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkNpcTradeMessage(input:IDataInput) : void {
         this.npcId = input.readInt();
      }
   }
}
