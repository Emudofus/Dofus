package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GuildMembershipMessage extends GuildJoinedMessage implements INetworkMessage
   {
      
      public function GuildMembershipMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5835;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint
      {
         return 5835;
      }
      
      public function initGuildMembershipMessage(param1:GuildInformations = null, param2:uint = 0, param3:Boolean = false) : GuildMembershipMessage
      {
         super.initGuildJoinedMessage(param1,param2,param3);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GuildMembershipMessage(param1);
      }
      
      public function serializeAs_GuildMembershipMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GuildJoinedMessage(param1);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GuildMembershipMessage(param1);
      }
      
      public function deserializeAs_GuildMembershipMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
      }
   }
}
