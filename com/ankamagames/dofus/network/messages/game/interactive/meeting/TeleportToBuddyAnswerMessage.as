package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TeleportToBuddyAnswerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TeleportToBuddyAnswerMessage() {
         super();
      }
      
      public static const protocolId:uint = 6293;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var dungeonId:uint = 0;
      
      public var buddyId:uint = 0;
      
      public var accept:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6293;
      }
      
      public function initTeleportToBuddyAnswerMessage(dungeonId:uint = 0, buddyId:uint = 0, accept:Boolean = false) : TeleportToBuddyAnswerMessage {
         this.dungeonId = dungeonId;
         this.buddyId = buddyId;
         this.accept = accept;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.dungeonId = 0;
         this.buddyId = 0;
         this.accept = false;
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
         this.serializeAs_TeleportToBuddyAnswerMessage(output);
      }
      
      public function serializeAs_TeleportToBuddyAnswerMessage(output:IDataOutput) : void {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            output.writeShort(this.dungeonId);
            if(this.buddyId < 0)
            {
               throw new Error("Forbidden value (" + this.buddyId + ") on element buddyId.");
            }
            else
            {
               output.writeInt(this.buddyId);
               output.writeBoolean(this.accept);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TeleportToBuddyAnswerMessage(input);
      }
      
      public function deserializeAs_TeleportToBuddyAnswerMessage(input:IDataInput) : void {
         this.dungeonId = input.readShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of TeleportToBuddyAnswerMessage.dungeonId.");
         }
         else
         {
            this.buddyId = input.readInt();
            if(this.buddyId < 0)
            {
               throw new Error("Forbidden value (" + this.buddyId + ") on element of TeleportToBuddyAnswerMessage.buddyId.");
            }
            else
            {
               this.accept = input.readBoolean();
               return;
            }
         }
      }
   }
}
