package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class BasicWhoAmIRequestMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function BasicWhoAmIRequestMessage() {
         super();
      }

      public static const protocolId:uint = 5664;

      override public function get isInitialized() : Boolean {
         return true;
      }

      override public function getMessageId() : uint {
         return 5664;
      }

      public function initBasicWhoAmIRequestMessage() : BasicWhoAmIRequestMessage {
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

      public function serializeAs_BasicWhoAmIRequestMessage(output:IDataOutput) : void {
         
      }

      public function deserialize(input:IDataInput) : void {
         
      }

      public function deserializeAs_BasicWhoAmIRequestMessage(input:IDataInput) : void {
         
      }
   }

}