package com.ankamagames.dofus.network.messages.game.chat.smiley
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChatSmileyRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ChatSmileyRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 800;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var smileyId:uint = 0;
      
      override public function getMessageId() : uint {
         return 800;
      }
      
      public function initChatSmileyRequestMessage(smileyId:uint=0) : ChatSmileyRequestMessage {
         this.smileyId = smileyId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.smileyId = 0;
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
         this.serializeAs_ChatSmileyRequestMessage(output);
      }
      
      public function serializeAs_ChatSmileyRequestMessage(output:IDataOutput) : void {
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element smileyId.");
         }
         else
         {
            output.writeByte(this.smileyId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ChatSmileyRequestMessage(input);
      }
      
      public function deserializeAs_ChatSmileyRequestMessage(input:IDataInput) : void {
         this.smileyId = input.readByte();
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element of ChatSmileyRequestMessage.smileyId.");
         }
         else
         {
            return;
         }
      }
   }
}
