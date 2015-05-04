package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GuildFightLeaveRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildFightLeaveRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5715;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var taxCollectorId:uint = 0;
      
      public var characterId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5715;
      }
      
      public function initGuildFightLeaveRequestMessage(param1:uint = 0, param2:uint = 0) : GuildFightLeaveRequestMessage
      {
         this.taxCollectorId = param1;
         this.characterId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.taxCollectorId = 0;
         this.characterId = 0;
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
         this.serializeAs_GuildFightLeaveRequestMessage(param1);
      }
      
      public function serializeAs_GuildFightLeaveRequestMessage(param1:ICustomDataOutput) : void
      {
         if(this.taxCollectorId < 0)
         {
            throw new Error("Forbidden value (" + this.taxCollectorId + ") on element taxCollectorId.");
         }
         else
         {
            param1.writeInt(this.taxCollectorId);
            if(this.characterId < 0)
            {
               throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
            }
            else
            {
               param1.writeVarInt(this.characterId);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GuildFightLeaveRequestMessage(param1);
      }
      
      public function deserializeAs_GuildFightLeaveRequestMessage(param1:ICustomDataInput) : void
      {
         this.taxCollectorId = param1.readInt();
         if(this.taxCollectorId < 0)
         {
            throw new Error("Forbidden value (" + this.taxCollectorId + ") on element of GuildFightLeaveRequestMessage.taxCollectorId.");
         }
         else
         {
            this.characterId = param1.readVarUhInt();
            if(this.characterId < 0)
            {
               throw new Error("Forbidden value (" + this.characterId + ") on element of GuildFightLeaveRequestMessage.characterId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
