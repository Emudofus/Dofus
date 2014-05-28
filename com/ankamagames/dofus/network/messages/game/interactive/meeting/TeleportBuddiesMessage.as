package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TeleportBuddiesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TeleportBuddiesMessage() {
         super();
      }
      
      public static const protocolId:uint = 6289;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var dungeonId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6289;
      }
      
      public function initTeleportBuddiesMessage(dungeonId:uint = 0) : TeleportBuddiesMessage {
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
         this.serializeAs_TeleportBuddiesMessage(output);
      }
      
      public function serializeAs_TeleportBuddiesMessage(output:IDataOutput) : void {
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
         this.deserializeAs_TeleportBuddiesMessage(input);
      }
      
      public function deserializeAs_TeleportBuddiesMessage(input:IDataInput) : void {
         this.dungeonId = input.readShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of TeleportBuddiesMessage.dungeonId.");
         }
         else
         {
            return;
         }
      }
   }
}
