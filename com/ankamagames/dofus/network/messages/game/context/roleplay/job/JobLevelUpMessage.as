package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobDescription;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class JobLevelUpMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobLevelUpMessage() {
         this.jobsDescription = new JobDescription();
         super();
      }
      
      public static const protocolId:uint = 5656;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var newLevel:uint = 0;
      
      public var jobsDescription:JobDescription;
      
      override public function getMessageId() : uint {
         return 5656;
      }
      
      public function initJobLevelUpMessage(newLevel:uint = 0, jobsDescription:JobDescription = null) : JobLevelUpMessage {
         this.newLevel = newLevel;
         this.jobsDescription = jobsDescription;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.newLevel = 0;
         this.jobsDescription = new JobDescription();
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
         this.serializeAs_JobLevelUpMessage(output);
      }
      
      public function serializeAs_JobLevelUpMessage(output:IDataOutput) : void {
         if(this.newLevel < 0)
         {
            throw new Error("Forbidden value (" + this.newLevel + ") on element newLevel.");
         }
         else
         {
            output.writeByte(this.newLevel);
            this.jobsDescription.serializeAs_JobDescription(output);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_JobLevelUpMessage(input);
      }
      
      public function deserializeAs_JobLevelUpMessage(input:IDataInput) : void {
         this.newLevel = input.readByte();
         if(this.newLevel < 0)
         {
            throw new Error("Forbidden value (" + this.newLevel + ") on element of JobLevelUpMessage.newLevel.");
         }
         else
         {
            this.jobsDescription = new JobDescription();
            this.jobsDescription.deserialize(input);
            return;
         }
      }
   }
}
