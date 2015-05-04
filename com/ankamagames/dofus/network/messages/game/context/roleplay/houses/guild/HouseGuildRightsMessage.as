package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class HouseGuildRightsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function HouseGuildRightsMessage()
      {
         this.guildInfo = new GuildInformations();
         super();
      }
      
      public static const protocolId:uint = 5703;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var houseId:uint = 0;
      
      public var guildInfo:GuildInformations;
      
      public var rights:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5703;
      }
      
      public function initHouseGuildRightsMessage(param1:uint = 0, param2:GuildInformations = null, param3:uint = 0) : HouseGuildRightsMessage
      {
         this.houseId = param1;
         this.guildInfo = param2;
         this.rights = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.houseId = 0;
         this.guildInfo = new GuildInformations();
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
         this.serializeAs_HouseGuildRightsMessage(param1);
      }
      
      public function serializeAs_HouseGuildRightsMessage(param1:ICustomDataOutput) : void
      {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         else
         {
            param1.writeVarInt(this.houseId);
            this.guildInfo.serializeAs_GuildInformations(param1);
            if(this.rights < 0)
            {
               throw new Error("Forbidden value (" + this.rights + ") on element rights.");
            }
            else
            {
               param1.writeVarInt(this.rights);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_HouseGuildRightsMessage(param1);
      }
      
      public function deserializeAs_HouseGuildRightsMessage(param1:ICustomDataInput) : void
      {
         this.houseId = param1.readVarUhInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseGuildRightsMessage.houseId.");
         }
         else
         {
            this.guildInfo = new GuildInformations();
            this.guildInfo.deserialize(param1);
            this.rights = param1.readVarUhInt();
            if(this.rights < 0)
            {
               throw new Error("Forbidden value (" + this.rights + ") on element of HouseGuildRightsMessage.rights.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
