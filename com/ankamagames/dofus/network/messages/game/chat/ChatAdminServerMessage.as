package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ChatAdminServerMessage extends ChatServerMessage implements INetworkMessage
   {
      
      public function ChatAdminServerMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6135;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint
      {
         return 6135;
      }
      
      public function initChatAdminServerMessage(param1:uint = 0, param2:String = "", param3:uint = 0, param4:String = "", param5:int = 0, param6:String = "", param7:uint = 0) : ChatAdminServerMessage
      {
         super.initChatServerMessage(param1,param2,param3,param4,param5,param6,param7);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ChatAdminServerMessage(param1);
      }
      
      public function serializeAs_ChatAdminServerMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_ChatServerMessage(param1);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ChatAdminServerMessage(param1);
      }
      
      public function deserializeAs_ChatAdminServerMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
      }
   }
}
