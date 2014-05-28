package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryEntryPlayerInfo;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryEntryJobInfo;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class JobCrafterDirectoryEntryMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobCrafterDirectoryEntryMessage() {
         this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
         this.jobInfoList = new Vector.<JobCrafterDirectoryEntryJobInfo>();
         this.playerLook = new EntityLook();
         super();
      }
      
      public static const protocolId:uint = 6044;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var playerInfo:JobCrafterDirectoryEntryPlayerInfo;
      
      public var jobInfoList:Vector.<JobCrafterDirectoryEntryJobInfo>;
      
      public var playerLook:EntityLook;
      
      override public function getMessageId() : uint {
         return 6044;
      }
      
      public function initJobCrafterDirectoryEntryMessage(playerInfo:JobCrafterDirectoryEntryPlayerInfo = null, jobInfoList:Vector.<JobCrafterDirectoryEntryJobInfo> = null, playerLook:EntityLook = null) : JobCrafterDirectoryEntryMessage {
         this.playerInfo = playerInfo;
         this.jobInfoList = jobInfoList;
         this.playerLook = playerLook;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
         this.playerLook = new EntityLook();
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
         this.serializeAs_JobCrafterDirectoryEntryMessage(output);
      }
      
      public function serializeAs_JobCrafterDirectoryEntryMessage(output:IDataOutput) : void {
         this.playerInfo.serializeAs_JobCrafterDirectoryEntryPlayerInfo(output);
         output.writeShort(this.jobInfoList.length);
         var _i2:uint = 0;
         while(_i2 < this.jobInfoList.length)
         {
            (this.jobInfoList[_i2] as JobCrafterDirectoryEntryJobInfo).serializeAs_JobCrafterDirectoryEntryJobInfo(output);
            _i2++;
         }
         this.playerLook.serializeAs_EntityLook(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_JobCrafterDirectoryEntryMessage(input);
      }
      
      public function deserializeAs_JobCrafterDirectoryEntryMessage(input:IDataInput) : void {
         var _item2:JobCrafterDirectoryEntryJobInfo = null;
         this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
         this.playerInfo.deserialize(input);
         var _jobInfoListLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _jobInfoListLen)
         {
            _item2 = new JobCrafterDirectoryEntryJobInfo();
            _item2.deserialize(input);
            this.jobInfoList.push(_item2);
            _i2++;
         }
         this.playerLook = new EntityLook();
         this.playerLook.deserialize(input);
      }
   }
}
