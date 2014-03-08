package com.ankamagames.dofus.network.messages.game.context.dungeon
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DungeonKeyRingUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DungeonKeyRingUpdateMessage() {
         super();
      }
      
      public static const protocolId:uint = 6296;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var dungeonId:uint = 0;
      
      public var available:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6296;
      }
      
      public function initDungeonKeyRingUpdateMessage(dungeonId:uint=0, available:Boolean=false) : DungeonKeyRingUpdateMessage {
         this.dungeonId = dungeonId;
         this.available = available;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.dungeonId = 0;
         this.available = false;
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
         this.serializeAs_DungeonKeyRingUpdateMessage(output);
      }
      
      public function serializeAs_DungeonKeyRingUpdateMessage(output:IDataOutput) : void {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            output.writeShort(this.dungeonId);
            output.writeBoolean(this.available);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_DungeonKeyRingUpdateMessage(input);
      }
      
      public function deserializeAs_DungeonKeyRingUpdateMessage(input:IDataInput) : void {
         this.dungeonId = input.readShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of DungeonKeyRingUpdateMessage.dungeonId.");
         }
         else
         {
            this.available = input.readBoolean();
            return;
         }
      }
   }
}
