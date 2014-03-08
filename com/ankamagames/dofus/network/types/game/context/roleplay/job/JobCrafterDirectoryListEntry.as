package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class JobCrafterDirectoryListEntry extends Object implements INetworkType
   {
      
      public function JobCrafterDirectoryListEntry() {
         this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
         this.jobInfo = new JobCrafterDirectoryEntryJobInfo();
         super();
      }
      
      public static const protocolId:uint = 196;
      
      public var playerInfo:JobCrafterDirectoryEntryPlayerInfo;
      
      public var jobInfo:JobCrafterDirectoryEntryJobInfo;
      
      public function getTypeId() : uint {
         return 196;
      }
      
      public function initJobCrafterDirectoryListEntry(param1:JobCrafterDirectoryEntryPlayerInfo=null, param2:JobCrafterDirectoryEntryJobInfo=null) : JobCrafterDirectoryListEntry {
         this.playerInfo = param1;
         this.jobInfo = param2;
         return this;
      }
      
      public function reset() : void {
         this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_JobCrafterDirectoryListEntry(param1);
      }
      
      public function serializeAs_JobCrafterDirectoryListEntry(param1:IDataOutput) : void {
         this.playerInfo.serializeAs_JobCrafterDirectoryEntryPlayerInfo(param1);
         this.jobInfo.serializeAs_JobCrafterDirectoryEntryJobInfo(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_JobCrafterDirectoryListEntry(param1);
      }
      
      public function deserializeAs_JobCrafterDirectoryListEntry(param1:IDataInput) : void {
         this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
         this.playerInfo.deserialize(param1);
         this.jobInfo = new JobCrafterDirectoryEntryJobInfo();
         this.jobInfo.deserialize(param1);
      }
   }
}
