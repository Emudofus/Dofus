package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryListEntry;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class JobCrafterDirectoryAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobCrafterDirectoryAddMessage() {
         this.listEntry = new JobCrafterDirectoryListEntry();
         super();
      }
      
      public static const protocolId:uint = 5651;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var listEntry:JobCrafterDirectoryListEntry;
      
      override public function getMessageId() : uint {
         return 5651;
      }
      
      public function initJobCrafterDirectoryAddMessage(listEntry:JobCrafterDirectoryListEntry = null) : JobCrafterDirectoryAddMessage {
         this.listEntry = listEntry;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.listEntry = new JobCrafterDirectoryListEntry();
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
         this.serializeAs_JobCrafterDirectoryAddMessage(output);
      }
      
      public function serializeAs_JobCrafterDirectoryAddMessage(output:IDataOutput) : void {
         this.listEntry.serializeAs_JobCrafterDirectoryListEntry(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_JobCrafterDirectoryAddMessage(input);
      }
      
      public function deserializeAs_JobCrafterDirectoryAddMessage(input:IDataInput) : void {
         this.listEntry = new JobCrafterDirectoryListEntry();
         this.listEntry.deserialize(input);
      }
   }
}
