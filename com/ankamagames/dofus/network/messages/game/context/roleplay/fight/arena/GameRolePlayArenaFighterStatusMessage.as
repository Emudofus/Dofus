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
      
      public function initGameRolePlayArenaFighterStatusMessage(param1:int=0, param2:uint=0, param3:Boolean=false) : GameRolePlayArenaFighterStatusMessage {
         this.fightId = param1;
         this.playerId = param2;
         this.accepted = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.playerId = 0;
         this.accepted = false;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameRolePlayArenaFighterStatusMessage(param1);
      }
      
      public function serializeAs_GameRolePlayArenaFighterStatusMessage(param1:IDataOutput) : void {
         param1.writeInt(this.fightId);
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            param1.writeInt(this.playerId);
            param1.writeBoolean(this.accepted);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayArenaFighterStatusMessage(param1);
      }
      
      public function deserializeAs_GameRolePlayArenaFighterStatusMessage(param1:IDataInput) : void {
         this.fightId = param1.readInt();
         this.playerId = param1.readInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of GameRolePlayArenaFighterStatusMessage.playerId.");
         }
         else
         {
            this.accepted = param1.readBoolean();
            return;
         }
      }
   }
}
