package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChatClientPrivateMessage extends ChatAbstractClientMessage implements INetworkMessage
   {
      
      public function ChatClientPrivateMessage() {
         super();
      }
      
      public static const protocolId:uint = 851;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var receiver:String = "";
      
      override public function getMessageId() : uint {
         return 851;
      }
      
      public function initChatClientPrivateMessage(content:String="", receiver:String="") : ChatClientPrivateMessage {
         super.initChatAbstractClientMessage(content);
         this.receiver = receiver;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.receiver = "";
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
         this.serializeAs_ChatClientPrivateMessage(output);
      }
      
      public function serializeAs_ChatClientPrivateMessage(output:IDataOutput) : void {
         super.serializeAs_ChatAbstractClientMessage(output);
         output.writeUTF(this.receiver);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ChatClientPrivateMessage(input);
      }
      
      public function deserializeAs_ChatClientPrivateMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.receiver = input.readUTF();
      }
   }
}
