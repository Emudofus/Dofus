package com.ankamagames.dofus.network.messages.game.context.dungeon
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DungeonEnteredMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DungeonEnteredMessage() {
         super();
      }
      
      public static const protocolId:uint = 6152;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var dungeonId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6152;
      }
      
      public function initDungeonEnteredMessage(dungeonId:uint = 0) : DungeonEnteredMessage {
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
         this.serializeAs_DungeonEnteredMessage(output);
      }
      
      public function serializeAs_DungeonEnteredMessage(output:IDataOutput) : void {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            output.writeInt(this.dungeonId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_DungeonEnteredMessage(input);
      }
      
      public function deserializeAs_DungeonEnteredMessage(input:IDataInput) : void {
         this.dungeonId = input.readInt();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of DungeonEnteredMessage.dungeonId.");
         }
         else
         {
            return;
         }
      }
   }
}
