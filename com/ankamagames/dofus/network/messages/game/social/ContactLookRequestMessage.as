package com.ankamagames.dofus.network.messages.game.social
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ContactLookRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ContactLookRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5932;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var requestId:uint = 0;
      
      public var contactType:uint = 0;
      
      override public function getMessageId() : uint {
         return 5932;
      }
      
      public function initContactLookRequestMessage(requestId:uint=0, contactType:uint=0) : ContactLookRequestMessage {
         this.requestId = requestId;
         this.contactType = contactType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.requestId = 0;
         this.contactType = 0;
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
         this.serializeAs_ContactLookRequestMessage(output);
      }
      
      public function serializeAs_ContactLookRequestMessage(output:IDataOutput) : void {
         if((this.requestId < 0) || (this.requestId > 255))
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
         }
         else
         {
            output.writeByte(this.requestId);
            output.writeByte(this.contactType);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ContactLookRequestMessage(input);
      }
      
      public function deserializeAs_ContactLookRequestMessage(input:IDataInput) : void {
         this.requestId = input.readUnsignedByte();
         if((this.requestId < 0) || (this.requestId > 255))
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element of ContactLookRequestMessage.requestId.");
         }
         else
         {
            this.contactType = input.readByte();
            if(this.contactType < 0)
            {
               throw new Error("Forbidden value (" + this.contactType + ") on element of ContactLookRequestMessage.contactType.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
