package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class IdentificationFailedBannedMessage extends IdentificationFailedMessage implements INetworkMessage
   {
      
      public function IdentificationFailedBannedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6174;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var banEndDate:Number = 0;
      
      override public function getMessageId() : uint {
         return 6174;
      }
      
      public function initIdentificationFailedBannedMessage(reason:uint = 99, banEndDate:Number = 0) : IdentificationFailedBannedMessage {
         super.initIdentificationFailedMessage(reason);
         this.banEndDate = banEndDate;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.banEndDate = 0;
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_IdentificationFailedBannedMessage(output);
      }
      
      public function serializeAs_IdentificationFailedBannedMessage(output:IDataOutput) : void {
         super.serializeAs_IdentificationFailedMessage(output);
         if(this.banEndDate < 0)
         {
            throw new Error("Forbidden value (" + this.banEndDate + ") on element banEndDate.");
         }
         else
         {
            output.writeDouble(this.banEndDate);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_IdentificationFailedBannedMessage(input);
      }
      
      public function deserializeAs_IdentificationFailedBannedMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.banEndDate = input.readDouble();
         if(this.banEndDate < 0)
         {
            throw new Error("Forbidden value (" + this.banEndDate + ") on element of IdentificationFailedBannedMessage.banEndDate.");
         }
         else
         {
            return;
         }
      }
   }
}
