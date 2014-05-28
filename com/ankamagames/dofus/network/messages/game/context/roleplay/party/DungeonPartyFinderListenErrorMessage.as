package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DungeonPartyFinderListenErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DungeonPartyFinderListenErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 6248;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var dungeonId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6248;
      }
      
      public function initDungeonPartyFinderListenErrorMessage(dungeonId:uint = 0) : DungeonPartyFinderListenErrorMessage {
         this.dungeonId = dungeonId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.dungeonId = 0;
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
         this.serializeAs_DungeonPartyFinderListenErrorMessage(output);
      }
      
      public function serializeAs_DungeonPartyFinderListenErrorMessage(output:IDataOutput) : void {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            output.writeShort(this.dungeonId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_DungeonPartyFinderListenErrorMessage(input);
      }
      
      public function deserializeAs_DungeonPartyFinderListenErrorMessage(input:IDataInput) : void {
         this.dungeonId = input.readShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of DungeonPartyFinderListenErrorMessage.dungeonId.");
         }
         else
         {
            return;
         }
      }
   }
}
