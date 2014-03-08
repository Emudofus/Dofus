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
      
      public function initDungeonKeyRingUpdateMessage(param1:uint=0, param2:Boolean=false) : DungeonKeyRingUpdateMessage {
         this.dungeonId = param1;
         this.available = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.dungeonId = 0;
         this.available = false;
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
         this.serializeAs_DungeonKeyRingUpdateMessage(param1);
      }
      
      public function serializeAs_DungeonKeyRingUpdateMessage(param1:IDataOutput) : void {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            param1.writeShort(this.dungeonId);
            param1.writeBoolean(this.available);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_DungeonKeyRingUpdateMessage(param1);
      }
      
      public function deserializeAs_DungeonKeyRingUpdateMessage(param1:IDataInput) : void {
         this.dungeonId = param1.readShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of DungeonKeyRingUpdateMessage.dungeonId.");
         }
         else
         {
            this.available = param1.readBoolean();
            return;
         }
      }
   }
}
