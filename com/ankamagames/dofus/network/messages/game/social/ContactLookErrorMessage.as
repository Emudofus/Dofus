package com.ankamagames.dofus.network.messages.game.social
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ContactLookErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ContactLookErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 6045;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var requestId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6045;
      }
      
      public function initContactLookErrorMessage(requestId:uint = 0) : ContactLookErrorMessage {
         this.requestId = requestId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.requestId = 0;
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
         this.serializeAs_ContactLookErrorMessage(output);
      }
      
      public function serializeAs_ContactLookErrorMessage(output:IDataOutput) : void {
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
         }
         else
         {
            output.writeInt(this.requestId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ContactLookErrorMessage(input);
      }
      
      public function deserializeAs_ContactLookErrorMessage(input:IDataInput) : void {
         this.requestId = input.readInt();
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element of ContactLookErrorMessage.requestId.");
         }
         else
         {
            return;
         }
      }
   }
}
