package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GuildHouseRemoveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildHouseRemoveMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6180;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var houseId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6180;
      }
      
      public function initGuildHouseRemoveMessage(param1:uint = 0) : GuildHouseRemoveMessage
      {
         this.houseId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.houseId = 0;
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
         this.serializeAs_GuildHouseRemoveMessage(param1);
      }
      
      public function serializeAs_GuildHouseRemoveMessage(param1:ICustomDataOutput) : void
      {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         else
         {
            param1.writeVarInt(this.houseId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GuildHouseRemoveMessage(param1);
      }
      
      public function deserializeAs_GuildHouseRemoveMessage(param1:ICustomDataInput) : void
      {
         this.houseId = param1.readVarUhInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of GuildHouseRemoveMessage.houseId.");
         }
         else
         {
            return;
         }
      }
   }
}
