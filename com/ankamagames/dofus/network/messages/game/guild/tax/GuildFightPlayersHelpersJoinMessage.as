package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GuildFightPlayersHelpersJoinMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildFightPlayersHelpersJoinMessage()
      {
         this.playerInfo = new CharacterMinimalPlusLookInformations();
         super();
      }
      
      public static const protocolId:uint = 5720;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var fightId:uint = 0;
      
      public var playerInfo:CharacterMinimalPlusLookInformations;
      
      override public function getMessageId() : uint
      {
         return 5720;
      }
      
      public function initGuildFightPlayersHelpersJoinMessage(param1:uint = 0, param2:CharacterMinimalPlusLookInformations = null) : GuildFightPlayersHelpersJoinMessage
      {
         this.fightId = param1;
         this.playerInfo = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fightId = 0;
         this.playerInfo = new CharacterMinimalPlusLookInformations();
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
         this.serializeAs_GuildFightPlayersHelpersJoinMessage(param1);
      }
      
      public function serializeAs_GuildFightPlayersHelpersJoinMessage(param1:ICustomDataOutput) : void
      {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         else
         {
            param1.writeInt(this.fightId);
            this.playerInfo.serializeAs_CharacterMinimalPlusLookInformations(param1);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GuildFightPlayersHelpersJoinMessage(param1);
      }
      
      public function deserializeAs_GuildFightPlayersHelpersJoinMessage(param1:ICustomDataInput) : void
      {
         this.fightId = param1.readInt();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GuildFightPlayersHelpersJoinMessage.fightId.");
         }
         else
         {
            this.playerInfo = new CharacterMinimalPlusLookInformations();
            this.playerInfo.deserialize(param1);
            return;
         }
      }
   }
}
