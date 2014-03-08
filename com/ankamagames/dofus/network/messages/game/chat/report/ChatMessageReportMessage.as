package com.ankamagames.dofus.network.messages.game.chat.report
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChatMessageReportMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ChatMessageReportMessage() {
         super();
      }
      
      public static const protocolId:uint = 821;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var senderName:String = "";
      
      public var content:String = "";
      
      public var timestamp:uint = 0;
      
      public var channel:uint = 0;
      
      public var fingerprint:String = "";
      
      public var reason:uint = 0;
      
      override public function getMessageId() : uint {
         return 821;
      }
      
      public function initChatMessageReportMessage(senderName:String="", content:String="", timestamp:uint=0, channel:uint=0, fingerprint:String="", reason:uint=0) : ChatMessageReportMessage {
         this.senderName = senderName;
         this.content = content;
         this.timestamp = timestamp;
         this.channel = channel;
         this.fingerprint = fingerprint;
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.senderName = "";
         this.content = "";
         this.timestamp = 0;
         this.channel = 0;
         this.fingerprint = "";
         this.reason = 0;
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
         this.serializeAs_ChatMessageReportMessage(output);
      }
      
      public function serializeAs_ChatMessageReportMessage(output:IDataOutput) : void {
         output.writeUTF(this.senderName);
         output.writeUTF(this.content);
         if(this.timestamp < 0)
         {
            throw new Error("Forbidden value (" + this.timestamp + ") on element timestamp.");
         }
         else
         {
            output.writeInt(this.timestamp);
            output.writeByte(this.channel);
            output.writeUTF(this.fingerprint);
            if(this.reason < 0)
            {
               throw new Error("Forbidden value (" + this.reason + ") on element reason.");
            }
            else
            {
               output.writeByte(this.reason);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ChatMessageReportMessage(input);
      }
      
      public function deserializeAs_ChatMessageReportMessage(input:IDataInput) : void {
         this.senderName = input.readUTF();
         this.content = input.readUTF();
         this.timestamp = input.readInt();
         if(this.timestamp < 0)
         {
            throw new Error("Forbidden value (" + this.timestamp + ") on element of ChatMessageReportMessage.timestamp.");
         }
         else
         {
            this.channel = input.readByte();
            if(this.channel < 0)
            {
               throw new Error("Forbidden value (" + this.channel + ") on element of ChatMessageReportMessage.channel.");
            }
            else
            {
               this.fingerprint = input.readUTF();
               this.reason = input.readByte();
               if(this.reason < 0)
               {
                  throw new Error("Forbidden value (" + this.reason + ") on element of ChatMessageReportMessage.reason.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
