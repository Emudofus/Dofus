package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayPlayerFightFriendlyRequestedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayPlayerFightFriendlyRequestedMessage() {
         super();
      }
      
      public static const protocolId:uint = 5937;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:uint = 0;
      
      public var sourceId:uint = 0;
      
      public var targetId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5937;
      }
      
      public function initGameRolePlayPlayerFightFriendlyRequestedMessage(param1:uint=0, param2:uint=0, param3:uint=0) : GameRolePlayPlayerFightFriendlyRequestedMessage {
         this.fightId = param1;
         this.sourceId = param2;
         this.targetId = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.sourceId = 0;
         this.targetId = 0;
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
         this.serializeAs_GameRolePlayPlayerFightFriendlyRequestedMessage(param1);
      }
      
      public function serializeAs_GameRolePlayPlayerFightFriendlyRequestedMessage(param1:IDataOutput) : void {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         else
         {
            param1.writeInt(this.fightId);
            if(this.sourceId < 0)
            {
               throw new Error("Forbidden value (" + this.sourceId + ") on element sourceId.");
            }
            else
            {
               param1.writeInt(this.sourceId);
               if(this.targetId < 0)
               {
                  throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
               }
               else
               {
                  param1.writeInt(this.targetId);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayPlayerFightFriendlyRequestedMessage(param1);
      }
      
      public function deserializeAs_GameRolePlayPlayerFightFriendlyRequestedMessage(param1:IDataInput) : void {
         this.fightId = param1.readInt();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameRolePlayPlayerFightFriendlyRequestedMessage.fightId.");
         }
         else
         {
            this.sourceId = param1.readInt();
            if(this.sourceId < 0)
            {
               throw new Error("Forbidden value (" + this.sourceId + ") on element of GameRolePlayPlayerFightFriendlyRequestedMessage.sourceId.");
            }
            else
            {
               this.targetId = param1.readInt();
               if(this.targetId < 0)
               {
                  throw new Error("Forbidden value (" + this.targetId + ") on element of GameRolePlayPlayerFightFriendlyRequestedMessage.targetId.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
