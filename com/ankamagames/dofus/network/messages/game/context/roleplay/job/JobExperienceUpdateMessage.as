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
      
      public function initJobExperienceUpdateMessage(param1:JobExperience=null) : JobExperienceUpdateMessage {
         this.experiencesUpdate = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.experiencesUpdate = new JobExperience();
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
         this.serializeAs_JobExperienceUpdateMessage(param1);
      }
      
      public function serializeAs_JobExperienceUpdateMessage(param1:IDataOutput) : void {
         this.experiencesUpdate.serializeAs_JobExperience(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_JobExperienceUpdateMessage(param1);
      }
      
      public function deserializeAs_JobExperienceUpdateMessage(param1:IDataInput) : void {
         this.experiencesUpdate = new JobExperience();
         this.experiencesUpdate.deserialize(param1);
      }
   }
}
