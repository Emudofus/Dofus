package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChatClientMultiMessage extends ChatAbstractClientMessage implements INetworkMessage
   {
      
      public function ChatClientMultiMessage() {
         super();
      }
      
      public static const protocolId:uint = 861;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var channel:uint = 0;
      
      override public function getMessageId() : uint {
         return 861;
      }
      
      public function initChatClientMultiMessage(content:String="", channel:uint=0) : ChatClientMultiMessage {
         super.initChatAbstractClientMessage(content);
         this.channel = channel;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.channel = 0;
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
         this.serializeAs_ChatClientMultiMessage(output);
      }
      
      public function serializeAs_ChatClientMultiMessage(output:IDataOutput) : void {
         super.serializeAs_ChatAbstractClientMessage(output);
         output.writeByte(this.channel);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ChatClientMultiMessage(input);
      }
      
      public function deserializeAs_ChatClientMultiMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.channel = input.readByte();
         if(this.channel < 0)
         {
            throw new Error("Forbidden value (" + this.channel + ") on element of ChatClientMultiMessage.channel.");
         }
         else
         {
            return;
         }
      }
   }
}
