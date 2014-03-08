package com.ankamagames.dofus.network.messages.web.ankabox
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MailStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MailStatusMessage() {
         super();
      }
      
      public static const protocolId:uint = 6275;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var unread:uint = 0;
      
      public var total:uint = 0;
      
      override public function getMessageId() : uint {
         return 6275;
      }
      
      public function initMailStatusMessage(unread:uint=0, total:uint=0) : MailStatusMessage {
         this.unread = unread;
         this.total = total;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.unread = 0;
         this.total = 0;
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
         this.serializeAs_MailStatusMessage(output);
      }
      
      public function serializeAs_MailStatusMessage(output:IDataOutput) : void {
         if(this.unread < 0)
         {
            throw new Error("Forbidden value (" + this.unread + ") on element unread.");
         }
         else
         {
            output.writeShort(this.unread);
            if(this.total < 0)
            {
               throw new Error("Forbidden value (" + this.total + ") on element total.");
            }
            else
            {
               output.writeShort(this.total);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MailStatusMessage(input);
      }
      
      public function deserializeAs_MailStatusMessage(input:IDataInput) : void {
         this.unread = input.readShort();
         if(this.unread < 0)
         {
            throw new Error("Forbidden value (" + this.unread + ") on element of MailStatusMessage.unread.");
         }
         else
         {
            this.total = input.readShort();
            if(this.total < 0)
            {
               throw new Error("Forbidden value (" + this.total + ") on element of MailStatusMessage.total.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
