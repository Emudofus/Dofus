package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayArenaRegisterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayArenaRegisterMessage() {
         super();
      }
      
      public static const protocolId:uint = 6280;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var battleMode:uint = 3;
      
      override public function getMessageId() : uint {
         return 6280;
      }
      
      public function initGameRolePlayArenaRegisterMessage(battleMode:uint = 3) : GameRolePlayArenaRegisterMessage {
         this.battleMode = battleMode;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.battleMode = 3;
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
         this.serializeAs_GameRolePlayArenaRegisterMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaRegisterMessage(output:IDataOutput) : void {
         output.writeInt(this.battleMode);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayArenaRegisterMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaRegisterMessage(input:IDataInput) : void {
         this.battleMode = input.readInt();
         if(this.battleMode < 0)
         {
            throw new Error("Forbidden value (" + this.battleMode + ") on element of GameRolePlayArenaRegisterMessage.battleMode.");
         }
         else
         {
            return;
         }
      }
   }
}
