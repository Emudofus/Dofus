package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameRolePlayArenaFightPropositionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayArenaFightPropositionMessage()
      {
         this.alliesId = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 6276;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var fightId:uint = 0;
      
      public var alliesId:Vector.<int>;
      
      public var duration:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6276;
      }
      
      public function initGameRolePlayArenaFightPropositionMessage(param1:uint = 0, param2:Vector.<int> = null, param3:uint = 0) : GameRolePlayArenaFightPropositionMessage
      {
         this.fightId = param1;
         this.alliesId = param2;
         this.duration = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fightId = 0;
         this.alliesId = new Vector.<int>();
         this.duration = 0;
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
         this.serializeAs_GameRolePlayArenaFightPropositionMessage(param1);
      }
      
      public function serializeAs_GameRolePlayArenaFightPropositionMessage(param1:ICustomDataOutput) : void
      {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         else
         {
            param1.writeInt(this.fightId);
            param1.writeShort(this.alliesId.length);
            var _loc2_:uint = 0;
            while(_loc2_ < this.alliesId.length)
            {
               param1.writeInt(this.alliesId[_loc2_]);
               _loc2_++;
            }
            if(this.duration < 0)
            {
               throw new Error("Forbidden value (" + this.duration + ") on element duration.");
            }
            else
            {
               param1.writeVarShort(this.duration);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayArenaFightPropositionMessage(param1);
      }
      
      public function deserializeAs_GameRolePlayArenaFightPropositionMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:* = 0;
         this.fightId = param1.readInt();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameRolePlayArenaFightPropositionMessage.fightId.");
         }
         else
         {
            var _loc2_:uint = param1.readUnsignedShort();
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = param1.readInt();
               this.alliesId.push(_loc4_);
               _loc3_++;
            }
            this.duration = param1.readVarUhShort();
            if(this.duration < 0)
            {
               throw new Error("Forbidden value (" + this.duration + ") on element of GameRolePlayArenaFightPropositionMessage.duration.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
