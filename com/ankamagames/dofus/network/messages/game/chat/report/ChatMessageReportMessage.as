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
      
      public function initChatMessageReportMessage(param1:String="", param2:String="", param3:uint=0, param4:uint=0, param5:String="", param6:uint=0) : ChatMessageReportMessage {
         this.senderName = param1;
         this.content = param2;
         this.timestamp = param3;
         this.channel = param4;
         this.fingerprint = param5;
         this.reason = param6;
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
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ChatMessageReportMessage(param1);
      }
      
      public function serializeAs_ChatMessageReportMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.senderName);
         param1.writeUTF(this.content);
         if(this.timestamp < 0)
         {
            throw new Error("Forbidden value (" + this.timestamp + ") on element timestamp.");
         }
         else
         {
            param1.writeInt(this.timestamp);
            param1.writeByte(this.channel);
            param1.writeUTF(this.fingerprint);
            if(this.reason < 0)
            {
               throw new Error("Forbidden value (" + this.reason + ") on element reason.");
            }
            else
            {
               param1.writeByte(this.reason);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ChatMessageReportMessage(param1);
      }
      
      public function deserializeAs_ChatMessageReportMessage(param1:IDataInput) : void {
         this.senderName = param1.readUTF();
         this.content = param1.readUTF();
         this.timestamp = param1.readInt();
         if(this.timestamp < 0)
         {
            throw new Error("Forbidden value (" + this.timestamp + ") on element of ChatMessageReportMessage.timestamp.");
         }
         else
         {
            this.channel = param1.readByte();
            if(this.channel < 0)
            {
               throw new Error("Forbidden value (" + this.channel + ") on element of ChatMessageReportMessage.channel.");
            }
            else
            {
               this.fingerprint = param1.readUTF();
               this.reason = param1.readByte();
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
