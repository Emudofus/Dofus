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
      
      public function initChatAbstractClientMessage(param1:String="") : ChatAbstractClientMessage {
         this.content = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.content = "";
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
         this.serializeAs_ChatAbstractClientMessage(param1);
      }
      
      public function serializeAs_ChatAbstractClientMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.content);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ChatAbstractClientMessage(param1);
      }
      
      public function deserializeAs_ChatAbstractClientMessage(param1:IDataInput) : void {
         this.content = param1.readUTF();
      }
   }
}
