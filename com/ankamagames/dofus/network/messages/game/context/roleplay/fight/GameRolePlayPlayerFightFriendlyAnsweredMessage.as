package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayPlayerFightFriendlyAnsweredMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayPlayerFightFriendlyAnsweredMessage() {
         super();
      }
      
      public static const protocolId:uint = 5733;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:int = 0;
      
      public var sourceId:uint = 0;
      
      public var targetId:uint = 0;
      
      public var accept:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5733;
      }
      
      public function initGameRolePlayPlayerFightFriendlyAnsweredMessage(param1:int=0, param2:uint=0, param3:uint=0, param4:Boolean=false) : GameRolePlayPlayerFightFriendlyAnsweredMessage {
         this.fightId = param1;
         this.sourceId = param2;
         this.targetId = param3;
         this.accept = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.sourceId = 0;
         this.targetId = 0;
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
         this.serializeAs_GameRolePlayPlayerFightFriendlyAnsweredMessage(param1);
      }
      
      public function serializeAs_GameRolePlayPlayerFightFriendlyAnsweredMessage(param1:IDataOutput) : void {
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
               param1.writeBoolean(this.accept);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayPlayerFightFriendlyAnsweredMessage(param1);
      }
      
      public function deserializeAs_GameRolePlayPlayerFightFriendlyAnsweredMessage(param1:IDataInput) : void {
         this.fightId = param1.readInt();
         this.sourceId = param1.readInt();
         if(this.sourceId < 0)
         {
            throw new Error("Forbidden value (" + this.sourceId + ") on element of GameRolePlayPlayerFightFriendlyAnsweredMessage.sourceId.");
         }
         else
         {
            this.targetId = param1.readInt();
            if(this.targetId < 0)
            {
               throw new Error("Forbidden value (" + this.targetId + ") on element of GameRolePlayPlayerFightFriendlyAnsweredMessage.targetId.");
            }
            else
            {
               this.accept = param1.readBoolean();
               return;
            }
         }
      }
   }
}
