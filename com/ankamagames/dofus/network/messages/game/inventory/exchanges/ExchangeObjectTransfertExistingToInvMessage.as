package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class ExchangeObjectTransfertExistingToInvMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function ExchangeObjectTransfertExistingToInvMessage() {
         super();
      }

      public static const protocolId:uint = 6326;

      override public function get isInitialized() : Boolean {
         return true;
      }

      override public function getMessageId() : uint {
         return 6326;
      }

      public function initExchangeObjectTransfertExistingToInvMessage() : ExchangeObjectTransfertExistingToInvMessage {
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

      public function serializeAs_ExchangeObjectTransfertExistingToInvMessage(output:IDataOutput) : void {
         
      }

      public function deserialize(input:IDataInput) : void {
         
      }

      public function deserializeAs_ExchangeObjectTransfertExistingToInvMessage(input:IDataInput) : void {
         
      }
   }

}