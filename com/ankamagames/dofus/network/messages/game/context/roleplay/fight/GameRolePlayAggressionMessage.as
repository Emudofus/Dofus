package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameRolePlayAggressionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayAggressionMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6073;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var attackerId:uint = 0;
      
      public var defenderId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6073;
      }
      
      public function initGameRolePlayAggressionMessage(param1:uint = 0, param2:uint = 0) : GameRolePlayAggressionMessage
      {
         this.attackerId = param1;
         this.defenderId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.attackerId = 0;
         this.defenderId = 0;
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
         this.serializeAs_GameRolePlayAggressionMessage(param1);
      }
      
      public function serializeAs_GameRolePlayAggressionMessage(param1:ICustomDataOutput) : void
      {
         if(this.attackerId < 0)
         {
            throw new Error("Forbidden value (" + this.attackerId + ") on element attackerId.");
         }
         else
         {
            param1.writeVarInt(this.attackerId);
            if(this.defenderId < 0)
            {
               throw new Error("Forbidden value (" + this.defenderId + ") on element defenderId.");
            }
            else
            {
               param1.writeVarInt(this.defenderId);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayAggressionMessage(param1);
      }
      
      public function deserializeAs_GameRolePlayAggressionMessage(param1:ICustomDataInput) : void
      {
         this.attackerId = param1.readVarUhInt();
         if(this.attackerId < 0)
         {
            throw new Error("Forbidden value (" + this.attackerId + ") on element of GameRolePlayAggressionMessage.attackerId.");
         }
         else
         {
            this.defenderId = param1.readVarUhInt();
            if(this.defenderId < 0)
            {
               throw new Error("Forbidden value (" + this.defenderId + ") on element of GameRolePlayAggressionMessage.defenderId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
