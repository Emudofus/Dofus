package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeObjectTransfertAllToInvMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeObjectTransfertAllToInvMessage() {
         super();
      }
      
      public static const protocolId:uint = 6032;
      
      override public function get isInitialized() : Boolean {
         return true;
      }
      
      override public function getMessageId() : uint {
         return 6032;
      }
      
      public function initExchangeObjectTransfertAllToInvMessage() : ExchangeObjectTransfertAllToInvMessage {
         return this;
      }
      
      override public function reset() : void {
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
      }
      
      public function serializeAs_ExchangeObjectTransfertAllToInvMessage(output:IDataOutput) : void {
      }
      
      public function deserialize(input:IDataInput) : void {
      }
      
      public function deserializeAs_ExchangeObjectTransfertAllToInvMessage(input:IDataInput) : void {
      }
   }
}
