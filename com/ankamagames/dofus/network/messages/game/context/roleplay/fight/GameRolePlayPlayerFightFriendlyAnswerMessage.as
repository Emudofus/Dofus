package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayPlayerFightFriendlyAnswerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayPlayerFightFriendlyAnswerMessage() {
         super();
      }
      
      public static const protocolId:uint = 5732;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:int = 0;
      
      public var accept:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5732;
      }
      
      public function initGameRolePlayPlayerFightFriendlyAnswerMessage(fightId:int = 0, accept:Boolean = false) : GameRolePlayPlayerFightFriendlyAnswerMessage {
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
         this.serializeAs_GameRolePlayPlayerFightFriendlyAnswerMessage(output);
      }
      
      public function serializeAs_GameRolePlayPlayerFightFriendlyAnswerMessage(output:IDataOutput) : void {
         output.writeInt(this.fightId);
         output.writeBoolean(this.accept);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayPlayerFightFriendlyAnswerMessage(input);
      }
      
      public function deserializeAs_GameRolePlayPlayerFightFriendlyAnswerMessage(input:IDataInput) : void {
         this.fightId = input.readInt();
         this.accept = input.readBoolean();
      }
   }
}
