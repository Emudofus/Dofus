package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class IdentificationFailedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function IdentificationFailedMessage() {
         super();
      }
      
      public static const protocolId:uint = 20;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var reason:uint = 99;
      
      override public function getMessageId() : uint {
         return 20;
      }
      
      public function initIdentificationFailedMessage(reason:uint = 99) : IdentificationFailedMessage {
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.reason = 99;
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
         this.serializeAs_IdentificationFailedMessage(output);
      }
      
      public function serializeAs_IdentificationFailedMessage(output:IDataOutput) : void {
         output.writeByte(this.reason);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_IdentificationFailedMessage(input);
      }
      
      public function deserializeAs_IdentificationFailedMessage(input:IDataInput) : void {
         this.reason = input.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of IdentificationFailedMessage.reason.");
         }
         else
         {
            return;
         }
      }
   }
}
