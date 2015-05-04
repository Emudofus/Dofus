package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GuildLevelUpMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildLevelUpMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6062;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var newLevel:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6062;
      }
      
      public function initGuildLevelUpMessage(param1:uint = 0) : GuildLevelUpMessage
      {
         this.newLevel = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.newLevel = 0;
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
         this.serializeAs_GuildLevelUpMessage(param1);
      }
      
      public function serializeAs_GuildLevelUpMessage(param1:ICustomDataOutput) : void
      {
         if(this.newLevel < 2 || this.newLevel > 200)
         {
            throw new Error("Forbidden value (" + this.newLevel + ") on element newLevel.");
         }
         else
         {
            param1.writeByte(this.newLevel);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GuildLevelUpMessage(param1);
      }
      
      public function deserializeAs_GuildLevelUpMessage(param1:ICustomDataInput) : void
      {
         this.newLevel = param1.readUnsignedByte();
         if(this.newLevel < 2 || this.newLevel > 200)
         {
            throw new Error("Forbidden value (" + this.newLevel + ") on element of GuildLevelUpMessage.newLevel.");
         }
         else
         {
            return;
         }
      }
   }
}
