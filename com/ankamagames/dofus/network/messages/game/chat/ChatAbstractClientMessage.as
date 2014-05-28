package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChatAbstractClientMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ChatAbstractClientMessage() {
         super();
      }
      
      public static const protocolId:uint = 850;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var content:String = "";
      
      override public function getMessageId() : uint {
         return 850;
      }
      
      public function initChatAbstractClientMessage(content:String = "") : ChatAbstractClientMessage {
         this.content = content;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.content = "";
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
         this.serializeAs_ChatAbstractClientMessage(output);
      }
      
      public function serializeAs_ChatAbstractClientMessage(output:IDataOutput) : void {
         output.writeUTF(this.content);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ChatAbstractClientMessage(input);
      }
      
      public function deserializeAs_ChatAbstractClientMessage(input:IDataInput) : void {
         this.content = input.readUTF();
      }
   }
}
