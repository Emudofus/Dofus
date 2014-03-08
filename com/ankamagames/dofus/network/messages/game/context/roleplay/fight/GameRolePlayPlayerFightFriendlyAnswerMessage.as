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
      
      public function initGameRolePlayPlayerFightFriendlyAnswerMessage(param1:int=0, param2:Boolean=false) : GameRolePlayPlayerFightFriendlyAnswerMessage {
         this.fightId = param1;
         this.accept = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.accept = false;
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
         this.serializeAs_GameRolePlayPlayerFightFriendlyAnswerMessage(param1);
      }
      
      public function serializeAs_GameRolePlayPlayerFightFriendlyAnswerMessage(param1:IDataOutput) : void {
         param1.writeInt(this.fightId);
         param1.writeBoolean(this.accept);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayPlayerFightFriendlyAnswerMessage(param1);
      }
      
      public function deserializeAs_GameRolePlayPlayerFightFriendlyAnswerMessage(param1:IDataInput) : void {
         this.fightId = param1.readInt();
         this.accept = param1.readBoolean();
      }
   }
}
