package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class JobListedUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobListedUpdateMessage() {
         super();
      }
      
      public static const protocolId:uint = 6016;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var addedOrDeleted:Boolean = false;
      
      public var jobId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6016;
      }
      
      public function initJobListedUpdateMessage(addedOrDeleted:Boolean = false, jobId:uint = 0) : JobListedUpdateMessage {
         this.addedOrDeleted = addedOrDeleted;
         this.jobId = jobId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.addedOrDeleted = false;
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
         this.serializeAs_JobListedUpdateMessage(output);
      }
      
      public function serializeAs_JobListedUpdateMessage(output:IDataOutput) : void {
         output.writeBoolean(this.addedOrDeleted);
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
         this.deserializeAs_JobListedUpdateMessage(input);
      }
      
      public function deserializeAs_JobListedUpdateMessage(input:IDataInput) : void {
         this.addedOrDeleted = input.readBoolean();
         this.jobId = input.readByte();
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
