package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class TeleportBuddiesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TeleportBuddiesMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6289;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var dungeonId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6289;
      }
      
      public function initTeleportBuddiesMessage(param1:uint = 0) : TeleportBuddiesMessage
      {
         this.dungeonId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.dungeonId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_TeleportBuddiesMessage(param1);
      }
      
      public function serializeAs_TeleportBuddiesMessage(param1:ICustomDataOutput) : void
      {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            param1.writeVarShort(this.dungeonId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportBuddiesMessage(param1);
      }
      
      public function deserializeAs_TeleportBuddiesMessage(param1:ICustomDataInput) : void
      {
         this.dungeonId = param1.readVarUhShort();
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
