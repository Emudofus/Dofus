package com.ankamagames.dofus.network.messages.game.chat.smiley
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChatSmileyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ChatSmileyMessage() {
         super();
      }
      
      public static const protocolId:uint = 801;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var entityId:int = 0;
      
      public var smileyId:uint = 0;
      
      public var accountId:uint = 0;
      
      override public function getMessageId() : uint {
         return 801;
      }
      
      public function initChatSmileyMessage(entityId:int = 0, smileyId:uint = 0, accountId:uint = 0) : ChatSmileyMessage {
         this.entityId = entityId;
         this.smileyId = smileyId;
         this.accountId = accountId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.entityId = 0;
         this.smileyId = 0;
         this.accountId = 0;
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
         this.serializeAs_ChatSmileyMessage(output);
      }
      
      public function serializeAs_ChatSmileyMessage(output:IDataOutput) : void {
         output.writeInt(this.entityId);
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element smileyId.");
         }
         else
         {
            output.writeByte(this.smileyId);
            if(this.accountId < 0)
            {
               throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
            }
            else
            {
               output.writeInt(this.accountId);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ChatSmileyMessage(input);
      }
      
      public function deserializeAs_ChatSmileyMessage(input:IDataInput) : void {
         this.entityId = input.readInt();
         this.smileyId = input.readByte();
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element of ChatSmileyMessage.smileyId.");
         }
         else
         {
            this.accountId = input.readInt();
            if(this.accountId < 0)
            {
               throw new Error("Forbidden value (" + this.accountId + ") on element of ChatSmileyMessage.accountId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
