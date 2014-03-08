package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class JobUnlearntMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobUnlearntMessage() {
         super();
      }
      
      public static const protocolId:uint = 5657;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var jobId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5657;
      }
      
      public function initJobUnlearntMessage(jobId:uint=0) : JobUnlearntMessage {
         this.jobId = jobId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
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
         this.serializeAs_JobUnlearntMessage(output);
      }
      
      public function serializeAs_JobUnlearntMessage(output:IDataOutput) : void {
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
         this.deserializeAs_JobUnlearntMessage(input);
      }
      
      public function deserializeAs_JobUnlearntMessage(input:IDataInput) : void {
         this.jobId = input.readByte();
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element of JobUnlearntMessage.jobId.");
         }
         else
         {
            return;
         }
      }
   }
}
