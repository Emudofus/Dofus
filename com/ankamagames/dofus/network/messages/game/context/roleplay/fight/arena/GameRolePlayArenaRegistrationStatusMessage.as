package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayArenaRegistrationStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayArenaRegistrationStatusMessage() {
         super();
      }
      
      public static const protocolId:uint = 6284;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var registered:Boolean = false;
      
      public var step:uint = 0;
      
      public var battleMode:uint = 3;
      
      override public function getMessageId() : uint {
         return 6284;
      }
      
      public function initGameRolePlayArenaRegistrationStatusMessage(registered:Boolean=false, step:uint=0, battleMode:uint=3) : GameRolePlayArenaRegistrationStatusMessage {
         this.registered = registered;
         this.step = step;
         this.battleMode = battleMode;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.registered = false;
         this.step = 0;
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
         this.serializeAs_GameRolePlayArenaRegistrationStatusMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaRegistrationStatusMessage(output:IDataOutput) : void {
         output.writeBoolean(this.registered);
         output.writeByte(this.step);
         output.writeInt(this.battleMode);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayArenaRegistrationStatusMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaRegistrationStatusMessage(input:IDataInput) : void {
         this.registered = input.readBoolean();
         this.step = input.readByte();
         if(this.step < 0)
         {
            throw new Error("Forbidden value (" + this.step + ") on element of GameRolePlayArenaRegistrationStatusMessage.step.");
         }
         else
         {
            this.battleMode = input.readInt();
            if(this.battleMode < 0)
            {
               throw new Error("Forbidden value (" + this.battleMode + ") on element of GameRolePlayArenaRegistrationStatusMessage.battleMode.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
