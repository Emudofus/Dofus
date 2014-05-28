package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayAggressionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayAggressionMessage() {
         super();
      }
      
      public static const protocolId:uint = 6073;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var attackerId:uint = 0;
      
      public var defenderId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6073;
      }
      
      public function initGameRolePlayAggressionMessage(attackerId:uint = 0, defenderId:uint = 0) : GameRolePlayAggressionMessage {
         this.attackerId = attackerId;
         this.defenderId = defenderId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.attackerId = 0;
         this.defenderId = 0;
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
         this.serializeAs_GameRolePlayAggressionMessage(output);
      }
      
      public function serializeAs_GameRolePlayAggressionMessage(output:IDataOutput) : void {
         if(this.attackerId < 0)
         {
            throw new Error("Forbidden value (" + this.attackerId + ") on element attackerId.");
         }
         else
         {
            output.writeInt(this.attackerId);
            if(this.defenderId < 0)
            {
               throw new Error("Forbidden value (" + this.defenderId + ") on element defenderId.");
            }
            else
            {
               output.writeInt(this.defenderId);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayAggressionMessage(input);
      }
      
      public function deserializeAs_GameRolePlayAggressionMessage(input:IDataInput) : void {
         this.attackerId = input.readInt();
         if(this.attackerId < 0)
         {
            throw new Error("Forbidden value (" + this.attackerId + ") on element of GameRolePlayAggressionMessage.attackerId.");
         }
         else
         {
            this.defenderId = input.readInt();
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
