package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ObjectJobAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectJobAddedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6014;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var jobId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6014;
      }
      
      public function initObjectJobAddedMessage(param1:uint = 0) : ObjectJobAddedMessage
      {
         this.jobId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.jobId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectJobAddedMessage(param1);
      }
      
      public function serializeAs_ObjectJobAddedMessage(param1:ICustomDataOutput) : void
      {
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element jobId.");
         }
         else
         {
            param1.writeByte(this.jobId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectJobAddedMessage(param1);
      }
      
      public function deserializeAs_ObjectJobAddedMessage(param1:ICustomDataInput) : void
      {
         this.jobId = param1.readByte();
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
