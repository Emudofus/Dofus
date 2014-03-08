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
      
      public function initGameRolePlayDelayedActionFinishedMessage(param1:int=0, param2:uint=0) : GameRolePlayDelayedActionFinishedMessage {
         this.delayedCharacterId = param1;
         this.delayTypeId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.delayedCharacterId = 0;
         this.delayTypeId = 0;
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
         this.serializeAs_GameRolePlayDelayedActionFinishedMessage(param1);
      }
      
      public function serializeAs_GameRolePlayDelayedActionFinishedMessage(param1:IDataOutput) : void {
         param1.writeInt(this.delayedCharacterId);
         param1.writeByte(this.delayTypeId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayDelayedActionFinishedMessage(param1);
      }
      
      public function deserializeAs_GameRolePlayDelayedActionFinishedMessage(param1:IDataInput) : void {
         this.delayedCharacterId = param1.readInt();
         this.delayTypeId = param1.readByte();
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
