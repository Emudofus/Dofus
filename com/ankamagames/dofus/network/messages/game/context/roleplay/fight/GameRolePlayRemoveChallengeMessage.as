package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameRolePlayRemoveChallengeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayRemoveChallengeMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 300;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var fightId:int = 0;
      
      override public function getMessageId() : uint
      {
         return 300;
      }
      
      public function initGameRolePlayRemoveChallengeMessage(param1:int = 0) : GameRolePlayRemoveChallengeMessage
      {
         this.fightId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fightId = 0;
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
         this.serializeAs_GameRolePlayRemoveChallengeMessage(param1);
      }
      
      public function serializeAs_GameRolePlayRemoveChallengeMessage(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.fightId);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayRemoveChallengeMessage(param1);
      }
      
      public function deserializeAs_GameRolePlayRemoveChallengeMessage(param1:ICustomDataInput) : void
      {
         this.fightId = param1.readInt();
      }
   }
}
