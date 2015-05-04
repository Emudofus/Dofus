package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameRolePlayAttackMonsterRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayAttackMonsterRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6191;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var monsterGroupId:int = 0;
      
      override public function getMessageId() : uint
      {
         return 6191;
      }
      
      public function initGameRolePlayAttackMonsterRequestMessage(param1:int = 0) : GameRolePlayAttackMonsterRequestMessage
      {
         this.monsterGroupId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.monsterGroupId = 0;
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
         this.serializeAs_GameRolePlayAttackMonsterRequestMessage(param1);
      }
      
      public function serializeAs_GameRolePlayAttackMonsterRequestMessage(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.monsterGroupId);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayAttackMonsterRequestMessage(param1);
      }
      
      public function deserializeAs_GameRolePlayAttackMonsterRequestMessage(param1:ICustomDataInput) : void
      {
         this.monsterGroupId = param1.readInt();
      }
   }
}
