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
      
      public function initChatSmileyRequestMessage(param1:uint=0) : ChatSmileyRequestMessage {
         this.smileyId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.smileyId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ChatSmileyRequestMessage(param1);
      }
      
      public function serializeAs_ChatSmileyRequestMessage(param1:IDataOutput) : void {
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element smileyId.");
         }
         else
         {
            param1.writeByte(this.smileyId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ChatSmileyRequestMessage(param1);
      }
      
      public function deserializeAs_ChatSmileyRequestMessage(param1:IDataInput) : void {
         this.smileyId = param1.readByte();
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
