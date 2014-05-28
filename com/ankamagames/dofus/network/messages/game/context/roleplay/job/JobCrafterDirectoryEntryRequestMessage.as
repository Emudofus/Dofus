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
      
      public function initJobCrafterDirectoryEntryRequestMessage(playerId:uint = 0) : JobCrafterDirectoryEntryRequestMessage {
         this.playerId = playerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.playerId = 0;
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
         this.serializeAs_JobCrafterDirectoryEntryRequestMessage(output);
      }
      
      public function serializeAs_JobCrafterDirectoryEntryRequestMessage(output:IDataOutput) : void {
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            output.writeInt(this.playerId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_JobCrafterDirectoryEntryRequestMessage(input);
      }
      
      public function deserializeAs_JobCrafterDirectoryEntryRequestMessage(input:IDataInput) : void {
         this.playerId = input.readInt();
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
