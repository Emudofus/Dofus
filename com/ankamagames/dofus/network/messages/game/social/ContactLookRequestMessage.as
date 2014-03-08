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
      
      public function initContactLookRequestMessage(param1:uint=0, param2:uint=0) : ContactLookRequestMessage {
         this.requestId = param1;
         this.contactType = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.requestId = 0;
         this.contactType = 0;
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
         this.serializeAs_ContactLookRequestMessage(param1);
      }
      
      public function serializeAs_ContactLookRequestMessage(param1:IDataOutput) : void {
         if(this.requestId < 0 || this.requestId > 255)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
         }
         else
         {
            param1.writeByte(this.requestId);
            param1.writeByte(this.contactType);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ContactLookRequestMessage(param1);
      }
      
      public function deserializeAs_ContactLookRequestMessage(param1:IDataInput) : void {
         this.requestId = param1.readUnsignedByte();
         if(this.requestId < 0 || this.requestId > 255)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element of ContactLookRequestMessage.requestId.");
         }
         else
         {
            this.contactType = param1.readByte();
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
