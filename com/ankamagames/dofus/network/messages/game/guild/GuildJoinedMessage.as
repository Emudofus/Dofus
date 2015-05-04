package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GuildJoinedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildJoinedMessage()
      {
         this.guildInfo = new GuildInformations();
         super();
      }
      
      public static const protocolId:uint = 5564;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var guildInfo:GuildInformations;
      
      public var memberRights:uint = 0;
      
      public var enabled:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 5564;
      }
      
      public function initGuildJoinedMessage(param1:GuildInformations = null, param2:uint = 0, param3:Boolean = false) : GuildJoinedMessage
      {
         this.guildInfo = param1;
         this.memberRights = param2;
         this.enabled = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.guildInfo = new GuildInformations();
         this.enabled = false;
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
         this.serializeAs_GuildJoinedMessage(param1);
      }
      
      public function serializeAs_GuildJoinedMessage(param1:ICustomDataOutput) : void
      {
         this.guildInfo.serializeAs_GuildInformations(param1);
         if(this.memberRights < 0)
         {
            throw new Error("Forbidden value (" + this.memberRights + ") on element memberRights.");
         }
         else
         {
            param1.writeVarInt(this.memberRights);
            param1.writeBoolean(this.enabled);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GuildJoinedMessage(param1);
      }
      
      public function deserializeAs_GuildJoinedMessage(param1:ICustomDataInput) : void
      {
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserialize(param1);
         this.memberRights = param1.readVarUhInt();
         if(this.memberRights < 0)
         {
            throw new Error("Forbidden value (" + this.memberRights + ") on element of GuildJoinedMessage.memberRights.");
         }
         else
         {
            this.enabled = param1.readBoolean();
            return;
         }
      }
   }
}
