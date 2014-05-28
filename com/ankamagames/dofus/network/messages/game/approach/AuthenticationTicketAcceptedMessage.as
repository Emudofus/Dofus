package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AuthenticationTicketAcceptedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AuthenticationTicketAcceptedMessage() {
         super();
      }
      
      public static const protocolId:uint = 111;
      
      override public function get isInitialized() : Boolean {
         return true;
      }
      
      override public function getMessageId() : uint {
         return 111;
      }
      
      public function initAuthenticationTicketAcceptedMessage() : AuthenticationTicketAcceptedMessage {
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
      
      public function serializeAs_AuthenticationTicketAcceptedMessage(output:IDataOutput) : void {
      }
      
      public function deserialize(input:IDataInput) : void {
      }
      
      public function deserializeAs_AuthenticationTicketAcceptedMessage(input:IDataInput) : void {
      }
   }
}
