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
      
      public function initChatClientPrivateMessage(param1:String="", param2:String="") : ChatClientPrivateMessage {
         super.initChatAbstractClientMessage(param1);
         this.receiver = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.receiver = "";
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
         this.serializeAs_ChatClientPrivateMessage(param1);
      }
      
      public function serializeAs_ChatClientPrivateMessage(param1:IDataOutput) : void {
         super.serializeAs_ChatAbstractClientMessage(param1);
         param1.writeUTF(this.receiver);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ChatClientPrivateMessage(param1);
      }
      
      public function deserializeAs_ChatClientPrivateMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.receiver = param1.readUTF();
      }
   }
}
