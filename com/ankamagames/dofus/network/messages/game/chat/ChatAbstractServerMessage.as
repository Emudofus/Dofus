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
      
      public function initChatAbstractServerMessage(channel:uint = 0, content:String = "", timestamp:uint = 0, fingerprint:String = "") : ChatAbstractServerMessage {
         this.channel = channel;
         this.content = content;
         this.timestamp = timestamp;
         this.fingerprint = fingerprint;
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
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ChatAbstractServerMessage(output);
      }
      
      public function serializeAs_ChatAbstractServerMessage(output:IDataOutput) : void {
         output.writeByte(this.channel);
         output.writeUTF(this.content);
         if(this.timestamp < 0)
         {
            throw new Error("Forbidden value (" + this.timestamp + ") on element timestamp.");
         }
         else
         {
            output.writeInt(this.timestamp);
            output.writeUTF(this.fingerprint);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ChatAbstractServerMessage(input);
      }
      
      public function deserializeAs_ChatAbstractServerMessage(input:IDataInput) : void {
         this.channel = input.readByte();
         if(this.channel < 0)
         {
            throw new Error("Forbidden value (" + this.channel + ") on element of ChatAbstractServerMessage.channel.");
         }
         else
         {
            this.content = input.readUTF();
            this.timestamp = input.readInt();
            if(this.timestamp < 0)
            {
               throw new Error("Forbidden value (" + this.timestamp + ") on element of ChatAbstractServerMessage.timestamp.");
            }
            else
            {
               this.fingerprint = input.readUTF();
               return;
            }
         }
      }
   }
}
