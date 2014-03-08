package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobDescription;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class JobDescriptionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobDescriptionMessage() {
         this.jobsDescription = new Vector.<JobDescription>();
         super();
      }
      
      public static const protocolId:uint = 5655;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var jobsDescription:Vector.<JobDescription>;
      
      override public function getMessageId() : uint {
         return 5655;
      }
      
      public function initJobDescriptionMessage(jobsDescription:Vector.<JobDescription>=null) : JobDescriptionMessage {
         this.jobsDescription = jobsDescription;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.jobsDescription = new Vector.<JobDescription>();
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
         this.serializeAs_JobDescriptionMessage(output);
      }
      
      public function serializeAs_JobDescriptionMessage(output:IDataOutput) : void {
         output.writeShort(this.jobsDescription.length);
         var _i1:uint = 0;
         while(_i1 < this.jobsDescription.length)
         {
            (this.jobsDescription[_i1] as JobDescription).serializeAs_JobDescription(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_JobDescriptionMessage(input);
      }
      
      public function deserializeAs_JobDescriptionMessage(input:IDataInput) : void {
         var _item1:JobDescription = null;
         var _jobsDescriptionLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _jobsDescriptionLen)
         {
            _item1 = new JobDescription();
            _item1.deserialize(input);
            this.jobsDescription.push(_item1);
            _i1++;
         }
      }
   }
}
