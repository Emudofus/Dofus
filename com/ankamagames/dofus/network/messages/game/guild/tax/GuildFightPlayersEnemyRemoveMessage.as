package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildFightPlayersEnemyRemoveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildFightPlayersEnemyRemoveMessage() {
         super();
      }
      
      public static const protocolId:uint = 5929;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:Number = 0;
      
      public var playerId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5929;
      }
      
      public function initGuildFightPlayersEnemyRemoveMessage(fightId:Number=0, playerId:uint=0) : GuildFightPlayersEnemyRemoveMessage {
         this.fightId = fightId;
         this.playerId = playerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.playerId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GuildFightPlayersEnemyRemoveMessage(output);
      }
      
      public function serializeAs_GuildFightPlayersEnemyRemoveMessage(output:IDataOutput) : void {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         else
         {
            output.writeDouble(this.fightId);
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            else
            {
               output.writeInt(this.playerId);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildFightPlayersEnemyRemoveMessage(input);
      }
      
      public function deserializeAs_GuildFightPlayersEnemyRemoveMessage(input:IDataInput) : void {
         this.fightId = input.readDouble();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GuildFightPlayersEnemyRemoveMessage.fightId.");
         }
         else
         {
            this.playerId = input.readInt();
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element of GuildFightPlayersEnemyRemoveMessage.playerId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
