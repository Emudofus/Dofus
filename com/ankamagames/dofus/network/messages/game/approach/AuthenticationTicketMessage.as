package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AuthenticationTicketMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AuthenticationTicketMessage() {
         super();
      }
      
      public static const protocolId:uint = 110;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var lang:String = "";
      
      public var ticket:String = "";
      
      override public function getMessageId() : uint {
         return 110;
      }
      
      public function initAuthenticationTicketMessage(lang:String = "", ticket:String = "") : AuthenticationTicketMessage {
         this.lang = lang;
         this.ticket = ticket;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.lang = "";
         this.ticket = "";
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
         this.serializeAs_AuthenticationTicketMessage(output);
      }
      
      public function serializeAs_AuthenticationTicketMessage(output:IDataOutput) : void {
         output.writeUTF(this.lang);
         output.writeUTF(this.ticket);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AuthenticationTicketMessage(input);
      }
      
      public function deserializeAs_AuthenticationTicketMessage(input:IDataInput) : void {
         this.lang = input.readUTF();
         this.ticket = input.readUTF();
      }
   }
}
