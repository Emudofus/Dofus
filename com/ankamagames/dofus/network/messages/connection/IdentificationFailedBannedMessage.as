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
      
      public function initIdentificationFailedBannedMessage(param1:uint=99, param2:Number=0) : IdentificationFailedBannedMessage {
         super.initIdentificationFailedMessage(param1);
         this.banEndDate = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.banEndDate = 0;
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
         this.serializeAs_IdentificationFailedBannedMessage(param1);
      }
      
      public function serializeAs_IdentificationFailedBannedMessage(param1:IDataOutput) : void {
         super.serializeAs_IdentificationFailedMessage(param1);
         if(this.banEndDate < 0)
         {
            throw new Error("Forbidden value (" + this.banEndDate + ") on element banEndDate.");
         }
         else
         {
            param1.writeDouble(this.banEndDate);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_IdentificationFailedBannedMessage(param1);
      }
      
      public function deserializeAs_IdentificationFailedBannedMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.banEndDate = param1.readDouble();
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
