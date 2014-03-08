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
      
      public function initChatClientMultiMessage(param1:String="", param2:uint=0) : ChatClientMultiMessage {
         super.initChatAbstractClientMessage(param1);
         this.channel = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.channel = 0;
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
         this.serializeAs_ChatClientMultiMessage(param1);
      }
      
      public function serializeAs_ChatClientMultiMessage(param1:IDataOutput) : void {
         super.serializeAs_ChatAbstractClientMessage(param1);
         param1.writeByte(this.channel);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ChatClientMultiMessage(param1);
      }
      
      public function deserializeAs_ChatClientMultiMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.channel = param1.readByte();
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
