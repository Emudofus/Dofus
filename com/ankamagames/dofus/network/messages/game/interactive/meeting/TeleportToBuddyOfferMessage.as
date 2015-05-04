package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class TeleportToBuddyOfferMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TeleportToBuddyOfferMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6287;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var dungeonId:uint = 0;
      
      public var buddyId:uint = 0;
      
      public var timeLeft:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6287;
      }
      
      public function initTeleportToBuddyOfferMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : TeleportToBuddyOfferMessage
      {
         this.dungeonId = param1;
         this.buddyId = param2;
         this.timeLeft = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.dungeonId = 0;
         this.buddyId = 0;
         this.timeLeft = 0;
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
         this.serializeAs_TeleportToBuddyOfferMessage(param1);
      }
      
      public function serializeAs_TeleportToBuddyOfferMessage(param1:ICustomDataOutput) : void
      {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            param1.writeVarShort(this.dungeonId);
            if(this.buddyId < 0)
            {
               throw new Error("Forbidden value (" + this.buddyId + ") on element buddyId.");
            }
            else
            {
               param1.writeVarInt(this.buddyId);
               if(this.timeLeft < 0)
               {
                  throw new Error("Forbidden value (" + this.timeLeft + ") on element timeLeft.");
               }
               else
               {
                  param1.writeVarInt(this.timeLeft);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportToBuddyOfferMessage(param1);
      }
      
      public function deserializeAs_TeleportToBuddyOfferMessage(param1:ICustomDataInput) : void
      {
         this.dungeonId = param1.readVarUhShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of TeleportToBuddyOfferMessage.dungeonId.");
         }
         else
         {
            this.buddyId = param1.readVarUhInt();
            if(this.buddyId < 0)
            {
               throw new Error("Forbidden value (" + this.buddyId + ") on element of TeleportToBuddyOfferMessage.buddyId.");
            }
            else
            {
               this.timeLeft = param1.readVarUhInt();
               if(this.timeLeft < 0)
               {
                  throw new Error("Forbidden value (" + this.timeLeft + ") on element of TeleportToBuddyOfferMessage.timeLeft.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
