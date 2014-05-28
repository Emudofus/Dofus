package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayShowChallengeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayShowChallengeMessage() {
         this.commonsInfos = new FightCommonInformations();
         super();
      }
      
      public static const protocolId:uint = 301;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var commonsInfos:FightCommonInformations;
      
      override public function getMessageId() : uint {
         return 301;
      }
      
      public function initGameRolePlayShowChallengeMessage(commonsInfos:FightCommonInformations = null) : GameRolePlayShowChallengeMessage {
         this.commonsInfos = commonsInfos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.commonsInfos = new FightCommonInformations();
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
         this.serializeAs_GameRolePlayShowChallengeMessage(output);
      }
      
      public function serializeAs_GameRolePlayShowChallengeMessage(output:IDataOutput) : void {
         this.commonsInfos.serializeAs_FightCommonInformations(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayShowChallengeMessage(input);
      }
      
      public function deserializeAs_GameRolePlayShowChallengeMessage(input:IDataInput) : void {
         this.commonsInfos = new FightCommonInformations();
         this.commonsInfos.deserialize(input);
      }
   }
}
