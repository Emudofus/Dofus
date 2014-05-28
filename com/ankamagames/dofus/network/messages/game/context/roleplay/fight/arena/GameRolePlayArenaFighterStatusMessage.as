package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayArenaFighterStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayArenaFighterStatusMessage() {
         super();
      }
      
      public static const protocolId:uint = 6281;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:int = 0;
      
      public var playerId:uint = 0;
      
      public var accepted:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6281;
      }
      
      public function initGameRolePlayArenaFighterStatusMessage(fightId:int = 0, playerId:uint = 0, accepted:Boolean = false) : GameRolePlayArenaFighterStatusMessage {
         this.fightId = fightId;
         this.playerId = playerId;
         this.accepted = accepted;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.playerId = 0;
         this.accepted = false;
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
         this.serializeAs_GameRolePlayArenaFighterStatusMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaFighterStatusMessage(output:IDataOutput) : void {
         output.writeInt(this.fightId);
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            output.writeInt(this.playerId);
            output.writeBoolean(this.accepted);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayArenaFighterStatusMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaFighterStatusMessage(input:IDataInput) : void {
         this.fightId = input.readInt();
         this.playerId = input.readInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of GameRolePlayArenaFighterStatusMessage.playerId.");
         }
         else
         {
            this.accepted = input.readBoolean();
            return;
         }
      }
   }
}
