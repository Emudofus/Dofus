package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobExperience;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class JobExperienceMultiUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobExperienceMultiUpdateMessage() {
         this.experiencesUpdate = new Vector.<JobExperience>();
         super();
      }
      
      public static const protocolId:uint = 5809;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var experiencesUpdate:Vector.<JobExperience>;
      
      override public function getMessageId() : uint {
         return 5809;
      }
      
      public function initJobExperienceMultiUpdateMessage(param1:Vector.<JobExperience>=null) : JobExperienceMultiUpdateMessage {
         this.experiencesUpdate = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.experiencesUpdate = new Vector.<JobExperience>();
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
         this.serializeAs_JobExperienceMultiUpdateMessage(param1);
      }
      
      public function serializeAs_JobExperienceMultiUpdateMessage(param1:IDataOutput) : void {
         param1.writeShort(this.experiencesUpdate.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.experiencesUpdate.length)
         {
            (this.experiencesUpdate[_loc2_] as JobExperience).serializeAs_JobExperience(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_JobExperienceMultiUpdateMessage(param1);
      }
      
      public function deserializeAs_JobExperienceMultiUpdateMessage(param1:IDataInput) : void {
         var _loc4_:JobExperience = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new JobExperience();
            _loc4_.deserialize(param1);
            this.experiencesUpdate.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
