package com.ankamagames.dofus.network.messages.queues
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class QueueStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function QueueStatusMessage() {
         super();
      }
      
      public static const protocolId:uint = 6100;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var position:uint = 0;
      
      public var total:uint = 0;
      
      override public function getMessageId() : uint {
         return 6100;
      }
      
      public function initQueueStatusMessage(position:uint = 0, total:uint = 0) : QueueStatusMessage {
         this.position = position;
         this.total = total;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.position = 0;
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
         this.serializeAs_QueueStatusMessage(output);
      }
      
      public function serializeAs_QueueStatusMessage(output:IDataOutput) : void {
         if((this.position < 0) || (this.position > 65535))
         {
            throw new Error("Forbidden value (" + this.position + ") on element position.");
         }
         else
         {
            output.writeShort(this.position);
            if((this.total < 0) || (this.total > 65535))
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
         this.deserializeAs_QueueStatusMessage(input);
      }
      
      public function deserializeAs_QueueStatusMessage(input:IDataInput) : void {
         this.position = input.readUnsignedShort();
         if((this.position < 0) || (this.position > 65535))
         {
            throw new Error("Forbidden value (" + this.position + ") on element of QueueStatusMessage.position.");
         }
         else
         {
            this.total = input.readUnsignedShort();
            if((this.total < 0) || (this.total > 65535))
            {
               throw new Error("Forbidden value (" + this.total + ") on element of QueueStatusMessage.total.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
