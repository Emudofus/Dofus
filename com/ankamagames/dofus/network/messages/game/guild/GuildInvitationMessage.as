package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GuildInvitationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildInvitationMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5551;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var targetId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5551;
      }
      
      public function initGuildInvitationMessage(param1:uint = 0) : GuildInvitationMessage
      {
         this.targetId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.targetId = 0;
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
         this.serializeAs_GuildInvitationMessage(param1);
      }
      
      public function serializeAs_GuildInvitationMessage(param1:ICustomDataOutput) : void
      {
         if(this.targetId < 0)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         else
         {
            param1.writeVarInt(this.targetId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInvitationMessage(param1);
      }
      
      public function deserializeAs_GuildInvitationMessage(param1:ICustomDataInput) : void
      {
         this.targetId = param1.readVarUhInt();
         if(this.targetId < 0)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of GuildInvitationMessage.targetId.");
         }
         else
         {
            return;
         }
      }
   }
}
