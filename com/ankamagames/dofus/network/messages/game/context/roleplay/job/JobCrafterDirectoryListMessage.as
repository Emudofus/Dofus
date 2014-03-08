package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryListEntry;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class JobCrafterDirectoryListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobCrafterDirectoryListMessage() {
         this.listEntries = new Vector.<JobCrafterDirectoryListEntry>();
         super();
      }
      
      public static const protocolId:uint = 6046;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var listEntries:Vector.<JobCrafterDirectoryListEntry>;
      
      override public function getMessageId() : uint {
         return 6046;
      }
      
      public function initJobCrafterDirectoryListMessage(param1:Vector.<JobCrafterDirectoryListEntry>=null) : JobCrafterDirectoryListMessage {
         this.listEntries = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.listEntries = new Vector.<JobCrafterDirectoryListEntry>();
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
         this.serializeAs_JobCrafterDirectoryListMessage(param1);
      }
      
      public function serializeAs_JobCrafterDirectoryListMessage(param1:IDataOutput) : void {
         param1.writeShort(this.listEntries.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.listEntries.length)
         {
            (this.listEntries[_loc2_] as JobCrafterDirectoryListEntry).serializeAs_JobCrafterDirectoryListEntry(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_JobCrafterDirectoryListMessage(param1);
      }
      
      public function deserializeAs_JobCrafterDirectoryListMessage(param1:IDataInput) : void {
         var _loc4_:JobCrafterDirectoryListEntry = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new JobCrafterDirectoryListEntry();
            _loc4_.deserialize(param1);
            this.listEntries.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
