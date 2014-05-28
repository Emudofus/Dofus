package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
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
      
      public function initJobExperienceMultiUpdateMessage(experiencesUpdate:Vector.<JobExperience> = null) : JobExperienceMultiUpdateMessage {
         this.experiencesUpdate = experiencesUpdate;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.experiencesUpdate = new Vector.<JobExperience>();
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
         this.serializeAs_JobExperienceMultiUpdateMessage(output);
      }
      
      public function serializeAs_JobExperienceMultiUpdateMessage(output:IDataOutput) : void {
         output.writeShort(this.experiencesUpdate.length);
         var _i1:uint = 0;
         while(_i1 < this.experiencesUpdate.length)
         {
            (this.experiencesUpdate[_i1] as JobExperience).serializeAs_JobExperience(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_JobExperienceMultiUpdateMessage(input);
      }
      
      public function deserializeAs_JobExperienceMultiUpdateMessage(input:IDataInput) : void {
         var _item1:JobExperience = null;
         var _experiencesUpdateLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _experiencesUpdateLen)
         {
            _item1 = new JobExperience();
            _item1.deserialize(input);
            this.experiencesUpdate.push(_item1);
            _i1++;
         }
      }
   }
}
