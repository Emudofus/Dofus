package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobExperience;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class JobExperienceUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobExperienceUpdateMessage() {
         this.experiencesUpdate = new JobExperience();
         super();
      }
      
      public static const protocolId:uint = 5654;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var experiencesUpdate:JobExperience;
      
      override public function getMessageId() : uint {
         return 5654;
      }
      
      public function initJobExperienceUpdateMessage(experiencesUpdate:JobExperience = null) : JobExperienceUpdateMessage {
         this.experiencesUpdate = experiencesUpdate;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.experiencesUpdate = new JobExperience();
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
         this.serializeAs_JobExperienceUpdateMessage(output);
      }
      
      public function serializeAs_JobExperienceUpdateMessage(output:IDataOutput) : void {
         this.experiencesUpdate.serializeAs_JobExperience(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_JobExperienceUpdateMessage(input);
      }
      
      public function deserializeAs_JobExperienceUpdateMessage(input:IDataInput) : void {
         this.experiencesUpdate = new JobExperience();
         this.experiencesUpdate.deserialize(input);
      }
   }
}
