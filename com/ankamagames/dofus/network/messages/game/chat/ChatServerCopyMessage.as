package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChatServerCopyMessage extends ChatAbstractServerMessage implements INetworkMessage
   {
      
      public function ChatServerCopyMessage() {
         super();
      }
      
      public static const protocolId:uint = 882;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var receiverId:uint = 0;
      
      public var receiverName:String = "";
      
      override public function getMessageId() : uint {
         return 882;
      }
      
      public function initChatServerCopyMessage(param1:uint=0, param2:String="", param3:uint=0, param4:String="", param5:uint=0, param6:String="") : ChatServerCopyMessage {
         super.initChatAbstractServerMessage(param1,param2,param3,param4);
         this.receiverId = param5;
         this.receiverName = param6;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.receiverId = 0;
         this.receiverName = "";
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
         this.serializeAs_ChatServerCopyMessage(param1);
      }
      
      public function serializeAs_ChatServerCopyMessage(param1:IDataOutput) : void {
         super.serializeAs_ChatAbstractServerMessage(param1);
         if(this.receiverId < 0)
         {
            throw new Error("Forbidden value (" + this.receiverId + ") on element receiverId.");
         }
         else
         {
            param1.writeInt(this.receiverId);
            param1.writeUTF(this.receiverName);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ChatServerCopyMessage(param1);
      }
      
      public function deserializeAs_ChatServerCopyMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.receiverId = param1.readInt();
         if(this.receiverId < 0)
         {
            throw new Error("Forbidden value (" + this.receiverId + ") on element of ChatServerCopyMessage.receiverId.");
         }
         else
         {
            this.receiverName = param1.readUTF();
            return;
         }
      }
   }
}
