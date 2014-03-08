package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobDescription;
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
      
      public function initJobDescriptionMessage(param1:Vector.<JobDescription>=null) : JobDescriptionMessage {
         this.jobsDescription = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.jobsDescription = new Vector.<JobDescription>();
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
         this.serializeAs_JobDescriptionMessage(param1);
      }
      
      public function serializeAs_JobDescriptionMessage(param1:IDataOutput) : void {
         param1.writeShort(this.jobsDescription.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.jobsDescription.length)
         {
            (this.jobsDescription[_loc2_] as JobDescription).serializeAs_JobDescription(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_JobDescriptionMessage(param1);
      }
      
      public function deserializeAs_JobDescriptionMessage(param1:IDataInput) : void {
         var _loc4_:JobDescription = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new JobDescription();
            _loc4_.deserialize(param1);
            this.jobsDescription.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
