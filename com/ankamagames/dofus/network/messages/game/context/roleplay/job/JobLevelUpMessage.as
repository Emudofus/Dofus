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
      
      public function initJobLevelUpMessage(param1:uint=0, param2:JobDescription=null) : JobLevelUpMessage {
         this.newLevel = param1;
         this.jobsDescription = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.newLevel = 0;
         this.jobsDescription = new JobDescription();
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
         this.serializeAs_JobLevelUpMessage(param1);
      }
      
      public function serializeAs_JobLevelUpMessage(param1:IDataOutput) : void {
         if(this.newLevel < 0)
         {
            throw new Error("Forbidden value (" + this.newLevel + ") on element newLevel.");
         }
         else
         {
            param1.writeByte(this.newLevel);
            this.jobsDescription.serializeAs_JobDescription(param1);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_JobLevelUpMessage(param1);
      }
      
      public function deserializeAs_JobLevelUpMessage(param1:IDataInput) : void {
         this.newLevel = param1.readByte();
         if(this.newLevel < 0)
         {
            throw new Error("Forbidden value (" + this.newLevel + ") on element of JobLevelUpMessage.newLevel.");
         }
         else
         {
            this.jobsDescription = new JobDescription();
            this.jobsDescription.deserialize(param1);
            return;
         }
      }
   }
}
