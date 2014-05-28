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
      
      public function initGameRolePlayPlayerFightFriendlyAnsweredMessage(fightId:int = 0, sourceId:uint = 0, targetId:uint = 0, accept:Boolean = false) : GameRolePlayPlayerFightFriendlyAnsweredMessage {
         this.fightId = fightId;
         this.sourceId = sourceId;
         this.targetId = targetId;
         this.accept = accept;
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
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameRolePlayPlayerFightFriendlyAnsweredMessage(output);
      }
      
      public function serializeAs_GameRolePlayPlayerFightFriendlyAnsweredMessage(output:IDataOutput) : void {
         output.writeInt(this.fightId);
         if(this.sourceId < 0)
         {
            throw new Error("Forbidden value (" + this.sourceId + ") on element sourceId.");
         }
         else
         {
            output.writeInt(this.sourceId);
            if(this.targetId < 0)
            {
               throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
            }
            else
            {
               output.writeInt(this.targetId);
               output.writeBoolean(this.accept);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayPlayerFightFriendlyAnsweredMessage(input);
      }
      
      public function deserializeAs_GameRolePlayPlayerFightFriendlyAnsweredMessage(input:IDataInput) : void {
         this.fightId = input.readInt();
         this.sourceId = input.readInt();
         if(this.sourceId < 0)
         {
            throw new Error("Forbidden value (" + this.sourceId + ") on element of GameRolePlayPlayerFightFriendlyAnsweredMessage.sourceId.");
         }
         else
         {
            this.targetId = input.readInt();
            if(this.targetId < 0)
            {
               throw new Error("Forbidden value (" + this.targetId + ") on element of GameRolePlayPlayerFightFriendlyAnsweredMessage.targetId.");
            }
            else
            {
               this.accept = input.readBoolean();
               return;
            }
         }
      }
   }
}
