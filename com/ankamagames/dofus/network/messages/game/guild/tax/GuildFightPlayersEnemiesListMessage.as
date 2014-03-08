package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildFightPlayersEnemiesListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildFightPlayersEnemiesListMessage() {
         this.playerInfo = new Vector.<CharacterMinimalPlusLookInformations>();
         super();
      }
      
      public static const protocolId:uint = 5928;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:Number = 0;
      
      public var playerInfo:Vector.<CharacterMinimalPlusLookInformations>;
      
      override public function getMessageId() : uint {
         return 5928;
      }
      
      public function initGuildFightPlayersEnemiesListMessage(fightId:Number=0, playerInfo:Vector.<CharacterMinimalPlusLookInformations>=null) : GuildFightPlayersEnemiesListMessage {
         this.fightId = fightId;
         this.playerInfo = playerInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.playerInfo = new Vector.<CharacterMinimalPlusLookInformations>();
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
         this.serializeAs_GuildFightPlayersEnemiesListMessage(output);
      }
      
      public function serializeAs_GuildFightPlayersEnemiesListMessage(output:IDataOutput) : void {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         else
         {
            output.writeDouble(this.fightId);
            output.writeShort(this.playerInfo.length);
            _i2 = 0;
            while(_i2 < this.playerInfo.length)
            {
               (this.playerInfo[_i2] as CharacterMinimalPlusLookInformations).serializeAs_CharacterMinimalPlusLookInformations(output);
               _i2++;
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildFightPlayersEnemiesListMessage(input);
      }
      
      public function deserializeAs_GuildFightPlayersEnemiesListMessage(input:IDataInput) : void {
         var _item2:CharacterMinimalPlusLookInformations = null;
         this.fightId = input.readDouble();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GuildFightPlayersEnemiesListMessage.fightId.");
         }
         else
         {
            _playerInfoLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _playerInfoLen)
            {
               _item2 = new CharacterMinimalPlusLookInformations();
               _item2.deserialize(input);
               this.playerInfo.push(_item2);
               _i2++;
            }
            return;
         }
      }
   }
}
