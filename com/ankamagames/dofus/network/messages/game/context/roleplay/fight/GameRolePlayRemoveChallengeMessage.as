package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayRemoveChallengeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayRemoveChallengeMessage() {
         super();
      }
      
      public static const protocolId:uint = 300;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:int = 0;
      
      override public function getMessageId() : uint {
         return 300;
      }
      
      public function initGameRolePlayRemoveChallengeMessage(fightId:int=0) : GameRolePlayRemoveChallengeMessage {
         this.fightId = fightId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
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
         this.serializeAs_GameRolePlayRemoveChallengeMessage(output);
      }
      
      public function serializeAs_GameRolePlayRemoveChallengeMessage(output:IDataOutput) : void {
         output.writeInt(this.fightId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayRemoveChallengeMessage(input);
      }
      
      public function deserializeAs_GameRolePlayRemoveChallengeMessage(input:IDataInput) : void {
         this.fightId = input.readInt();
      }
   }
}
