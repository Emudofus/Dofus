package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class JobListedUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobListedUpdateMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6016;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var addedOrDeleted:Boolean = false;
      
      public var jobId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6016;
      }
      
      public function initJobListedUpdateMessage(param1:Boolean = false, param2:uint = 0) : JobListedUpdateMessage
      {
         this.addedOrDeleted = param1;
         this.jobId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.addedOrDeleted = false;
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
         this.serializeAs_JobListedUpdateMessage(param1);
      }
      
      public function serializeAs_JobListedUpdateMessage(param1:ICustomDataOutput) : void
      {
         param1.writeBoolean(this.addedOrDeleted);
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
         this.deserializeAs_JobListedUpdateMessage(param1);
      }
      
      public function deserializeAs_JobListedUpdateMessage(param1:ICustomDataInput) : void
      {
         this.addedOrDeleted = param1.readBoolean();
         this.jobId = param1.readByte();
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element of JobListedUpdateMessage.jobId.");
         }
         else
         {
            return;
         }
      }
   }
}
