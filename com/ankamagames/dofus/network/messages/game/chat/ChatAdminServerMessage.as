package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChatAdminServerMessage extends ChatServerMessage implements INetworkMessage
   {
      
      public function ChatAdminServerMessage() {
         super();
      }
      
      public static const protocolId:uint = 6135;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 6135;
      }
      
      public function initChatAdminServerMessage(channel:uint=0, content:String="", timestamp:uint=0, fingerprint:String="", senderId:int=0, senderName:String="", senderAccountId:int=0) : ChatAdminServerMessage {
         super.initChatServerMessage(channel,content,timestamp,fingerprint,senderId,senderName,senderAccountId);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ChatAdminServerMessage(output);
      }
      
      public function serializeAs_ChatAdminServerMessage(output:IDataOutput) : void {
         super.serializeAs_ChatServerMessage(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ChatAdminServerMessage(input);
      }
      
      public function deserializeAs_ChatAdminServerMessage(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
