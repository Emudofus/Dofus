package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AllianceGuildLeavingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceGuildLeavingMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6399;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var kicked:Boolean = false;
      
      public var guildId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6399;
      }
      
      public function initAllianceGuildLeavingMessage(param1:Boolean = false, param2:uint = 0) : AllianceGuildLeavingMessage
      {
         this.kicked = param1;
         this.guildId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.kicked = false;
         this.guildId = 0;
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
         this.serializeAs_AllianceGuildLeavingMessage(param1);
      }
      
      public function serializeAs_AllianceGuildLeavingMessage(param1:ICustomDataOutput) : void
      {
         param1.writeBoolean(this.kicked);
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
         }
         else
         {
            param1.writeVarInt(this.guildId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceGuildLeavingMessage(param1);
      }
      
      public function deserializeAs_AllianceGuildLeavingMessage(param1:ICustomDataInput) : void
      {
         this.kicked = param1.readBoolean();
         this.guildId = param1.readVarUhInt();
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element of AllianceGuildLeavingMessage.guildId.");
         }
         else
         {
            return;
         }
      }
   }
}
