package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayArenaFightAnswerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayArenaFightAnswerMessage() {
         super();
      }
      
      public static const protocolId:uint = 6279;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:int = 0;
      
      public var accept:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6279;
      }
      
      public function initGameRolePlayArenaFightAnswerMessage(fightId:int = 0, accept:Boolean = false) : GameRolePlayArenaFightAnswerMessage {
         this.fightId = fightId;
         this.accept = accept;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.accept = false;
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
         this.serializeAs_GameRolePlayArenaFightAnswerMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaFightAnswerMessage(output:IDataOutput) : void {
         output.writeInt(this.fightId);
         output.writeBoolean(this.accept);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayArenaFightAnswerMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaFightAnswerMessage(input:IDataInput) : void {
         this.fightId = input.readInt();
         this.accept = input.readBoolean();
      }
   }
}
