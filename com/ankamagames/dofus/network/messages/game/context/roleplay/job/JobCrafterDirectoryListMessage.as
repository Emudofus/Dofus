package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryListEntry;
   import __AS3__.vec.*;
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
      
      public function initJobCrafterDirectoryListMessage(listEntries:Vector.<JobCrafterDirectoryListEntry>=null) : JobCrafterDirectoryListMessage {
         this.listEntries = listEntries;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.listEntries = new Vector.<JobCrafterDirectoryListEntry>();
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
         this.serializeAs_JobCrafterDirectoryListMessage(output);
      }
      
      public function serializeAs_JobCrafterDirectoryListMessage(output:IDataOutput) : void {
         output.writeShort(this.listEntries.length);
         var _i1:uint = 0;
         while(_i1 < this.listEntries.length)
         {
            (this.listEntries[_i1] as JobCrafterDirectoryListEntry).serializeAs_JobCrafterDirectoryListEntry(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_JobCrafterDirectoryListMessage(input);
      }
      
      public function deserializeAs_JobCrafterDirectoryListMessage(input:IDataInput) : void {
         var _item1:JobCrafterDirectoryListEntry = null;
         var _listEntriesLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _listEntriesLen)
         {
            _item1 = new JobCrafterDirectoryListEntry();
            _item1.deserialize(input);
            this.listEntries.push(_item1);
            _i1++;
         }
      }
   }
}
