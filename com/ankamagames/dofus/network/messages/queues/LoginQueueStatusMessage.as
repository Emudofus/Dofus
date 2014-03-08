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
      
      public function initLoginQueueStatusMessage(param1:uint=0, param2:uint=0) : LoginQueueStatusMessage {
         this.position = param1;
         this.total = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.position = 0;
         this.total = 0;
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
         this.serializeAs_LoginQueueStatusMessage(param1);
      }
      
      public function serializeAs_LoginQueueStatusMessage(param1:IDataOutput) : void {
         if(this.position < 0 || this.position > 65535)
         {
            throw new Error("Forbidden value (" + this.position + ") on element position.");
         }
         else
         {
            param1.writeShort(this.position);
            if(this.total < 0 || this.total > 65535)
            {
               throw new Error("Forbidden value (" + this.total + ") on element total.");
            }
            else
            {
               param1.writeShort(this.total);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_LoginQueueStatusMessage(param1);
      }
      
      public function deserializeAs_LoginQueueStatusMessage(param1:IDataInput) : void {
         this.position = param1.readUnsignedShort();
         if(this.position < 0 || this.position > 65535)
         {
            throw new Error("Forbidden value (" + this.position + ") on element of LoginQueueStatusMessage.position.");
         }
         else
         {
            this.total = param1.readUnsignedShort();
            if(this.total < 0 || this.total > 65535)
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
