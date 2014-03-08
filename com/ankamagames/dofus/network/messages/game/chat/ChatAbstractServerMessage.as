package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChatAbstractServerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ChatAbstractServerMessage() {
         super();
      }
      
      public static const protocolId:uint = 880;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var channel:uint = 0;
      
      public var content:String = "";
      
      public var timestamp:uint = 0;
      
      public var fingerprint:String = "";
      
      override public function getMessageId() : uint {
         return 880;
      }
      
      public function initChatAbstractServerMessage(param1:uint=0, param2:String="", param3:uint=0, param4:String="") : ChatAbstractServerMessage {
         this.channel = param1;
         this.content = param2;
         this.timestamp = param3;
         this.fingerprint = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.channel = 0;
         this.content = "";
         this.timestamp = 0;
         this.fingerprint = "";
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
         this.serializeAs_ChatAbstractServerMessage(param1);
      }
      
      public function serializeAs_ChatAbstractServerMessage(param1:IDataOutput) : void {
         param1.writeByte(this.channel);
         param1.writeUTF(this.content);
         if(this.timestamp < 0)
         {
            throw new Error("Forbidden value (" + this.timestamp + ") on element timestamp.");
         }
         else
         {
            param1.writeInt(this.timestamp);
            param1.writeUTF(this.fingerprint);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ChatAbstractServerMessage(param1);
      }
      
      public function deserializeAs_ChatAbstractServerMessage(param1:IDataInput) : void {
         this.channel = param1.readByte();
         if(this.channel < 0)
         {
            throw new Error("Forbidden value (" + this.channel + ") on element of ChatAbstractServerMessage.channel.");
         }
         else
         {
            this.content = param1.readUTF();
            this.timestamp = param1.readInt();
            if(this.timestamp < 0)
            {
               throw new Error("Forbidden value (" + this.timestamp + ") on element of ChatAbstractServerMessage.timestamp.");
            }
            else
            {
               this.fingerprint = param1.readUTF();
               return;
            }
         }
      }
   }
}
