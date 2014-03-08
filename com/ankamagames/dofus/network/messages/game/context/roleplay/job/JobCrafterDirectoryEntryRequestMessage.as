package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class JobCrafterDirectoryEntryRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobCrafterDirectoryEntryRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6043;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var playerId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6043;
      }
      
      public function initJobCrafterDirectoryEntryRequestMessage(param1:uint=0) : JobCrafterDirectoryEntryRequestMessage {
         this.playerId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.playerId = 0;
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
         this.serializeAs_JobCrafterDirectoryEntryRequestMessage(param1);
      }
      
      public function serializeAs_JobCrafterDirectoryEntryRequestMessage(param1:IDataOutput) : void {
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            param1.writeInt(this.playerId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_JobCrafterDirectoryEntryRequestMessage(param1);
      }
      
      public function deserializeAs_JobCrafterDirectoryEntryRequestMessage(param1:IDataInput) : void {
         this.playerId = param1.readInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of JobCrafterDirectoryEntryRequestMessage.playerId.");
         }
         else
         {
            return;
         }
      }
   }
}
