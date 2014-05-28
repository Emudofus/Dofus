package com.ankamagames.dofus.network.messages.game.context.roleplay.delay
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayDelayedActionFinishedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayDelayedActionFinishedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6150;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var delayedCharacterId:int = 0;
      
      public var delayTypeId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6150;
      }
      
      public function initGameRolePlayDelayedActionFinishedMessage(delayedCharacterId:int = 0, delayTypeId:uint = 0) : GameRolePlayDelayedActionFinishedMessage {
         this.delayedCharacterId = delayedCharacterId;
         this.delayTypeId = delayTypeId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.delayedCharacterId = 0;
         this.delayTypeId = 0;
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
         this.serializeAs_GameRolePlayDelayedActionFinishedMessage(output);
      }
      
      public function serializeAs_GameRolePlayDelayedActionFinishedMessage(output:IDataOutput) : void {
         output.writeInt(this.delayedCharacterId);
         output.writeByte(this.delayTypeId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayDelayedActionFinishedMessage(input);
      }
      
      public function deserializeAs_GameRolePlayDelayedActionFinishedMessage(input:IDataInput) : void {
         this.delayedCharacterId = input.readInt();
         this.delayTypeId = input.readByte();
         if(this.delayTypeId < 0)
         {
            throw new Error("Forbidden value (" + this.delayTypeId + ") on element of GameRolePlayDelayedActionFinishedMessage.delayTypeId.");
         }
         else
         {
            return;
         }
      }
   }
}
