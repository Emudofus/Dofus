package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectJobAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectJobAddedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6014;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var jobId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6014;
      }
      
      public function initObjectJobAddedMessage(jobId:uint = 0) : ObjectJobAddedMessage {
         this.jobId = jobId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.jobId = 0;
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
         this.serializeAs_ObjectJobAddedMessage(output);
      }
      
      public function serializeAs_ObjectJobAddedMessage(output:IDataOutput) : void {
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element jobId.");
         }
         else
         {
            output.writeByte(this.jobId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectJobAddedMessage(input);
      }
      
      public function deserializeAs_ObjectJobAddedMessage(input:IDataInput) : void {
         this.jobId = input.readByte();
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element of ObjectJobAddedMessage.jobId.");
         }
         else
         {
            return;
         }
      }
   }
}
