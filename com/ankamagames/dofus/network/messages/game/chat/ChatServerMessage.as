package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChatServerMessage extends ChatAbstractServerMessage implements INetworkMessage
   {
      
      public function ChatServerMessage() {
         super();
      }
      
      public static const protocolId:uint = 881;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var senderId:int = 0;
      
      public var senderName:String = "";
      
      public var senderAccountId:int = 0;
      
      override public function getMessageId() : uint {
         return 881;
      }
      
      public function initChatServerMessage(param1:uint=0, param2:String="", param3:uint=0, param4:String="", param5:int=0, param6:String="", param7:int=0) : ChatServerMessage {
         super.initChatAbstractServerMessage(param1,param2,param3,param4);
         this.senderId = param5;
         this.senderName = param6;
         this.senderAccountId = param7;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.senderId = 0;
         this.senderName = "";
         this.senderAccountId = 0;
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ChatServerMessage(param1);
      }
      
      public function serializeAs_ChatServerMessage(param1:IDataOutput) : void {
         super.serializeAs_ChatAbstractServerMessage(param1);
         param1.writeInt(this.senderId);
         param1.writeUTF(this.senderName);
         param1.writeInt(this.senderAccountId);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ChatServerMessage(param1);
      }
      
      public function deserializeAs_ChatServerMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.senderId = param1.readInt();
         this.senderName = param1.readUTF();
         this.senderAccountId = param1.readInt();
      }
   }
}
