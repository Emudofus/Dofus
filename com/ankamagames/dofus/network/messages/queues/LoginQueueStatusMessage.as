package com.ankamagames.dofus.network.messages.queues
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class LoginQueueStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function LoginQueueStatusMessage() {
         super();
      }
      
      public static const protocolId:uint = 10;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var position:uint = 0;
      
      public var total:uint = 0;
      
      override public function getMessageId() : uint {
         return 10;
      }
      
      public function initLoginQueueStatusMessage(position:uint = 0, total:uint = 0) : LoginQueueStatusMessage {
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
         this.serializeAs_LoginQueueStatusMessage(output);
      }
      
      public function serializeAs_LoginQueueStatusMessage(output:IDataOutput) : void {
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
         this.deserializeAs_LoginQueueStatusMessage(input);
      }
      
      public function deserializeAs_LoginQueueStatusMessage(input:IDataInput) : void {
         this.position = input.readUnsignedShort();
         if((this.position < 0) || (this.position > 65535))
         {
            throw new Error("Forbidden value (" + this.position + ") on element of LoginQueueStatusMessage.position.");
         }
         else
         {
            this.total = input.readUnsignedShort();
            if((this.total < 0) || (this.total > 65535))
            {
               throw new Error("Forbidden value (" + this.total + ") on element of LoginQueueStatusMessage.total.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
