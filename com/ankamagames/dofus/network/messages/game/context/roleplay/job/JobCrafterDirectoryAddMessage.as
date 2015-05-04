package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryListEntry;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class JobCrafterDirectoryAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobCrafterDirectoryAddMessage()
      {
         this.listEntry = new JobCrafterDirectoryListEntry();
         super();
      }
      
      public static const protocolId:uint = 5651;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var listEntry:JobCrafterDirectoryListEntry;
      
      override public function getMessageId() : uint
      {
         return 5651;
      }
      
      public function initJobCrafterDirectoryAddMessage(param1:JobCrafterDirectoryListEntry = null) : JobCrafterDirectoryAddMessage
      {
         this.listEntry = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.listEntry = new JobCrafterDirectoryListEntry();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_JobCrafterDirectoryAddMessage(param1);
      }
      
      public function serializeAs_JobCrafterDirectoryAddMessage(param1:ICustomDataOutput) : void
      {
         this.listEntry.serializeAs_JobCrafterDirectoryListEntry(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_JobCrafterDirectoryAddMessage(param1);
      }
      
      public function deserializeAs_JobCrafterDirectoryAddMessage(param1:ICustomDataInput) : void
      {
         this.listEntry = new JobCrafterDirectoryListEntry();
         this.listEntry.deserialize(param1);
      }
   }
}
