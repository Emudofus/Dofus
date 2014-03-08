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
      
      public function initGameRolePlayPlayerFightFriendlyRequestedMessage(fightId:uint=0, sourceId:uint=0, targetId:uint=0) : GameRolePlayPlayerFightFriendlyRequestedMessage {
         this.fightId = fightId;
         this.sourceId = sourceId;
         this.targetId = targetId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.sourceId = 0;
         this.targetId = 0;
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
         this.serializeAs_GameRolePlayPlayerFightFriendlyRequestedMessage(output);
      }
      
      public function serializeAs_GameRolePlayPlayerFightFriendlyRequestedMessage(output:IDataOutput) : void {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         else
         {
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
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayPlayerFightFriendlyRequestedMessage(input);
      }
      
      public function deserializeAs_GameRolePlayPlayerFightFriendlyRequestedMessage(input:IDataInput) : void {
         this.fightId = input.readInt();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameRolePlayPlayerFightFriendlyRequestedMessage.fightId.");
         }
         else
         {
            this.sourceId = input.readInt();
            if(this.sourceId < 0)
            {
               throw new Error("Forbidden value (" + this.sourceId + ") on element of GameRolePlayPlayerFightFriendlyRequestedMessage.sourceId.");
            }
            else
            {
               this.targetId = input.readInt();
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
