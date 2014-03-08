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
      
      public function initChatSmileyMessage(param1:int=0, param2:uint=0, param3:uint=0) : ChatSmileyMessage {
         this.entityId = param1;
         this.smileyId = param2;
         this.accountId = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.entityId = 0;
         this.smileyId = 0;
         this.accountId = 0;
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
         this.serializeAs_ChatSmileyMessage(param1);
      }
      
      public function serializeAs_ChatSmileyMessage(param1:IDataOutput) : void {
         param1.writeInt(this.entityId);
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element smileyId.");
         }
         else
         {
            param1.writeByte(this.smileyId);
            if(this.accountId < 0)
            {
               throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
            }
            else
            {
               param1.writeInt(this.accountId);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ChatSmileyMessage(param1);
      }
      
      public function deserializeAs_ChatSmileyMessage(param1:IDataInput) : void {
         this.entityId = param1.readInt();
         this.smileyId = param1.readByte();
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element of ChatSmileyMessage.smileyId.");
         }
         else
         {
            this.accountId = param1.readInt();
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
